# Installer et configurer un serveur Swarm avec un reverse proxy Traefik et le service d'authentification Authelia

Il est nécessaire d'avoir installé Azure CLI.

## Infrastructure nécessaire

Dans ce cas, nous allons utiliser le cloud Azure.

### Les VMs

Nous allons utiliser 5 VMs sous Ubuntu 22.04.

Pour cela, nous utiliserons Terraform pour déployer l'infrastructure. Nous allons donc créer 1 VNet, 5 subnets, 5 NIC, 3 NSG et 5 IP publiques.

## Terraform

1. Ajouter la clé GPG et le dépôt HashiCorp :
    ```bash
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install terraform
    ```

2. Aller dans le répertoire où se trouve `main.tf` :
    ```bash
    terraform init
    terraform plan
    terraform apply
    ```

## Ansible

1. Installer Ansible :
    ```bash
    sudo apt install ansible
    ```

2. Créer les rôles ou les récupérer depuis Docker :
    - Authelia
    - Docker
    - Swarm
    - Tools
    - Myapp

    Pour créer un rôle :
    ```bash
    ansible-galaxy init "nom_du_role"
    ```

3. Configurer les playbooks Ansible pour exécuter tous les rôles :
    ```yaml
    - name: Init Swarm cluster
      hosts: all
      become: yes
      roles:
        - docker
        - swarm
        - tools
        - myapp
        - authelia
    ```

### Détails des rôles

- **Authelia** : Dans le rôle Authelia, vous devez installer les services nécessaires, créer les répertoires et copier les fichiers depuis le dossier `files`, où se trouvent la configuration d'Authelia, la base de données utilisateur et le Docker Compose pour Authelia. Le Docker Compose installe Authelia, le configure et installe également Whoami pour des tests.

- **Docker** : Le rôle Docker consiste uniquement à installer Docker, les clés GPG et les dépendances, qui sont variabilisées dans le dossier `defaults`.

- **Myapp** : Ce rôle concerne un serveur web Nginx.

- **Swarm** : Le rôle Swarm se contente d'un fichier dans `tasks` qui rejoint les nœuds et initialise le cluster Swarm.

- **Tools** : Ce rôle installe Visualizer et Traefik en mode Swarm.

### Configuration de l'accès SSH

Vérifiez que le fichier `hosts` créé par Terraform est lié au dossier des clés SSH et vérifiez les permissions.

### Lancer le playbook

Il ne reste plus qu'à lancer le playbook :
    ```bash
    ansible-playbook -i hosts blobu.yaml
    ```
