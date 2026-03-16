AWS Monitoring Platform

Ce projet déploie une plateforme de monitoring complète sur une machine virtuelle AWS avec les composants suivants :

Prometheus : collecte des métriques systèmes et applications

Grafana : visualisation des métriques et logs

Loki : centralisation et recherche des logs

Promtail : collecte des logs pour Loki

Node Exporter : collecte des métriques systèmes (CPU, RAM, disque…)

Le déploiement est automatisé avec Ansible et Docker Compose.

Prérequis

Une VM Ubuntu sur AWS avec accès SSH

Docker et Docker Compose installés (ou via Ansible)

Python et Ansible installés sur ta machine locale

Port ouvert pour :

3000 → Grafana

9090 → Prometheus

3100 → Loki

9100 → Node Exporter

Installation / Déploiement
1. Cloner le projet
git clone <TON_REPO_GITHUB>
cd aws-monitoring-platform/ansible
2. Modifier hosts.ini pour mettre l’IP de ta VM
[monitoring]
<IP_VM> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/terraform-key
3. Déployer la stack Docker avec Ansible
a) Installer Docker et Docker Compose sur la VM
ansible-playbook -i hosts.ini monitoring.yml
b) Déployer Prometheus, Grafana, Loki, Node Exporter
ansible-playbook -i hosts.ini deploy-monitoring.yml
Accéder aux services
Service	URL
Grafana	http://<IP_VM>:3000
Prometheus	http://<IP_VM>:9090
Loki	http://<IP_VM>:3100
Node Exporter	métriques exposées sur 9100 (via Prometheus)
Configuration

Les fichiers de configuration sont disponibles dans ansible/files/ :

prometheus.yml

loki-config.yaml

docker-compose.yml

Pour mettre à jour la configuration, modifiez les fichiers localement et relancez :

ansible-playbook -i hosts.ini deploy-monitoring.yml
Bonnes pratiques

Node Exporter peut être exécuté soit via Docker, soit en tant que service systemd.

Les ports doivent être ouverts dans AWS Security Group pour accéder aux services depuis l’extérieur.

Pour Loki et Promtail, vérifiez que les volumes et chemins existent et ont les permissions correctes.

Améliorations possibles

Ajouter Alertmanager pour les alertes Prometheus

Ajouter des dashboards Grafana supplémentaires

Centraliser les logs d’autres applications via Promtail

Licence

MIT License © 2026
