#!/bin/bash

NOCOLOR='\033[0m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'

CheckSudo()
{

if [ $EUID -eq 0 ]; then
	echo -e "${RED}Le script ne peut pas lancer avec sudo"

    exit $?

fi
}

Install_Packages()
{

cat /etc/os-release |grep "arch" 2> /dev/null > /dev/null
if [ $? -eq 0 ]; then
	sudo pacman -S zsh curl git ttf-font-awesome
	if [ $? -eq 0 ]; then

		echo -e "${YELLOW}Les paquets nécessaires sont installés, changement de l'interpréteur de commandes...${NOCOLOR}"
		chsh -s /bin/zsh
		
		while [ $? -ne 0 ]
		do
			echo -e "${RED}Erreur, veuillez réessayer${NOCOLOR}"
			chsh -s /bin/zsh
		done
	else
		exit 1


	fi

else

	cat /etc/os-release |grep "ubuntu\|Ubuntu\|debian" 2> /dev/null > /dev/null

	if [ $? -eq 0 ]; then
		sudo apt update && sudo apt install -y zsh curl git fonts-font-awesome
		if [ $? -eq 0 ]; then

			echo -e "${YELLOW}Les paquets nécessaires sont installés, changement de l'interpréteur de commandes...${NOCOLOR}"
			chsh -s /bin/zsh
			while [ $? -ne 0 ]
			do
				echo -e "${RED}Erreur, veuillez réessayer${NOCOLOR}"
				chsh -s /bin/zsh
			done
		else

			exit 1


		fi
	fi
fi


}

if CheckSudo -eq 0; then

	echo -e "${YELLOW}Vérification de l'installation des paquets nécessaires...${NOCOLOR}" && Install_Packages
	
	echo -e "${YELLOW}Installation de Oh-My-ZSH...${NOCOLOR}"
		
		if [ ! -d "$HOME/.oh-my-zsh" ]; then
			echo -e "${YELLOW}Oh-My-ZSH non installé, installation...${NOCOLOR}"
			sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"> /dev/null&
			wait
			echo "Oh-My-ZSH installé"
		else
			echo -e "${YELLOW}Oh-My-ZSH est déjà installé, réinstallation...${NOCOLOR}"
			rm -Rf $HOME/.oh-my-zsh
			sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"> /dev/null&
			wait
			echo "Oh-My-ZSH installé"

		fi
	
		if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" ];then
		
			echo -e "${YELLOW}Installation du plugin zsh-syntax-highlighting${NOCOLOR}"
			cd /tmp/ && git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting
			mv zsh-syntax-highlighting/ $HOME/.oh-my-zsh/plugins
			echo -e "${GREEN}Plugin zsh-syntax-highlighting installé${NOCOLOR}"
	
		else
			echo -e "${YELLOW}ré-installation du plugin zsh-syntax-highlighting${NOCOLOR}"
			rm -Rf $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting
			cd /tmp/ && git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting
			mv zsh-syntax-highlighting/ $HOME/.oh-my-zsh/plugins
			echo -e "${GREEN}Plugin zsh-syntax-highlighting installé${NOCOLOR}"
		fi

		if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-completions" ]
		then
			echo -e "${YELLOW}Installation du plugin zsh-completions${NOCOLOR}"
			cd /tmp/ && git clone --quiet https://github.com/zsh-users/zsh-completions
			mv zsh-completions/ $HOME/.oh-my-zsh/plugins
			echo -e "${GREEN}Plugin zsh-completions installé${NOCOLOR}"
		
		else
			echo -e "${YELLOW}ré-installation du plugin zsh-completions${NOCOLOR}"
			rm -Rf $HOME/.oh-my-zsh/plugins/zsh-completions
			cd /tmp/ && git clone --quiet https://github.com/zsh-users/zsh-completions
			mv zsh-completions/ $HOME/.oh-my-zsh/plugins
			echo -e "${GREEN}Plugin zsh-completions installé${NOCOLOR}"
		fi

		if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" ]
		then
			echo -e "${YELLOW}Installation du plugin zsh-autosuggestions${NOCOLOR}"
			cd /tmp/ && git clone --quiet https://github.com/zsh-users/zsh-autosuggestions
			mv zsh-autosuggestions/ $HOME/.oh-my-zsh/plugins
			echo -e "${GREEN}Plugin zsh-autosuggestions installé${NOCOLOR}"
		
		else
			echo -e "${YELLOW}ré-installation du plugin zsh-autosuggestions${NOCOLOR}"
			rm -Rf $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
			cd /tmp/ && git clone --quiet https://github.com/zsh-users/zsh-autosuggestions
			mv zsh-autosuggestions/ $HOME/.oh-my-zsh/plugins
			echo -e "${GREEN}Plugin zsh-autosuggestions installé${NOCOLOR}"
		fi
	
	
	sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-completions zsh-autosuggestions)/' $HOME/.zshrc
	
	if [ ! -d "$HOME/.oh-my-zsh/plugins/powerlevel10k" ]
		then
			echo -e "${YELLOW}Installation du thème Powerlevel10k...${NOCOLOR}"
			cd /tmp/ && git clone --quiet https://github.com/romkatv/powerlevel10k
			mv powerlevel10k/ $HOME/.oh-my-zsh/themes/
			sed -i 's|ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' $HOME/.zshrc
			echo -e "${GREEN}Thème Powerlevel10k installé${NOCOLOR}"
		else
			echo -e "${YELLOW}Installation du thème Powerlevel10k...${NOCOLOR}"
			rm -Rf $HOME/.oh-my-zsh/themes/powerlevel10k
			cd /tmp/ && git clone --quiet https://github.com/romkatv/powerlevel10k
			mv powerlevel10k/ $HOME/.oh-my-zsh/themes/
			sed -i 's|ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' $HOME/.zshrc
			echo -e "${GREEN}Thème Powerlevel10k installé${NOCOLOR}"
		fi
		
	
	
	
		
	
	echo ""
	echo -e "${GREEN}Installation terminée ! Pour appliquer les changements, veuillez vous déconnecter de la session actuelle et vous reconnecter${NOCOLOR}"
	
else 

	echo -e "${RED}Le script ne peut pas lancer avec sudo${NOCOLOR}"
	exit
	
fi 
