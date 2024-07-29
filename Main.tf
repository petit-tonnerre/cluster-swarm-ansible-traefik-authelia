

#--------------------------creer le ressource groupe
resource "azurerm_resource_group" "RG" {
  name     = "RG_WBO_Clust-swarm_rev-Proxy" 
  location = "francecentral"
}
#-----------------------------debut config reseaux
#------------------------------------creer le vnet
resource "azurerm_virtual_network" "Vnet" {
  name                = "VN_WBO_Clust-swarm_rev-Proxy"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
}
#-------------------------------------creer le subnet
resource "azurerm_subnet" "Subnet1" {
  name                 = "SN1_WBO_Clust-swarm_rev-Proxy"
  service_endpoints    = ["Microsoft.Storage"]
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

#---------------------------creer une ip public dynamic
resource "azurerm_public_ip" "public_ip" {
  name                = "IP-PUB_WBO_Clust-swarm_rev-Proxy"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "public_ip2" {
  name                = "IP2-PUB_WBO_Clust-swarm_rev-Proxy"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "public_ip3" {
  name                = "IP3-PUB_WBO_Clust-swarm_rev-Proxy"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "public_ip4" {
  name                = "IP4-PUB_WBO_Clust-swarm_rev-Proxy"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "public_ip5" {
  name                = "IP5-PUB_WBO_Clust-swarm_rev-Proxy"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  allocation_method   = "Dynamic"
}

#--------------------------creer une nic

resource "azurerm_network_interface" "NIC" {
  name                = "NIC1_WBO_Clust-swarm_rev-Proxy"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "IP_WBO_Clust-swarm_rev-Proxy"
    subnet_id                     = azurerm_subnet.Subnet1.id
    public_ip_address_id = azurerm_public_ip.public_ip.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.10"
  }
        depends_on = [
    azurerm_subnet.Subnet1
    ]
}
resource "azurerm_network_interface" "NIC2" {
  name                = "NIC2_WBO_Clust-swarm_rev-Proxy"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "IP_WBO_Clust-swarm_rev-Proxy"
    subnet_id                     = azurerm_subnet.Subnet1.id
    public_ip_address_id = azurerm_public_ip.public_ip2.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.20"
  }
          depends_on = [
    azurerm_subnet.Subnet1
    ]
}
resource "azurerm_network_interface" "NIC3" {
  name                = "NIC3_WBO_Clust-swarm_rev-Proxy"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "IP_WBO_Clust-swarm_rev-Proxy"
    subnet_id                     = azurerm_subnet.Subnet1.id
    public_ip_address_id = azurerm_public_ip.public_ip3.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.30"
  }
          depends_on = [
    azurerm_subnet.Subnet1
    ]
}

resource "azurerm_network_interface" "NIC4" {
  name                = "NIC4_WBO_Clust-swarm_rev-Proxy"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "IP_WBO_Clust-swarm_rev-Proxy"
    subnet_id                     = azurerm_subnet.Subnet1.id
    public_ip_address_id = azurerm_public_ip.public_ip4.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.40"
  }
          depends_on = [
    azurerm_subnet.Subnet1
    ]
}

resource "azurerm_network_interface" "NIC5" {
  name                = "NIC5_WBO_Clust-swarm_rev-Proxy"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "IP_WBO_Clust-swarm_rev-Proxy"
    subnet_id                     = azurerm_subnet.Subnet1.id
    public_ip_address_id = azurerm_public_ip.public_ip5.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.50"
  }
          depends_on = [
    azurerm_subnet.Subnet1
    ]
}

#-------------------------------creer le nsg avec comme regle 22 80 d'ouvert 
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg_WBO_Clust-swarm_rev-Proxy"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name


 security_rule {
    name                       = "ALL_in"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "0-65535"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ALL_OUT"
    priority                   = 222
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "0-65535"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_ssh_sg"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_http"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_http_OUT"
    priority                   = 300
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
   security_rule {
    name                       = "allow_Traefik"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  security_rule {
    name                       = "allow_Traefik_OUT"
    priority                   = 301
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
  
  security_rule {
    name                       = "allow_swarm"
    priority                   = 202
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2377"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_swarm_OUT"
    priority                   = 302
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2377"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


}

resource "azurerm_network_security_group" "nsg2" {
  name                = "nsg2_WBO_Clust-swarm_rev-Proxy"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

 security_rule {
    name                       = "ALL_in"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "0-65535"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ALL_OUT"
    priority                   = 222
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "0-65535"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_ssh_sg"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_http"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_http_OUT"
    priority                   = 300
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
    security_rule {
    name                       = "allow_swarm"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2377"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_swarm_OUT"
    priority                   = 301
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2377"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "nsg3" {
  name                = "nsg3_WBO_Clust-swarm_rev-Proxy"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
 security_rule {
    name                       = "ALL_in"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "0-65535"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ALL_OUT"
    priority                   = 222
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "0-65535"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_ssh_sg"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_http"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_http_OUT"
    priority                   = 300
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
    security_rule {
    name                       = "allow_swarm"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2377"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_swarm_OUT"
    priority                   = 301
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2377"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


#------------------fait le liens entre le nsg et la nic
resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id      = azurerm_network_interface.NIC.id
  network_security_group_id = azurerm_network_security_group.nsg.id
      depends_on = [
    azurerm_network_interface.NIC, azurerm_network_security_group.nsg
    ]
}

resource "azurerm_network_interface_security_group_association" "association2" {
  network_interface_id      = azurerm_network_interface.NIC2.id
  network_security_group_id = azurerm_network_security_group.nsg2.id
        depends_on = [
    azurerm_network_interface.NIC2, azurerm_network_security_group.nsg2
    ]
}

resource "azurerm_network_interface_security_group_association" "association3" {
  network_interface_id      = azurerm_network_interface.NIC3.id
  network_security_group_id = azurerm_network_security_group.nsg3.id
        depends_on = [
      azurerm_network_interface.NIC3, azurerm_network_security_group.nsg3
    ]
}

resource "azurerm_network_interface_security_group_association" "association4" {
  network_interface_id      = azurerm_network_interface.NIC4.id
  network_security_group_id = azurerm_network_security_group.nsg3.id
        depends_on = [
      azurerm_network_interface.NIC3, azurerm_network_security_group.nsg3
    ]
}

resource "azurerm_network_interface_security_group_association" "association5" {
  network_interface_id      = azurerm_network_interface.NIC5.id
  network_security_group_id = azurerm_network_security_group.nsg3.id
        depends_on = [
      azurerm_network_interface.NIC3, azurerm_network_security_group.nsg3
    ]
}
#------------------------------fin config reseaux

#------------------Creer une vm Ubuntu2204
resource "azurerm_linux_virtual_machine" "VM1" {
  name                = "VM-WBO-Clust-swarm-rev-Proxy-Node-manager1"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  disable_password_authentication = true
#------------------donne l'interface a la vm
  network_interface_ids = [
    azurerm_network_interface.NIC.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.ssh.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
    depends_on = [
    azurerm_network_interface_security_group_association.association
    ]
}

resource "azurerm_linux_virtual_machine" "VM2" {
  name                = "VM-WBO-Clust-swarm-rev-Proxy-Node-manager2"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  disable_password_authentication = true
#------------------donne l'interface a la vm
  network_interface_ids = [
    azurerm_network_interface.NIC2.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.ssh.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
    depends_on = [
    azurerm_network_interface_security_group_association.association2
    ]
}

resource "azurerm_linux_virtual_machine" "VM3" {
  name                = "VM-WBO-Clust-swarm-rev-Proxy-Node-manager3"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  disable_password_authentication = true
#------------------donne l'interface a la vm
  network_interface_ids = [
    azurerm_network_interface.NIC3.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.ssh.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
    depends_on = [
    azurerm_network_interface_security_group_association.association3
    ]
}

resource "azurerm_linux_virtual_machine" "VM4" {
  name                = "VM-WBO-Clust-swarm-rev-Proxy-Node1"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  disable_password_authentication = true
#------------------donne l'interface a la vm
  network_interface_ids = [
    azurerm_network_interface.NIC4.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.ssh.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
    depends_on = [
    azurerm_network_interface_security_group_association.association3
    ]
}

resource "azurerm_linux_virtual_machine" "VM5" {
  name                = "VM-WBO-Clust-swarm-rev-Proxy-Node2"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  disable_password_authentication = true
#------------------donne l'interface a la vm
  network_interface_ids = [
    azurerm_network_interface.NIC5.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.ssh.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
    depends_on = [
    azurerm_network_interface_security_group_association.association3
    ]
}

#------------------definie l'algorythm pour la creation de cles prive 
resource "tls_private_key" "ssh"{
  algorithm = "RSA"
  rsa_bits = 4096
}
#------------------affiche la cles prive
output "private_key" {
  value     = tls_private_key.ssh.private_key_pem
  sensitive = true
}
#------------------affiche une cles public
output "public_key" {
  value = tls_private_key.ssh.public_key_openssh
}

#------------------affiche l'ip public de la vm
output "public_ip" {
  value = "${azurerm_public_ip.public_ip.ip_address}"
}

#------------------recupere l'ip public de la vm pour la mettre dasn un fichier name.txt
resource "null_resource" "recup_IP" {
  provisioner "local-exec" {
    command = "az vm show -d -g ${azurerm_resource_group.RG.name} -n ${azurerm_linux_virtual_machine.VM1.name} --query publicIps -o tsv >> ansible/name.txt"
  }
  #----------attends que la vm se soit creer 
  depends_on = [
    azurerm_linux_virtual_machine.VM1
  ]
}

resource "null_resource" "recup_IP2" {
  provisioner "local-exec" {
    command = "az vm show -d -g ${azurerm_resource_group.RG.name} -n ${azurerm_linux_virtual_machine.VM2.name} --query publicIps -o tsv >> ansible/name.txt"
  }
  #----------attends que la vm se soit creer 
  depends_on = [
    azurerm_linux_virtual_machine.VM2
  ]
}

resource "null_resource" "recup_IP3" {
  provisioner "local-exec" {
    command = "az vm show -d -g ${azurerm_resource_group.RG.name} -n ${azurerm_linux_virtual_machine.VM3.name} --query publicIps -o tsv >> ansible/name.txt"
  }
  #----------attends que la vm se soit creer 
  depends_on = [
    azurerm_linux_virtual_machine.VM3
  ]
}
resource "null_resource" "recup_IP4" {
  provisioner "local-exec" {
    command = "az vm show -d -g ${azurerm_resource_group.RG.name} -n ${azurerm_linux_virtual_machine.VM4.name} --query publicIps -o tsv >> ansible/name.txt"
  }
  #----------attends que la vm se soit creer 
  depends_on = [
    azurerm_linux_virtual_machine.VM4
  ]
}
resource "null_resource" "recup_IP5" {
  provisioner "local-exec" {
    command = "az vm show -d -g ${azurerm_resource_group.RG.name} -n ${azurerm_linux_virtual_machine.VM5.name} --query publicIps -o tsv >> ansible/name.txt"
  }
  #----------attends que la vm se soit creer 
  depends_on = [
    azurerm_linux_virtual_machine.VM5
  ]
}

#----------sauvegarde les cles prive et public
resource "null_resource" "save_ssh_keys" {
  provisioner "local-exec" {
    command = <<EOT
      mkdir ansible/sshkey
      echo "${tls_private_key.ssh.private_key_pem}" > ansible/sshkey/private_key.pem
      echo "${tls_private_key.ssh.private_key_pem}" > ansible/sshkey/private_key2.pem
      echo "${tls_private_key.ssh.private_key_pem}" > ansible/sshkey/private_key3.pem
      echo "${tls_private_key.ssh.private_key_pem}" > ansible/sshkey/private_key4.pem
      echo "${tls_private_key.ssh.private_key_pem}" > ansible/sshkey/private_key5.pem
      echo "${tls_private_key.ssh.public_key_openssh}" > ansible/sshkey/public_key.pub
      echo  $(cat ansible/name.txt)
      chmod 600 ansible/sshkey/private_key.pem
    EOT
  }
    #----------attends que l'ip soit recuperer
    depends_on = [
    azurerm_linux_virtual_machine.VM5
  ]
}

# creer le fichier de configuration de ansible 
resource "null_resource" "ansible_config_in_ansible_folder" {
  provisioner "local-exec" {
    command = <<-EOT
      cat <<EOF > ansible/ansible.cfg
[defaults]
host_key_checking = False
EOF
    EOT
  }
#-------------attends que les cles soit sauvegardé
  depends_on = [
    azurerm_linux_virtual_machine.VM5
  ]
}

resource "null_resource" "ansible_hosts_config" {
  provisioner "local-exec" {
    command = <<-EOT
      ip_vm1=$(az vm show -d -g ${azurerm_resource_group.RG.name} -n ${azurerm_linux_virtual_machine.VM1.name} --query publicIps -o tsv)
      ip_vm2=$(az vm show -d -g ${azurerm_resource_group.RG.name} -n ${azurerm_linux_virtual_machine.VM2.name} --query publicIps -o tsv)
      ip_vm3=$(az vm show -d -g ${azurerm_resource_group.RG.name} -n ${azurerm_linux_virtual_machine.VM3.name} --query publicIps -o tsv)
      ip_vm4=$(az vm show -d -g ${azurerm_resource_group.RG.name} -n ${azurerm_linux_virtual_machine.VM4.name} --query publicIps -o tsv)
      ip_vm5=$(az vm show -d -g ${azurerm_resource_group.RG.name} -n ${azurerm_linux_virtual_machine.VM5.name} --query publicIps -o tsv)
      chmod 700 /ansible/sshkey/private_key* 
      cat <<EOF > ansible/hosts 
[managers]
$ip_vm1 ansible_user=adminuser ansible_ssh_private_key_file=sshkey/private_key.pem
$ip_vm2 ansible_user=adminuser ansible_ssh_private_key_file=sshkey/private_key.pem
$ip_vm3 ansible_user=adminuser ansible_ssh_private_key_file=sshkey/private_key.pem
[workers]
$ip_vm4 ansible_user=adminuser ansible_ssh_private_key_file=sshkey/private_key2.pem
$ip_vm5 ansible_user=adminuser ansible_ssh_private_key_file=sshkey/private_key3.pem
EOF
    EOT
  }
#-------------attends que les cles soit sauvegardé
  depends_on = [
    null_resource.save_ssh_keys
  ]
}

resource "null_resource" "galaxy-ansible" {
  provisioner "local-exec" {
    command = <<-EOT


    EOT
  }
#-------------attends que les cles soit sauvegardé
  depends_on = [
    null_resource.ansible_hosts_config
  ]
}
