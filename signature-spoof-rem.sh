#colors

red="\e[1;91m"
green="\e[1;92m"
default="\e[0m"
underline="\e[1;4m"

# checking & installing

check(){
	if [ $(echo $?) -ne 0 ]; then
		yes | sudo apt-get install $1
	else
		echo -e "$1 -> ${green}Installed\n${default}"
	fi
}
echo -e "\n${green}${underline}SPOOF SIGNATURE FOR ANDROID 11(R) BY REM${default}\n\n"
#checking adb
adb version > /dev/null 2>&1
check adb

#checking java
java -version > /dev/null 2>&1
check openjdk-8-jdk

#checking curl
curl --version > /dev/null 2>&1
check curl

#Making folder and downloading
mkdir -p SigSpoof
cd SigSpoof
if [ -e "./HayMicroSpoof.zip" ]; then
	echo "Please wait"
else
	echo -e "\n${red}Downloading Files${default}\n\n"
	curl -# -o HayMicroSpoof.zip https://dl.uploadgram.me/60f81bc8dabdeh?dl 
fi
echo ""
unzip HayMicroSpoof.zip -d temp
cd temp
unzip haystack-11-attempt.zip -d haystack-11-attempt
unzip spoof_AVDapi30.zip -d spoof_AVDapi30
cd haystack-11-attempt

#adb commands
	echo -e "\n${red}Please Connect your device through usb debugging and Click Allow${default}\n"
	adb devices > /dev/null 2>&1 
	echo -e "${green}Press any key to continue${default}\n"
	read any
	if [ $(adb devices | wc -m) -gt 26 ]; then
		adb pull /system/framework/services.jar
		java -jar dexpatcher-1.8.0-beta1.jar -a 11 -M -v -d -o ./ services.jar 11-hook-services.jar.dex 11core-services.jar.dex
		mkdir repack
		zip -j repack/services.jar classes*.dex
		rm ../spoof_AVDapi30/system/framework/services.jar
		cp repack/services.jar ../spoof_AVDapi30/system/framework/
		cd ../spoof_AVDapi30
		zip -r Signature-Spoof-A11.zip ./*
		mkdir -p ../../Ready
		mv Signature-Spoof-A11.zip ../../Ready/Signature-Spoof-A11.zip
		cd ../../
		rm -rf temp
	else
		echo -e "\n${red}OPs! Please Connect your Phone, Enable USB Debugging and Click Allow the Computer on your device\n"
		cd ../../
		rm -rf temp
		exit 
	fi

	echo -e "${green}Done! Flash Signature-Spoof-A11.zip via Magisk${default}\n"









