# AWS Monitoring API Deployment 🚀

Automates AWS infrastructure provisioning and deploys a containerized Python monitoring API across **dev** and **prod** environments.

---

## 🎯 Overview

**Pipeline:**

```
Terraform → Ansible → Docker → API accessible on port 80
```

* **Terraform**: Creates EC2 + Security Groups for dev/prod.
* **Ansible**: Installs Docker, clones repo, installs dependencies, builds & runs API container.
* **Docker**: Runs `monitoring-api-container` on port 80 with auto-restart.

**Result:** Running monitoring API accessible at `http://<instance-ip>`.

---

## 🏗️ Architecture

```
AWS Cloud (us-east-1)
┌───────────────┐
│ Security Group │
│ SSH (22)      │
│ HTTP (80)     │
└─────┬─────────┘
      ↓
┌───────────────┐
│  EC2 Instance │
│ Docker Engine │
│ monitoring-   │
│ api-container │
└───────────────┘
```

---

## 📋 Prerequisites

* Terraform ≥ 1.2.0
* Ansible ≥ 2.9
* AWS CLI configured
* SSH keys: `~/.ssh/dev-key.pem`, `~/.ssh/prod-key.pem`

---

## 🚀 Deployment

1. **Clone repo**

```bash
git clone <repo-url>
cd <repo-name>
```

2. **Configure AWS**

```bash
aws configure
```

3. **Deploy Infrastructure**

```bash
cd environments/dev
terraform init
terraform apply
# repeat for prod
```

4. **Get Instance IP**

```bash
terraform output
# or AWS Console / CLI
```

5. **Create Ansible Inventory (`hosts.ini`)**

```ini
[dev]
<dev-ip> ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/dev-key.pem
```

6. **Deploy API**

```bash
ansible-playbook -i hosts.ini deploy.yaml
```

7. **Access API**

```bash
http://<instance-ip>
curl http://<instance-ip>
```

---

## 🔧 Notes

* EC2: Amazon Linux 2, t2.micro
* Docker container: `monitoring-api-container` → port 80
* Dev & Prod environments separated
* Terraform outputs: instance IDs, security group IDs

---

## 🧹 Cleanup

```bash
terraform destroy
# remove SSH keys if needed
```

---

## 🔒 Security Tips

* Restrict SSH access to your IP
* Use HTTPS instead of HTTP
* Store Terraform state remotely (S3)
* Use AWS Secrets Manager for sensitive data

---

## 📚 Resources

* [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* [Ansible Docs](https://docs.ansible.com/)
* [Docker Docs](https://docs.docker.com/)
* [AWS EC2 Guide](https://docs.aws.amazon.com/ec2/)

