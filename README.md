# AWS Monitoring Platform

Une plateforme de monitoring complète déployée sur une VM AWS, utilisant Docker compose , Ansible, Prometheus, Grafana, Loki et Node Exporter.

## 🏗 Architecture de la stack


<img width="587" height="476" alt="image" src="https://github.com/user-attachments/assets/63aaa3ec-d015-439d-a772-8bc7d71cd366" />


Node Exporter → collecte les métriques systèmes (CPU, RAM, disque…)

Prometheus → scrape les métriques et les stocke

Grafana → dashboard et visualisation des métriques et logs

Loki → centralisation des logs

Promtail → collecte et envoie les logs à Loki

## ⚙️ Stack technique

- **Terraform** : Provisionnement automatique d'une instance EC2 sur AWS.
- **Ansible** : Configuration complète de l’instance (Docker, monitoring stack, etc.).
- **Docker Compose** : Déploiement de la stack de monitoring (promtail, prometheus, grafana, node exporter et loki).
- **Prometheus** : Collecte des métriques système via node_exporter.
- **Loki** : Centralisation des logs système via promtail.
- **Grafana** : Visualisation des logs et métriques.

Ports ouverts dans AWS Security Group :

`3000` → Grafana

`9090` → Prometheus

`3100` → Loki

`9100` → Node Exporter

`9080` → Promtail

## 🚀 Déploiement
1. Cloner le projet
`git clone <TON_REPO_GITHUB>
cd aws-monitoring-platform/ansible`
2. Modifier l’inventaire hosts.ini
[monitoring]
`<IP_VM> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/terraform-key`
3. Installer Docker & Docker Compose sur la VM
`ansible-playbook -i hosts.ini monitoring.yml`
4. Déployer la stack monitoring
`ansible-playbook -i hosts.ini deploy-monitoring.yml`

## 🌐 Accès aux services
Service	URL
Grafana	`http://<IP_VM>:3000`
Prometheus	`http://<IP_VM>:9090`
Loki	`http://<IP_VM>:3100`
Node Exporter	exposé sur le port 9100 via Prometheus.
Promtail	exposé sur le port 9080 pour loki.

## 📊 Exemple de requêtes PromQL pour Grafana

CPU Usage :

`100 - (avg by(instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)`

RAM Usage :

`(node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes) / node_memory_MemTotal_bytes * 100`

Disk Usage :

`(node_filesystem_size_bytes - node_filesystem_free_bytes) / node_filesystem_size_bytes * 100 `

## 💡 Bonnes pratiques

Vérifiez les droits des applications (777 , 572, etc).

Assurer l’ouverture des ports nécessaires dans AWS Security Group de manières sécurisés.

## 🔧 Améliorations possibles

Ajouter Alertmanager pour gérer les alertes Prometheus.

Créer des dashboards Grafana supplémentaires préconfiguré.

CI/CD sur git ou via jenkins.

## 📝 Licence

MIT License © 2026
