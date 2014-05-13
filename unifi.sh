#!/bin/bash
# Ubiquiti Unifi Controller Installation Script
# Date: 9th of May, 2014
# Version 1.0
#
# Author: John McCarthy
# Email: midactsmystery@gmail.com
# <http://www.midactstech.blogspot.com> <https://www.github.com/Midacts>
#
# To God only wise, be glory through Jesus Christ forever. Amen.
# Romans 16:27, I Corinthians 15:1-4
#---------------------------------------------------------------
######## RESOURCES ########
#
# Unifi Controller Version
#  2.4.6
#
# Linux installation guide for version 2.4.6
#  http://community.ubnt.com/t5/UniFi-Updates-Blog/UniFi-2-4-6-is-released/ba-p/592033
#
# Java Error
#  http://community.ubnt.com/t5/UniFi/UniFi-controller-on-Debian-v7-1-x64-not-working/td-p/523245
#
######## FUNCTIONS ########
function update(){
	# Edit the /etc/apt/sources.list file
		check=$(grep "ubiquiti" /etc/apt/sources.list)
		if [[ -z "$check" ]]; then
		echo
		echo -e '\e[01;34m+++ Updating /etc/apt/sources.list...\e[0m'
		cat <<EOA>> /etc/apt/sources.list

deb http://www.ubnt.com/downloads/unifi/distros/deb/squeeze squeeze ubiquiti
deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen
EOA
		fi
		echo
		echo -e '\e[01;37;42m/etc/apt/sources.list has been successfully updated!\e[0m'

	# Add the ubiquiti GPG key
		echo
		echo -e '\e[01;34m+++ Installing the Ubiquiti GPG key...\e[0m'
		apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50
		echo -e '\e[01;37;42mThe Ubiquiti GPG key has been successfully installed!\e[0m'
		echo
	# Add the mongodb GPG key
		echo -e '\e[01;34m+++ Installing the mongodb GPG key...\e[0m'
		apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
		echo -e '\e[01;37;42mThe mongodb GPG key has been successfully installed!\e[0m'
		echo

	# Update sources
		echo -e '\e[01;34m+++ Running apt-get update...\e[0m'
		apt-get update
		echo -e '\e[01;37;42mYour sources list has been successfully updated!\e[0m'
		echo
}
function install_java(){

	# Installs Java
		echo
		echo -e '\e[01;34m+++ Install Java...\e[0m'
		apt-get install -y openjdk-7-jre
		echo -e '\e[01;37;42mJava has been successfully installed!\e[0m'
		echo
}
function install_unifi(){
	# Install the Ubiquiti Unifi controller
		echo
		echo -e '\e[01;34m+++ Installing the Ubiquiti unifi controller software...\e[0m'
		apt-get install -y unifi
		echo -e '\e[01;37;42mThe Ubiquiti unifi controller software has been successfully installed!\e[0m'
		echo

	# Updating the unifi init script
		echo -e '\e[01;34m+++ Editing the unifi init script...\e[0m'
		echo
		sed -i 's@JAVA_HOME=/usr/lib/jvm/java-6-openjdk@JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64@g' /etc/init.d/unifi
		echo -e '\e[01;37;42mThe unifi init script has been successfully edited!\e[0m'
		echo

	# Restart the unifi service so Java will work correctly
		echo -e '\e[01;34m+++ Restarting the unifi service...\e[0m'
		echo
		service unifi restart
		echo
		echo -e '\e[01;37;42mThe unifi service has been successfully restarted!\e[0m'
}
function doAll()
{
	# Calls Function 'update'
		echo -e "\e[33m=== Update your Ubiquiti repositories ? (y/n)\e[0m"
		read yesno
		if [ "$yesno" = "y" ]; then
			update
		fi

	# Calls Function 'install_java'
		echo -e "\e[33m=== Install the required prerequisite packages ? (y/n)\e[0m"
		read yesno
		if [ "$yesno" = "y" ]; then
			install_java
		fi

	# Calls Function 'install_unifi'
		echo -e "\e[33m=== Install the Ubiquiti Unifi controller? ? (y/n)\e[0m"
		read yesno
		if [ "$yesno" = "y" ]; then
			install_unifi
		fi

	# Gets the IP of the Ubiquiti unifi controller
		ipaddr=`hostname -I`
		ipaddr=$(echo "$ipaddr" | tr -d ' ')

	# End of Script Congratulations, Farewell and Additional Information
		clear
		FARE=$(cat << EOZ


      \e[01;37;42mWell done! You have completed your Uniquiti Controller Installation! \e[0m

                  \e[01;37mLogin to your Ubiquiti unifi controller at:\e[0m
                            \e[01;37mhttps://$ipaddr:8443\e[0m


  \e[30;01mCheckout similar material at midactstech.blogspot.com and github.com/Midacts\e[0m

                            \e[01;37m########################\e[0m
                            \e[01;37m#\e[0m \e[31mI Corinthians 15:1-4\e[0m \e[01;37m#\e[0m
                            \e[01;37m########################\e[0m
EOZ
)

		#Calls the End of Script variable
		echo -e "$FARE"
		echo
		echo
		exit 0
}

# Check privileges
[ $(whoami) == "root" ] || die "You need to run this script as root."

# Welcome to the script
clear
echo
echo
echo -e '            \e[01;37;42mWelcome to Midacts Mystery'\''s Unifi Controller Installer!\e[0m'
echo
echo
case "$go" in
        * )
                        doAll ;;
esac

exit 0
