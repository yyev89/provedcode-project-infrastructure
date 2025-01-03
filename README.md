# ProvedCode Infrastructure

*This is a project prototype used with educational purposes during complete DevOps course in SoftServe Academy in 2024. All copyrights belong to SoftServe.*

**ProvedCode** — brand new social media for talents — employees of any age and level of experience and employers, who looking for them. Talents post descriptions, links of their work and more on their profile, showing themselves in all their glory to employer, who read their achievements, put "KUDOS" - like, and ultimately connect with those, who liked the most.

[ProvedCode Backend](https://github.com/yyev89/provedcode-project-backend)

[ProvedCode Frontend](https://github.com/yyev89/provedcode-project-frontend)

### Repository includes:

- `kubernetes` directory with two versions of application yaml manifests (both for running locally and on cloud)
- `terraform` directory with two versions of infrastructure: local and AWS cloud (EKS cluster with RDS, S3 and ELB services)
- `workflows` directory with Actions workflows: two for changing docker images tag triggered from other repositories (frontend or backend), and validation of the terraform code with security check
- `docker-compose.yml` file for running application locally with Docker (requires `.env` file, example included)

### Tools & Technologies used:
AWS, Terraform, Kubernetes, Helm, Git, Docker, nginx, PostgreSQL, checkov, Datadog, ArgoCD, Qodana, traefik, terraform-docs, tfk8s