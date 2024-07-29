# intaller et cofnigure un serveur swarm avec un reverse proxy traefik et le service d'authentification Authelia


il est necessaire d'avoir installer azure cli 
## L'infrastructure necessaire dans se cas on vas utiliser le cloud azure

### les vms

nous allons utilisez 5 vms sous ubuntu 22.04

pour cela on utilise terraform pour deployer l'infra on vas crer donc 1 vnet 5 subnet 5nic 3nsg et 5 ip publique 

## terraform
      wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
      echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
      sudo apt update && sudo apt install terraform

allez dans le repoertoir ou se situe le main.tf

    terraform init
    terraform plan
    terraform apply


## ansible 
    sudo apt install ansible
il nous faut creer les roles ou les recupere dans le docker \
-authelia\
-docker\
-swarm\
-tools\
-myapp\
``ansible-galaxy init "nom du role"``\
on configure les playbook ansible pour qu'il execute tout les roles 

     - name: init swarm cluster
       hosts: all
       become: yes
       roles: 
       - docker
       - swarm
       - tools
       - myapp
       - authelia

pour le role authelia dans le tasks on install les service necessaire on creer les directory et on copie les fichier qui se trouve dans le dossier files et dasn se dossier on y retrouve la config de authelia le l'user database et le docker compose pour authelia, le docker compose install authelia le configure et install aussi whoami pour des test \
\
pour le role docker il y a que le contenu du dossier tasks qui est modifier dans lequelle on vient tout simplement installer docker les cles gpg et les depandance qui se trouve variabiliser dans le dossier default\
\
pour le role myapp il sagit l'a d'un serveur web nginx\
\
pour le role swarm il y a que un fichier dans le tasks qui join les node et initialise le cluster swarm \
\
pour le role tools il sagit de l'installation de visualizer et traefik en mode swarm\
\
si vous jetez un oeil dans le fichier hosts creer par terraform vous vous rendrez compte que il est lier a un dossier des cles ssh verifiez les permisison\
\
il ne reste plus qu'a lancer le playbook 
``ansible-playbook -i hosts blobu.yaml``