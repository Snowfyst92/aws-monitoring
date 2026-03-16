# AWS Monitoring Infrastructure — Terraform

Projet personnel d’automatisation d’infrastructure cloud avec déploiement d’une stack de monitoring sur AWS à l’aide de Terraform. Ce projet permet de provisionner automatiquement les ressources nécessaires pour monitorer un environnement AWS de manière reproductible.

---

## ⚙️ Stack Technique

- **Terraform** : Provisionnement automatique des ressources AWS (CloudWatch, SNS, IAM, etc.)  
- **AWS CloudWatch** : Surveillance des métriques système et applications  
- **AWS SNS** : Notifications d’alertes par email possible  
- **AWS IAM** : Gestion des permissions pour les ressources AWS  

> Ce projet est conçu pour être déployé **localement via Terraform**, sans configuration CI/CD pour le moment.

---

## 🏗️ Architecture de l’infrastructure

Voici une représentation simplifiée de la stack AWS déployée par Terraform :
-
                 +------------------+
                 |   Node Exporter  |
                 | (Linux Metrics)  |
                 +--------+---------+
                          |
                          v
                 +------------------+
                 |    Prometheus    |
                 | (Scrape Metrics) |
                 +--------+---------+
                          |
            +-------------+-------------+
            |                           |
            v                           v
+--------------------+        +--------------------+
|      Grafana       |        |   Alertmanager     |
| (Visualize Metrics |        | (Optional: alerts |
|  & Logs Dashboard) |        |  via Slack/Email) |
+--------------------+        +--------------------+
            ^
            |
            |
   +------------------+
   |      Loki        |
   | (Centralized Logs)|
   +---------+--------+
             ^
             |
   +------------------+
   |     Promtail     |
   | (Collect & push  |
   |   logs to Loki)  |
   +------------------+



> Le diagramme montre les composants principaux : métriques et alarmes CloudWatch envoyées via SNS et contrôlées par des rôles IAM.

---

## 🚀 Déploiement manuel

1. Récupérer le projet sur votre machine :  
``bash
git clone git@github.com:Snowfyst92/aws-monitoring.git
cd aws-monitoring
``
Initialiser Terraform :

cd terraform-aws
terraform init

Appliquer la configuration pour créer l’infrastructure :

terraform apply -auto-approve

Toutes les ressources AWS nécessaires au monitoring seront créées automatiquement.

🔐 Configuration des variables

Le projet utilise des variables Terraform définies dans variables.tf.
Exemple de fichier terraform.tfvars :

aws_region  = "eu-west-1"
alert_email = "alerts@example.com"
environment = "dev"
📊 Fonctionnalités principales

Provisionnement automatique d’alertes CloudWatch (CPU, réseau, ressources critiques)

Notifications d’alertes via SNS

Dashboards AWS CloudWatch pour visualiser les métriques

Gestion reproductible et versionnée de l’infrastructure

🛠️ Bonnes pratiques

Ne versionnez pas les fichiers générés par Terraform :

.terraform/
*.tfstate*

Ajoutez ces lignes dans un fichier .gitignore pour éviter de pousser des fichiers volumineux.

💬 À propos

Cette infrastructure permet de monitorer efficacement un environnement AWS tout en restant simple et reproductible.
Le projet peut être étendu facilement pour intégrer d’autres services AWS ou des solutions de visualisation supplémentaires comme Grafana ou Prometheus.Monitoring d'instances déployable via AWS 
