# Jenkins CI/CD Pipeline with Terraform Infrastructure Provisioning

A sample Node.js app, a Jenkins pipeline (`Jenkinsfile`) and a Terraform configuration that defines an AWS EC2 instance.

Jenkins pulls the code from GitHub, builds and tests it, then runs `terraform init`, `validate` and `plan`. After a manual approval it runs `terraform apply` to create the EC2 instance.

## Project layout

```
jenkins-terraform-demo/
├── app.js               sample application
├── test.js              unit tests (node:test)
├── package.json         build and test scripts
├── Jenkinsfile          pipeline with AWS (init, validate, plan, approval, apply)
├── Jenkinsfile.no-aws   pipeline without AWS (init and validate only)
├── .gitignore
├── terraform/
│   ├── main.tf          provider, AMI lookup, security group, EC2 instance
│   ├── variables.tf     region and instance type
│   └── outputs.tf       instance ID and public IP
└── scripts/
    ├── install-tools.sh     installs Java, Git, Node, Jenkins, Terraform on Ubuntu
    └── push-to-github.sh    pushes this folder to your GitHub repo
```

## Quick start

1. Create an empty repo on GitHub named `jenkins-terraform-demo`.
2. Push this folder: `bash scripts/push-to-github.sh https://github.com/<you>/jenkins-terraform-demo.git`
3. On an Ubuntu machine: `bash scripts/install-tools.sh`
4. Open http://localhost:8080, finish setup, add the `aws-creds` credential, create a Pipeline job pointing at your repo.
5. Click Build Now.

No AWS account? Replace `Jenkinsfile` with `Jenkinsfile.no-aws` before pushing.

## Local checks

```
npm run build
npm test
cd terraform && terraform init && terraform validate
```

## Clean up

Destroy the EC2 instance after your demo to avoid charges:

```
cd terraform && terraform destroy
```
