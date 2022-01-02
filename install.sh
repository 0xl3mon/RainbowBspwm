#!/bin/bash

# The purpose of this script is to automate the installation,configuration and compilation of different tools like
# bspwm,sxhkd,zsh-plugins,rofi,picom,clipmenu and more.

# Non interactive mode for whipetail
export DEBIAN_FRONTEND=noninteractive

# temporary room for our guests
temp_folder=$(mktemp -d -q)

# Checking current system
current_system=$(cat /etc/issue | awk '{print $1}' | head -n 1)

# COLORS
BLUE='\033[94m'
RED='\033[91m'
GREEN='\033[92m'
ORANGE='\033[93m'
RESET='\e[0m'

# POLYB
polyb_pack="build-essential git cmake cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev polybar libnl-genl-3-dev libasound2-dev"

# PICOM
picom_pack="libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson"

# BSPWM
bspwm_pack="make gcc git bspwm libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev"

# Custom Packages
custom_pack="gnome-terminal open-vm-tools-desktop flameshot rofi feh dunst firejail zsh gdebi p7zip-full tmux cava htop git"

trap ctrl_c INT
 
ctrl_c(){
	echo -e "\n\n${BLUE}[*]${RESET}${ORANGE}Exiting...\n${RESET}"
  tput cnorm
  exit 0
}


logo() {
	echo ""
	echo -e "$RED  ▄▄▄   ▄▄▄· ▪   ▐ ▄ ▄▄▄▄·       ▄▄▌ ▐ ▄▌    ▄▄▄▄· .▄▄ ·  ▄▄▄·▄▄▌ ▐ ▄▌• ▌ ▄ ·. $RESET"
	echo -e "$RED ▀▄ █·▐█ ▀█ ██ •█▌▐█▐█ ▀█▪▪     ██· █▌▐█    ▐█ ▀█▪▐█ ▀. ▐█ ▄███· █▌▐█·██ ▐███▪ $RESET"
	echo -e "$RED ▐▀▀▄ ▄█▀▀█ ▐█·▐█▐▐▌▐█▀▀█▄ ▄█▀▄ ██▪▐█▐▐▌    ▐█▀▀█▄▄▀▀▀█▄ ██▀·██▪▐█▐▐▌▐█ ▌▐▌▐█· $RESET"
	echo -e "$RED ▐█•█▌▐█ ▪▐▌▐█▌██▐█▌██▄▪▐█▐█▌.▐▌▐█▌██▐█▌    ██▄▪▐█▐█▄▪▐█▐█▪·•▐█▌██▐█▌██ ██▌▐█▌ $RESET"
	echo -e "$RED .▀  ▀ ▀  ▀ ▀▀▀▀▀ █▪·▀▀▀▀  ▀█▄▀▪ ▀▀▀▀ ▀▪    ·▀▀▀▀  ▀▀▀▀ .▀    ▀▀▀▀ ▀▪▀▀  █▪▀▀▀ $RESET"
	echo ""
	echo -e "${ORANGE}\t\t\t\t\t\t\t + -- --=[ By Mr.Puppet ]=- -- +${RESET}"

}

upgrade(){
	if [[ "$current_system" == "Parrot" ]] ; then
		echo -e "${BLUE}[*]${RESET}Actualizando el sistema"
		sudo apt update && sudo apt parrot-upgrade  -y
	elif [[ "$curren_system" == "Kali" ]] || [[ "$current_system" == "Debian" ]]; then
		echo -e "${BLUE}[*]${RESET}Actualizando el sistema"
		sudo apt update -y && sudo apt upgrade -y
	fi
}


dependencias() {
	echo -e "${BLUE}[*]${RESET}Preparando Instalancion de Dependencias"
	sleep 0.5
	
	echo -e "\n$BLUE[*]$RESET Instalando dependencias Necesarias de: ${ORANGE}BSPWM${RESET}"
	sudo apt install $bspwm_pack -y && echo -e "${GREEN}Operacion realizada con exito${RESET}"
	sleep 1

	echo -e "\n$BLUE[*]$RESET Instalando dependencias Necesarias de: ${ORANGE}POLYBAR${RESET}"
	sudo apt install $polyb_pack -y && echo -e "${GREEN}Operacion realizada con exito${RESET}"
	sleep 1
  
  echo -e "\n$BLUE[*]$RESET Instalando dependencias Necesarias de: ${ORANGE}PICOM${RESET}"
  sudo apt install $picom_pack -y && echo -e "${GREEN}Operacion realizada con exito${RESET}"
  sleep 1

  echo -e "\n$BLUE[*]$RESET Instalando : ${ORANGE}Custom Packages${RESET}"
  sudo apt install $custom_pack -y && echo -e "${GREEN}Operacion realizada con exito${RESET}"
  sleep 1
}


bspwm_building(){
	clear
	echo -e "${BLUE}[*]${RESET}Compilando e instalando : ${ORANGE}BSPWM , SXHKD${RESET}"
	sleep 0.5

	echo -e "${BLUE}[*]${RESET}Clonando repositorios : ${ORANGE}BSPWM , SXHKD${RESET}"
	cd $temp_folder
	git clone https://github.com/baskerville/bspwm.git
	git clone https://github.com/baskerville/sxhkd.git

  cd bspwm && make && sudo make install
  cd ../sxhkd && make && sudo make install

  clear
  echo -e "\n${BLUE}[*]${RESET}Creando carpeta de configuracion : ${ORANGE}~/.config/bspwm ~/.config/sxhkd${RESET}"
  mkdir -p ~/.config/{bspwm,sxhkd}
  curl -s "https://raw.githubusercontent.com/L3monBit/RainbowBspwm/main/config-files/bspwmrc" -o ~/.config/bspwm/bspwmrc
  curl -s "https://raw.githubusercontent.com/L3monBit/RainbowBspwm/main/config-files/sxhkdrc" -o ~/.config/sxhkd/sxhkdrc
  chmod u+x ~/.config/bspwm/bspwmrc

  touch ~/.xinitrc && echo "exec bspwm" >> ~/.xinitrc
}


polyb_building(){
	clear
	echo -e "\n${BLUE}[*]${RESET}Compilando e instalando : ${ORANGE}POLYBAR${RESET}"
	cd $temp_folder
	git clone --recursive https://github.com/polybar/polybar && cd polybar
	mkdir build && cd build
	cmake .. -DENABLE_ALSA=ON && make -j$(nproc)
	sudo make install

	echo -e "\n${BLUE}[*]${RESET}Compilando e instalando : ${ORANGE}PICOM${RESET}"
	cd $temp_folder
	git clone https://github.com/yshui/picom && cd picom
	git submodule update --init --recursive
	meson --buildtype=release . build
	ninja -C build &&	sudo ninja -C build install

	echo -e "\n${BLUE}[*]${RESET}Creando carpetas de configuracion : ${ORANGE}~/config/polybar ~/.config/picom${RESET}"
	mkdir -p ~/.config/{picom,polybar}
	curl -s "https://raw.githubusercontent.com/L3monBit/RainbowBspwm/main/config-files/picom.conf" -o ~/.config/picom/picom.conf
}

fonts_icons(){
	clear 
	echo -e "${BLUE}[*]${RESET}Instalando Fuentes : ${ORANGE}Nerd Fonts - Papirus Theme${RESET}"
	sudo apt install papirus-icon-theme -y

	echo -e "${BLUE}[*]${RESET}Creando carpetas de configuracion Fonts : ${ORANGE}~/.local/share/fonts${RESET}"
	mkdir -p ~/.local/share/fonts && unzip "${temp_folder}/RainbowBspwm/tools/Hack.zip" -d ~/.local/share/fonts
	wget -q "https://github.com/L3monBit/RainbowBspwm/raw/main/polybar/fonts/feather.ttf" -P ~/.local/share/fonts
	wget -q "https://github.com/L3monBit/RainbowBspwm/raw/main/polybar/fonts/iosevka_nerd_font.ttf" -P ~/.local/share/fonts
	wget -q "https://github.com/L3monBit/RainbowBspwm/raw/main/tools/Hack.zip" && unzip Hack.zip -d ~/.local/share/fonts
	fc-cache -f -v >/dev/null 2>&1
	rm -rf ~/.config/polybar/fonts
}

polyb_theme(){
	clear
	echo -e "${BLUE}[*]${RESET}Instalando Theme de : ${ORANGE}POLYBAR${RESET}"
	cd $temp_folder
	git clone https://github.com/L3monBit/RainbowBspwm && cd RainbowBspwm
	mv bin ~/.config/
	mv polybar/* ~/.config/polybar/ && rm -rf ~/.config/polybar/fonts
	chmod u+x ~/.config/polybar/launch.sh
	chmod u+x ~/.config/polybar/scripts/powermenu.sh

	# Adding wallpapers
	mkdir -p ~/.wallpapers  && mv wallpapers/* ~/.wallpapers/

}


aditional_pack(){
	clear
	echo -e "${BLUE}[*]${RESET}Instalando paquetes adicionales : ${ORANGE}Zsh, Feh, Dunst, Rofi, Flameshot , OpenVmTools, Firejail${RESET}"
	sudo apt install $custom_pack -y ; sleep 1
	echo -e "\n${BLUE}[*]${RESET}Instalando paquetes adicionales : ${ORANGE}Nordvpn${RESET}"
	/bin/sh <(wget -qO - https://downloads.nordcdn.com/apps/linux/install.sh)	
	sudo usermod -aG nordvpn $USER

	# Clipmenu Clipboard Manager
	echo -e "${BLUE}[*]${RESET}Instalando :${ORANGE}Clipmenu - Clipboad Manager${RESET}"
	# Dependencies for clipmenu
	sudo apt install  xsel dmenu libxtst-dev -y
	git clone https://github.com/cdown/clipnotify && cd clipnotify
	make && sudo make install
	cd ../

	#Clipmenu
	git clone https://github.com/cdown/clipmenu && cd clipmenu
	sudo make && sudo make install

	#Unicode Emoji for unix
	sudo apt install pip -y
	python3 -m pip install rofimoji && echo "export PATH=$PATH:$HOME/.local/bin" >> ~/.zshrc

	# Fzf
	echo -e "${BLUE}[*]${RESET}Instalando :${ORANGE}Fzf ${RESET}"
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

	}


customizing_terminal(){
	echo -e "${BLUE}[*]${RESET}Instalando Theme :${ORANGE}Terminal${RESET}"
	sudo apt install dconf-cli -y && mkdir -p ~/.config/dconf

	# Lsdeluxe, Bat
	cd "${temp_folder}/RainbowBspwm/tools"
	sudo gdebi -n lsd-musl_0.20.1_amd64.deb
	sudo gdebi -n bat-musl_0.18.3_amd64.deb
	
	# Alias
	echo -e "############\n# Alias\n###########" >> ~/.zshrc
	echo "alias ls='/usr/bin/lsd --group-dirs=first'" >> ~/.zshrc
	echo "alias cat='/usr/bin/bat'" >> ~/.zshrc
		
}

ligthdm_theme(){
	clear
	echo -e "${BLUE}[*]${RESET}Modificando :${ORANGE}Lightdm${RESET}"
	
	if [[ "$current_system" == "Kali" ]]; then
		mkdir -p ~/.config/lightdm && mv ~/.wallpapers/lightdmII.jpg ~/.config/lightdm
		sudo sed  -i 's/theme-name = .*/theme-name = Kali-Dark/' /etc/lightdm/lightdm-gtk-greeter.conf
		sudo ln -s ~/.config/lightdm/lightdmII.jpg /usr/share/desktop-base/kali-theme/login/background -f
	elif [[ "$current_system" == "Debian" ]] || [[ "$current_system" == "Parrot" ]] ; then
		mkdir -p ~/.config/lightdm && mv ~/.wallpapers/lightdmII.jpg ~/.config/lightdm
		sudo ln -s ~/.config/lightdm/lightdmII.jpg /etc/lightdm/wallpaper.jpg -f
	fi

}

main(){
	logo
	upgrade
	dependencias
	bspwm_building
	polyb_building
	polyb_theme
	fonts_icons
	aditional_pack
	customizing_terminal
	ligthdm_theme
}


if [[ "$EUID" != "0" ]] ; then
	main
else
	echo -e "${RED}[*]${RESET}Error : ${ORANGE}Do not run the script as root${RESET}"
	exit 1
fi






