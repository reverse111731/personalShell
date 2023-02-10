#!/bin/bash
sudo dnf update

sudo dnf autoremove

flatpak update

sudo youtube-dl -U

secs=3
while [ $secs -gt 0 ];
do
    echo -ne "closing in $secs\033[0K\r"
    sleep 1
    : $((secs--))
done

kill -9 $PPID