#!/usr/bin/env bash
# Pushes this folder to a NEW, EMPTY GitHub repo.
# Usage:  bash scripts/push-to-github.sh https://github.com/<your-username>/jenkins-terraform-demo.git
set -e

if [ -z "$1" ]; then
  echo "Usage: bash scripts/push-to-github.sh <github-repo-url>"
  exit 1
fi

git init
git branch -M main
git add .
git commit -m "Add app, Jenkinsfile and Terraform config"
git remote add origin "$1"
git push -u origin main
