#!/usr/bin/env bash
# Based on a template by BASH3 Boilerplate v2.4.1
# http://bash3boilerplate.sh/#authors
#
# The WTFPL License (WTFPL)
# Copyright (c) 2022 bibibricodeur and contributors
# You are not obligated to bundle the LICENSE file with your projects as long
# as you leave these references intact in the header comments of your source files.

### Script
##############################################################################

# Déclarer méthode 1
rooter() {
# https://subinsb.com/bash-script-root-check/
if [ "$EUID" -ne 0 ]
   then echo $(tput bold; tput setaf 3)"Exécuter en tant que root !"$(tput sgr0)
   exit
fi
}

# Appeler fonction
rooter

# Déclarer méthode 1
preparer() {
 # If you cannot understand this, read Bash_Shell_Scripting #if_statements again.
if (whiptail --title "Post installer" --yesno "Préparer ?" 15 45); then
	echo $(tput bold; tput setaf 2)"Préparer OK."$(tput sgr0)
	sudo apt-get update && sudo apt-get upgrade
	# bloc d’instructions 
    if [ ! -d /home/$SUDO_USER/Documents/000_ne_pas_supprimer ]; then
       mkdir /home/$SUDO_USER/Documents/000_ne_pas_supprimer
       echo "
# Cet ordinateur est protégé car celui et uniquement celui qui a le mot de passe peut faire des mises à jours ou installer des logiciels. Ainsi le **méchant pirate** ne pourras installer des logiciels sans votre accord. Vous avez donc un mot de passe qu'il faut impérativement se souvenir et garder hors de vue.

## Administrateur ordinateur, c'est à dire vous

**motDePasseCompliquéAdministrateur**

# Il en est de même de la messagerie Internet (facebook, gmail, laposte, orange, sfr et autres). S'il n'y avait pas de mot de passe, tout le monde pourrait lire votre courrier personnel.

## Messagerie Internet

**motDePasseCompliquéMessagerie**
       
### Fin 
       " > /home/$SUDO_USER/Documents/000_ne_pas_supprimer/000_a_lire_obligatoirement.md           
       chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/Documents/000_ne_pas_supprimer
       chmod 775 -R /home/$SUDO_USER/Documents/000_ne_pas_supprimer
       fi 
else
	echo $(tput bold; tput setaf 3)"Préparer KO."$(tput sgr0)
fi
}

# Appeler fonction
preparer

# Déclarer méthode 1
installer() {
 # If you cannot understand this, read Bash_Shell_Scripting #if_statements again.
if (whiptail --title "Post installer" --yesno "Installer ?" 15 45); then
	echo $(tput bold; tput setaf 2)"Installer OK."$(tput sgr0)
	# bloc d’instructions 
	sudo apt-get install chromium-browser conky-all curl gnome-games gparted gsmartcontrol keepassxc mc p7zip-rar synaptic telegram-desktop thunderbird vlc vim -y	
    #***
    # NordVpn
    #*** 
    #   sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)  
    #   usermod -aG nordvpn $USER
    #***
    # Snap
    #***       
    sudo snap install brave
else
	echo $(tput bold; tput setaf 3)"Installer KO."$(tput sgr0)
fi
}

# Appeler fonction
installer

# Déclarer méthode 1
developper() {
 # If you cannot understand this, read Bash_Shell_Scripting#if_statements again.
if (whiptail --title "Post installer" --yesno "Développer ?" 15 45); then
	echo $(tput bold; tput setaf 2)"Développer OK."$(tput sgr0)
	# bloc d’instructions 
    #***
    # app-get
    #***
	sudo apt-get install esptool brasero gimp handbrake filezilla git inkscape net-tools nmap nodejs npm printrun samba tree vokoscreen whois -y
    #***
    # Docker
    #***
    sudo apt-get install ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
    sudo apt install docker-compose
    sudo usermod -aG docker $USER
    sudo service docker start

    #***
    # pip3
    #***
    sudo apt-get install python3-pip python3-tk -y
    #sudo pip3 install esptool
    sudo pip3 install thonny
    sudo pip3 install django
    sudo pip3 install djangorestframework
    sudo pip3 install markdown
    sudo pip3 install django-filter
    
    #***
    # Snap
    #***   
    #sudo snap install atom --classic 
    sudo snap install code --classic
    sudo snap install codium --classic
    #sudo snap install docker
    sudo snap install rpi-imager
    #sudo snap install skype --classic
    #sudo snap install sublime-text --classic
    sudo snap install insomnia
    #sudo snap install hugo
    

    #git config --global user.name 
    #git config --global user.email 
    
	
	#sudo tasksel install lamp-server
	#sudo apt-get install php-intl php-json
	#sudo a2enmod userdir
	#sudo a2enmod rewrite	
	#sudo nano /etc/apache2/mods-available/php7.4.conf 
	
	#sudo systemctl restart apache2
	
    #***
    # Syncthing
    #***      
    sudo apt-get install apt-transport-https -y
    # Add the release PGP keys:
    sudo curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
    # Add the "stable" channel to your APT sources:
    sudo echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
    # Update and install syncthing:
    sudo apt-get update
    sudo apt-get install syncthing        
    sudo systemctl enable syncthing@$SUDO_USER.service
    #sudo systemctl start syncthing@$SUDO_USER.service

    #***
    # WordPress
    #***            
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    sudo mv wp-cli.phar /usr/local/bin/wp
    
    #***
    # Composer après avoir installer Xampp
    #***       
    #   sudo curl -s https://getcomposer.org/installer | /opt/lampp/bin/php
    #   sudo mv composer.phar /usr/local/bin/composer
    #   sudo ln -s /opt/lampp/bin/php /usr/local/bin/php
    
else
	echo $(tput bold; tput setaf 3)"Développer KO."$(tput sgr0)
fi
}

# Appeler fonction
developper

### Fin
