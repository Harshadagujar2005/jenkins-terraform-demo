#!/usr/bin/env bash
# Installs Java, Git, Node.js 20, Jenkins and Terraform on Ubuntu/Debian (works in WSL2).
# Run with:  bash scripts/install-tools.sh
set -e

echo "==> Installing Java, Git and helpers"
sudo apt update
sudo apt install -y fontconfig openjdk-21-jre git unzip wget curl gnupg lsb-release ca-certificates

echo "==> Installing Node.js 20 (Ubuntu's default Node is too old for 'npm test')"
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

echo "==> Installing Jenkins"
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install -y jenkins

echo "==> Installing Terraform"
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor --yes -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null
sudo apt update
sudo apt install -y terraform

echo "==> Starting Jenkins"
# Restart so Jenkins picks up the newly installed node and terraform
if [ -d /run/systemd/system ]; then
  sudo systemctl enable jenkins
  sudo systemctl reset-failed jenkins 2>/dev/null || true
  sudo systemctl restart jenkins
else
  sudo service jenkins restart || sudo service jenkins start
fi

echo "==> Versions (take a screenshot of this)"
java -version
git --version
node -v
npm -v
terraform -version

echo
echo "Jenkins should now be running at http://localhost:8080 (give it 1-2 minutes to start)"
echo "Waiting for Jenkins to create the admin password (up to 2 minutes)..."
for i in $(seq 1 24); do
  if sudo test -f /var/lib/jenkins/secrets/initialAdminPassword; then break; fi
  sleep 5
done
echo "Admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword || echo "Not ready yet. Wait a minute and run: sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
