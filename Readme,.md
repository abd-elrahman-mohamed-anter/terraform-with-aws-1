# Terraform AWS EC2 Flask Deployment

This repository demonstrates how to deploy a **Flask web application** on an **AWS EC2 instance** using **Terraform**.

---

## 🔹 Project Structure

```

terraform-ec2-flask/
├── main.tf           # Terraform configuration
├── variables.tf      # Terraform variables
├── userdata.sh       # Script to install Python, Flask and run the app
├── terraform.tfvars  # Local file with sensitive values (not included in GitHub)
└── .gitignore        # Ignores sensitive files

````

---

## 🔹 Features

- Deploys an EC2 instance in a chosen region.
- Creates a Security Group allowing:
  - SSH (22)
  - HTTP (80)
  - Flask app (port 80)
- Installs Python3 and Flask automatically.
- Runs a simple Flask web app accessible via the EC2 public IP.

---

## 🔹 Setup Instructions

1. **Clone the repository**

```bash
git clone <your-repo-url>
cd terraform-ec2-flask
````

2. **Edit Terraform variables**

Update `main.tf` or create a local `terraform.tfvars` with your own values:

```hcl
aws_region        = "<your region>"
ami_id            = "<your ami id>"
instance_type     = "<your instance type>"
key_name          = "<your key name>"
availability_zone = "<your availability zone>"
ec2_name          = "<your EC2 name>"
```

> **Note:** Do **not** commit `terraform.tfvars` if it contains sensitive information.

3. **Initialize Terraform**

```bash
terraform init
```

4. **Plan the deployment**

```bash
terraform plan
```

5. **Apply the deployment**

```bash
terraform apply -auto-approve
```

6. **Access the Flask app**

After deployment, get the public IP:

```bash
terraform output ec2_public_ip
```

Open your browser:

```
http://<EC2-Public-IP>/
```

---

## 🔹 Notes

* The Flask app runs on **port 80**, so `sudo` is used in `userdata.sh`.
* Security Group is pre-configured to allow necessary ports.
* This setup is for **demo and learning purposes**. For production, use a proper WSGI server and configure HTTPS.

---

## 🔹 .gitignore

Make sure the following files are ignored:

```
*.tfstate
*.tfstate.*
terraform.tfvars
.terraform/
```

This prevents sensitive data from being pushed to GitHub.

```
