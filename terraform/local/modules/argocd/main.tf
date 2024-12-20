resource "kubernetes_namespace_v1" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = false
  version          = "7.3.11"

  values = [file("./modules/argocd/values/argocd.yml")]

  depends_on = [kubernetes_namespace_v1.argocd]
}

resource "kubernetes_secret_v1" "argocd_notifications_secret" {
  metadata {
    name      = "argocd-notifications-secret"
    namespace = "argocd"
  }

  type = "Opaque"

  data = {
    slack-token = var.slack_token
  }

  depends_on = [helm_release.argocd]
}

resource "kubernetes_manifest" "argocd_notifications_cm" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "context"                          = <<-EOT
      argocdUrl: http://localhost:8080
      
      EOT
      "service.slack"                    = <<-EOT
      token: $slack-token
      
      EOT
      "template.app-created"             = <<-EOT
      email:
        subject: Application {{.app.metadata.name}} has been created.
      message: Application {{.app.metadata.name}} has been created.
      teams:
        title: Application {{.app.metadata.name}} has been created.
      
      EOT
      "template.app-deleted"             = <<-EOT
      email:
        subject: Application {{.app.metadata.name}} has been deleted.
      message: Application {{.app.metadata.name}} has been deleted.
      teams:
        title: Application {{.app.metadata.name}} has been deleted.
      
      EOT
      "template.app-deployed"            = <<-EOT
      email:
        subject: New version of an application {{.app.metadata.name}} is up and running.
      message: |
        {{if eq .serviceType "slack"}}:white_check_mark:{{end}} New version of *{{.app.metadata.name}}* is deployed.
      slack:
        attachments: |
          [{
            "color": "#18be52",
            "fields": [
            {
              "title": "Author",
              "value": "{{(call .repo.GetCommitMetadata .app.status.sync.revision).Author}}",
              "short": true
            },
            {
              "title": "Message",
              "value": "{{(call .repo.GetCommitMetadata .app.status.sync.revision).Message}}",
              "short": true
            },
            {
              "title": "Repository",
              "value": "{{.app.spec.source.repoURL}}",
              "short": true
            }
            {{range $index, $image := .app.status.summary.images}}
              {{if not $index}},{{end}}
              {{if $index}},{{end}}
              {
                "title": "Version",
                "value": "{{$image}}",
                "short": true
              }
            {{end}}
            ]
          }]
        deliveryPolicy: Post
        groupingKey: ""
        notifyBroadcast: false
      teams:
        facts: |
          [{
            "name": "Sync Status",
            "value": "{{.app.status.sync.status}}"
          },
          {
            "name": "Repository",
            "value": "{{.app.spec.source.repoURL}}"
          },
          {
            "name": "Revision",
            "value": "{{.app.status.sync.revision}}"
          }
          {{range $index, $c := .app.status.conditions}}
            {{if not $index}},{{end}}
            {{if $index}},{{end}}
            {
              "name": "{{$c.type}}",
              "value": "{{$c.message}}"
            }
          {{end}}
          ]
        potentialAction: |-
          [{
            "@type":"OpenUri",
            "name":"Operation Application",
            "targets":[{
              "os":"default",
              "uri":"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}"
            }]
          },
          {
            "@type":"OpenUri",
            "name":"Open Repository",
            "targets":[{
              "os":"default",
              "uri":"{{.app.spec.source.repoURL | call .repo.RepoURLToHTTPS}}"
            }]
          }]
        themeColor: '#000080'
        title: New version of an application {{.app.metadata.name}} is up and running.
      
      EOT
      "template.app-health-degraded"     = <<-EOT
      email:
        subject: Application {{.app.metadata.name}} has degraded.
      message: |
        {{if eq .serviceType "slack"}}:exclamation:{{end}} Application {{.app.metadata.name}} has degraded.
        Application details: {{.context.argocdUrl}}/applications/{{.app.metadata.name}}.
      slack:
        attachments: |
          [{
            "title": "{{ .app.metadata.name}}",
            "title_link": "{{.context.argocdUrl}}/applications/{{.app.metadata.name}}",
            "color": "#f4c030",
            "fields": [
            {
              "title": "Health Status",
              "value": "{{.app.status.health.status}}",
              "short": true
            },
            {
              "title": "Repository",
              "value": "{{.app.spec.source.repoURL}}",
              "short": true
            }
            {{range $index, $c := .app.status.conditions}}
            {{if not $index}},{{end}}
            {{if $index}},{{end}}
            {
              "title": "{{$c.type}}",
              "value": "{{$c.message}}",
              "short": true
            }
            {{end}}
            ]
          }]
        deliveryPolicy: Post
        groupingKey: ""
        notifyBroadcast: false
      teams:
        facts: |
          [{
            "name": "Health Status",
            "value": "{{.app.status.health.status}}"
          },
          {
            "name": "Repository",
            "value": "{{.app.spec.source.repoURL}}"
          }
          {{range $index, $c := .app.status.conditions}}
            {{if not $index}},{{end}}
            {{if $index}},{{end}}
            {
              "name": "{{$c.type}}",
              "value": "{{$c.message}}"
            }
          {{end}}
          ]
        potentialAction: |
          [{
            "@type":"OpenUri",
            "name":"Open Application",
            "targets":[{
              "os":"default",
              "uri":"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}"
            }]
          },
          {
            "@type":"OpenUri",
            "name":"Open Repository",
            "targets":[{
              "os":"default",
              "uri":"{{.app.spec.source.repoURL | call .repo.RepoURLToHTTPS}}"
            }]
          }]
        themeColor: '#FF0000'
        title: Application {{.app.metadata.name}} has degraded.
      
      EOT
      "template.app-sync-failed"         = <<-EOT
      email:
        subject: Failed to sync application {{.app.metadata.name}}.
      message: |
        {{if eq .serviceType "slack"}}:exclamation:{{end}}  The sync operation of application {{.app.metadata.name}} has failed at {{.app.status.operationState.finishedAt}} with the following error: {{.app.status.operationState.message}}
        Sync operation details are available at: {{.context.argocdUrl}}/applications/{{.app.metadata.name}}?operation=true .
      slack:
        attachments: |
          [{
            "title": "{{ .app.metadata.name}}",
            "title_link":"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}",
            "color": "#E96D76",
            "fields": [
            {
              "title": "Sync Status",
              "value": "{{.app.status.sync.status}}",
              "short": true
            },
            {
              "title": "Repository",
              "value": "{{.app.spec.source.repoURL}}",
              "short": true
            }
            {{range $index, $c := .app.status.conditions}}
            {{if not $index}},{{end}}
            {{if $index}},{{end}}
            {
              "title": "{{$c.type}}",
              "value": "{{$c.message}}",
              "short": true
            }
            {{end}}
            ]
          }]
        deliveryPolicy: Post
        groupingKey: ""
        notifyBroadcast: false
      teams:
        facts: |
          [{
            "name": "Sync Status",
            "value": "{{.app.status.sync.status}}"
          },
          {
            "name": "Failed at",
            "value": "{{.app.status.operationState.finishedAt}}"
          },
          {
            "name": "Repository",
            "value": "{{.app.spec.source.repoURL}}"
          }
          {{range $index, $c := .app.status.conditions}}
            {{if not $index}},{{end}}
            {{if $index}},{{end}}
            {
              "name": "{{$c.type}}",
              "value": "{{$c.message}}"
            }
          {{end}}
          ]
        potentialAction: |-
          [{
            "@type":"OpenUri",
            "name":"Open Operation",
            "targets":[{
              "os":"default",
              "uri":"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}?operation=true"
            }]
          },
          {
            "@type":"OpenUri",
            "name":"Open Repository",
            "targets":[{
              "os":"default",
              "uri":"{{.app.spec.source.repoURL | call .repo.RepoURLToHTTPS}}"
            }]
          }]
        themeColor: '#FF0000'
        title: Failed to sync application {{.app.metadata.name}}.
      
      EOT
      "template.app-sync-running"        = <<-EOT
      email:
        subject: Start syncing application {{.app.metadata.name}}.
      message: |
        The sync operation of application {{.app.metadata.name}} has started at {{.app.status.operationState.startedAt}}.
        Sync operation details are available at: {{.context.argocdUrl}}/applications/{{.app.metadata.name}}?operation=true .
      slack:
        attachments: |
          [{
            "title": "{{ .app.metadata.name}}",
            "title_link":"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}",
            "color": "#0DADEA",
            "fields": [
            {
              "title": "Sync Status",
              "value": "{{.app.status.sync.status}}",
              "short": true
            },
            {
              "title": "Repository",
              "value": "{{.app.spec.source.repoURL}}",
              "short": true
            }
            {{range $index, $c := .app.status.conditions}}
            {{if not $index}},{{end}}
            {{if $index}},{{end}}
            {
              "title": "{{$c.type}}",
              "value": "{{$c.message}}",
              "short": true
            }
            {{end}}
            ]
          }]
        deliveryPolicy: Post
        groupingKey: ""
        notifyBroadcast: false
      teams:
        facts: |
          [{
            "name": "Sync Status",
            "value": "{{.app.status.sync.status}}"
          },
          {
            "name": "Started at",
            "value": "{{.app.status.operationState.startedAt}}"
          },
          {
            "name": "Repository",
            "value": "{{.app.spec.source.repoURL}}"
          }
          {{range $index, $c := .app.status.conditions}}
            {{if not $index}},{{end}}
            {{if $index}},{{end}}
            {
              "name": "{{$c.type}}",
              "value": "{{$c.message}}"
            }
          {{end}}
          ]
        potentialAction: |-
          [{
            "@type":"OpenUri",
            "name":"Open Operation",
            "targets":[{
              "os":"default",
              "uri":"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}?operation=true"
            }]
          },
          {
            "@type":"OpenUri",
            "name":"Open Repository",
            "targets":[{
              "os":"default",
              "uri":"{{.app.spec.source.repoURL | call .repo.RepoURLToHTTPS}}"
            }]
          }]
        title: Start syncing application {{.app.metadata.name}}.
      
      EOT
      "template.app-sync-status-unknown" = <<-EOT
      email:
        subject: Application {{.app.metadata.name}} sync status is 'Unknown'
      message: |
        {{if eq .serviceType "slack"}}:exclamation:{{end}} Application {{.app.metadata.name}} sync is 'Unknown'.
        Application details: {{.context.argocdUrl}}/applications/{{.app.metadata.name}}.
        {{if ne .serviceType "slack"}}
        {{range $c := .app.status.conditions}}
            * {{$c.message}}
        {{end}}
        {{end}}
      slack:
        attachments: |
          [{
            "title": "{{ .app.metadata.name}}",
            "title_link":"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}",
            "color": "#E96D76",
            "fields": [
            {
              "title": "Sync Status",
              "value": "{{.app.status.sync.status}}",
              "short": true
            },
            {
              "title": "Repository",
              "value": "{{.app.spec.source.repoURL}}",
              "short": true
            }
            {{range $index, $c := .app.status.conditions}}
            {{if not $index}},{{end}}
            {{if $index}},{{end}}
            {
              "title": "{{$c.type}}",
              "value": "{{$c.message}}",
              "short": true
            }
            {{end}}
            ]
          }]
        deliveryPolicy: Post
        groupingKey: ""
        notifyBroadcast: false
      teams:
        facts: |
          [{
            "name": "Sync Status",
            "value": "{{.app.status.sync.status}}"
          },
          {
            "name": "Repository",
            "value": "{{.app.spec.source.repoURL}}"
          }
          {{range $index, $c := .app.status.conditions}}
            {{if not $index}},{{end}}
            {{if $index}},{{end}}
            {
              "name": "{{$c.type}}",
              "value": "{{$c.message}}"
            }
          {{end}}
          ]
        potentialAction: |-
          [{
            "@type":"OpenUri",
            "name":"Open Application",
            "targets":[{
              "os":"default",
              "uri":"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}"
            }]
          },
          {
            "@type":"OpenUri",
            "name":"Open Repository",
            "targets":[{
              "os":"default",
              "uri":"{{.app.spec.source.repoURL | call .repo.RepoURLToHTTPS}}"
            }]
          }]
        title: Application {{.app.metadata.name}} sync status is 'Unknown'
      
      EOT
      "template.app-sync-succeeded"      = <<-EOT
      email:
        subject: Application {{.app.metadata.name}} has been successfully synced.
      message: |
        {{if eq .serviceType "slack"}}:white_check_mark:{{end}} Application {{.app.metadata.name}} has been successfully synced at {{.app.status.operationState.finishedAt}}.
        Sync operation details are available at: {{.context.argocdUrl}}/applications/{{.app.metadata.name}}?operation=true .
      slack:
        attachments: |
          [{
            "title": "{{ .app.metadata.name}}",
            "title_link":"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}",
            "color": "#18be52",
            "fields": [
            {
              "title": "Sync Status",
              "value": "{{.app.status.sync.status}}",
              "short": true
            },
            {
              "title": "Repository",
              "value": "{{.app.spec.source.repoURL}}",
              "short": true
            }
            {{range $index, $c := .app.status.conditions}}
            {{if not $index}},{{end}}
            {{if $index}},{{end}}
            {
              "title": "{{$c.type}}",
              "value": "{{$c.message}}",
              "short": true
            }
            {{end}}
            ]
          }]
        deliveryPolicy: Post
        groupingKey: ""
        notifyBroadcast: false
      teams:
        facts: |
          [{
            "name": "Sync Status",
            "value": "{{.app.status.sync.status}}"
          },
          {
            "name": "Synced at",
            "value": "{{.app.status.operationState.finishedAt}}"
          },
          {
            "name": "Repository",
            "value": "{{.app.spec.source.repoURL}}"
          }
          {{range $index, $c := .app.status.conditions}}
            {{if not $index}},{{end}}
            {{if $index}},{{end}}
            {
              "name": "{{$c.type}}",
              "value": "{{$c.message}}"
            }
          {{end}}
          ]
        potentialAction: |-
          [{
            "@type":"OpenUri",
            "name":"Operation Details",
            "targets":[{
              "os":"default",
              "uri":"{{.context.argocdUrl}}/applications/{{.app.metadata.name}}?operation=true"
            }]
          },
          {
            "@type":"OpenUri",
            "name":"Open Repository",
            "targets":[{
              "os":"default",
              "uri":"{{.app.spec.source.repoURL | call .repo.RepoURLToHTTPS}}"
            }]
          }]
        themeColor: '#000080'
        title: Application {{.app.metadata.name}} has been successfully synced
      
      EOT
      "trigger.on-created"               = <<-EOT
      - description: Application is created.
        oncePer: app.metadata.name
        send:
        - app-created
        when: "true"
      
      EOT
      "trigger.on-deleted"               = <<-EOT
      - description: Application is deleted.
        oncePer: app.metadata.name
        send:
        - app-deleted
        when: app.metadata.deletionTimestamp != nil
      
      EOT
      "trigger.on-deployed"              = <<-EOT
      - description: Application is synced and healthy. Triggered once per commit.
        oncePer: app.status.operationState.syncResult.revision
        send:
        - app-deployed
        when: app.status.operationState.phase in ['Succeeded'] and app.status.health.status
          == 'Healthy'
      
      EOT
      "trigger.on-health-degraded"       = <<-EOT
      - description: Application has degraded
        send:
        - app-health-degraded
        when: app.status.health.status == 'Degraded'
      
      EOT
      "trigger.on-sync-failed"           = <<-EOT
      - description: Application syncing has failed
        send:
        - app-sync-failed
        when: app.status.operationState.phase in ['Error', 'Failed']
      
      EOT
      "trigger.on-sync-running"          = <<-EOT
      - description: Application is being synced
        send:
        - app-sync-running
        when: app.status.operationState.phase in ['Running']
      
      EOT
      "trigger.on-sync-status-unknown"   = <<-EOT
      - description: Application status is 'Unknown'
        send:
        - app-sync-status-unknown
        when: app.status.sync.status == 'Unknown'
      
      EOT
      "trigger.on-sync-succeeded"        = <<-EOT
      - description: Application syncing has succeeded
        send:
        - app-sync-succeeded
        when: app.status.operationState.phase in ['Succeeded']
      
      EOT
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "name"      = "argocd-notifications-cm"
      "namespace" = "argocd"
    }
  }

  depends_on = [helm_release.argocd]
}

