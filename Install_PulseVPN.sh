 
#! /bin/bash

package=ps-pulse-linux-5.2r6.0-b977-ubuntu-debian-installer.deb
link=https://as.exeter.ac.uk/media/level1/academicserviceswebsite/it/documents/networks/vpn/$package



echo "** ROOT PASSWORD **"
sudo apt-get -y install wget > /dev/null

echo "** Downloading DEB file **"
wget $link -q --show-progress
status1=$?


if [ $status1 -eq 0 ] 
then
    yes | sudo dpkg -i $package > /dev/null
else
    echo "** Download Failed **"
    exit
fi

echo "** Installing prerequisites **"

sudo apt-get -y install  lib32z1 libc6-i386 libwebkitgtk-1.0-0:i386 libproxy1v5:i386 libproxy1-plugin-gsettings:i386 libproxy1-plugin-webkit:i386 libdconf1:i386 dconf-gsettings-backend:i386 > /dev/null

echo "** Verify and Cleanup **"

apt-cache search --names-only '^pulse$' > search
if [ $search != ""]
then
    sudo apt-get autoremove > /dev/null
    sudo rm -R $package*
    echo "** INSTALL FINISHED  **"
fi
    
exit
