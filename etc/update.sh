#!/bin/bash

G="\033[1;34m[*] \033[0m"
S="\033[1;32m[+] \033[0m"
E="\033[1;31m[-] \033[0m"

if [[ -f /data/data/com.termux/files/usr/bin/thoron ]]; then
    UPDATE="true"
else
    if [[ -f /usr/local/bin/thoron ]]; then
        UPDATE="true"
    else
        if [[ -f /usr/bin/thoron ]]; then
            UPDATE="true"
        else
            UPDATE="false"
        fi
    fi
fi

{
    CHECK="$(ping -c 1 -q www.google.com >&/dev/null; echo $?)"
} &> /dev/null

if [[ "$CHECK" != 0 ]]; then 
    echo -e ""$E"No Internet connection!"
    exit
fi

if [[ $(id -u) != 0 ]]; then
    echo -e ""$E"Permission denied!"
    exit
fi

sleep 1
echo -e ""$G"Installing update..."
{
    rm -rf ~/thoron
    rm /usr/bin/thoron
    rm /usr/local/bin/thoron
    rm /data/data/com.termux/files/usr/bin/thoron
    cd ~
    git clone https://github.com/EntySec/thoron.git
    if [[ "$UPDATE" != "true" ]]; then
        sleep 0
    else
        cd thoron
        chmod +x install.sh
        ./install.sh
    fi
} &> /dev/null

if [[ ! -d ~/thoron ]]; then
    echo -e ""$E"Installation failed!"
    exit
fi

echo -e ""$S"Successfully updated!"
cd .
touch .updated
sleep 1
exit
