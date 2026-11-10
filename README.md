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
├── docs/
│   ├── Activity2_Jenkins_Terraform_Report.pdf   submission report 
│   └── screenshots/     16 screenshots of the pipeline run
└── logs/                validation output and Jenkins console excerpts
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

## Results and evidence

- Jenkins job `jenkins-terraform-pipeline` pulls this repository, runs Build, Test and the Terraform stages, and build #1 finished with `Finished: SUCCESS`.
- `terraform validate`: `Success! The configuration is valid.`
- `terraform plan`: `Plan: 2 to add, 0 to change, 0 to destroy.`
- After approval, Terraform Apply created the EC2 instance `jenkins-terraform-demo` in ap-south-1 (Mumbai).

Full write-up: [docs/Activity2_Jenkins_Terraform_Report.pdf](docs/Activity2_Jenkins_Terraform_Report.pdf)
Demo video: [Google Drive](https://drive.google.com/file/d/1yws64dU_p1YTXRY54Fz3O1W-gdbXgs0x/view?usp=sharing)
Screenshots: [docs/screenshots/](docs/screenshots/)
Logs: [logs/](logs/)

AWS access keys are stored only in the Jenkins credential store (ID `aws-creds`) and are not part of this repository. Screenshots that showed a key ID have it hidden.
