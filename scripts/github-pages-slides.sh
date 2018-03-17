#!/bin/bash

if [[ $# != 1 ]] ; then
	echo "Make sure you are in the parent directory where you are going to create the folder"
	exit 2
fi

git checkout gh-pages

echo -e "Which class is this for?\n"
echo '0) 00-Beginner-Wednesday'
echo '1) 01-Intermediate-Monday'
echo '2) 02-Friday-Nights'
echo '3) 03-Community'
echo '4) 04-Conferences_Classes'
echo 'please enter a number.'
read class
case $class in 
	0) classType='00-Beginner-Wednesday'
		;;
	1) classType='01-Intermediate-Monday'
		;;
	2) classType='02-Friday-Nights'
		;;
	3) classType='03-Community'
		;;
	4) classType='04-Conferences_Classes'
		;;
esac
tmpFolder="$(date +%Y)/${classType}"
num=$(ls | tail -n 1 | cut -d '-' -f 1)

if [[ -z "$num" ]] ; then
	newNum="00"
else
	newNum="0$( expr $num + 1 )"
fi

name="$1"
name="$(echo $name | tr ' ' '-')"
upperName="$(tr '[:lower:]' '[:upper:]' <<< ${name:0:1})${name:1}"
folder="${newNum}-${upperName}"
mkdir $folder
cp -r ~/src/49th/slideshows/reveal-template/* $folder/

echo -e "# $upperName\n\n" > ${folder}/README.md


nonTack="$(echo $upperName | tr '-' ' ')"

echo "[$nonTack Slideshow](https://49thsecuritydivision.github.io/slideshows/${tmpFolder}/${folder})" >> ${folder}/README.md

cp -r ${folder} ../all/
