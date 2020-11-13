#!/bin/bash

printf '\033]2;install.sh\a'

G="\033[1;34m[*] \033[0m"
S="\033[1;32m[+] \033[0m"
E="\033[1;31m[-] \033[0m"

if [[ $(id -u) != 0 ]]; then
    echo -e ""$E"Permission denied!"
    exit
fi

{
    CHECK="$(ping -c 1 -q www.google.com >&/dev/null; echo $?)"
} &> /dev/null

if [[ "$CHECK" != 0 ]]; then 
    echo -e ""$E"No Internet connection!"
    exit
fi

sleep 0.5
clear
sleep 0.5
cat banner/banner.txt
echo

sleep 1
echo -e ""$G"Installing dependencies..."
sleep 1

{
    pkg update
    pkg -y install git
    pkg -y install ruby
    apt-get update
    apt-get -y install git
    apt-get -y install ruby
    apk update
    apk add git
    apk add ruby
    pacman -Sy
    pacman -S --noconfirm git
    pacman -S --noconfirm ruby
    zypper refresh
    zypper install -y git
    zypper install -y ruby
    yum -y install git
    yum -y install ruby
    dnf -y install git
    dnf -y install ruby
    eopkg update-repo
    eopkg -y install git
    eopkg -y install ruby
    xbps-install -S
    xbps-install -y git
    xbps-install -y ruby
} &> /dev/null

if [[ -d ~/thoron ]]; then
    sleep 0
else
    cd ~
    {
        git clone https://github.com/EntySec/thoron.git
    } &> /dev/null
fi

if [[ -d ~/thoron ]]; then
    cd ~/thoron
else
    echo -e ""$E"Installation failed!"
    exit
fi

{
    cp bin/thoron /usr/bin
    chmod +x /usr/bin/thoron
    cp bin/thoron /usr/local/bin
    chmod +x /usr/local/bin/thoron
    cp bin/thoron /data/data/com.termux/files/usr/bin
    chmod +x /data/data/com.termux/files/usr/bin/thoron
} &> /dev/null

sleep 1
echo -e ""$S"Successfully installed!"
sleep 1
