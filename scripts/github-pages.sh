#!/bin/bash

if [[ $# != 1 ]] ; then
	echo "Make sure you are in the parent directory where you are going to create the folder"
	exit 2
fi

git checkout master

echo -e "Which class is this for?\n"
echo '0) 00-Beginner'
echo '1) 01-Intermediate'
echo '2) 02-General_Meetings'
echo '3) 03-Community'
echo '4) 04-Conferences_Classes'
echo 'please enter a number.'
read class
case $class in 
	0) classType='00-Beginner'
		;;
	1) classType='01-Intermediate'
		;;
	2) classType='02-General_Meetings'
		;;
	3) classType='03-Community'
		;;
	4) classType='04-Conferences_Classes'
		;;
esac
tmpFolder="$( pwd | rev | cut -d '/' -f -3 | rev )"
num=$(ls | tail -n 1 | cut -d '-' -f 1)

if [[ -z "$num" ]] ; then
	newNum="00"
else
	# Future proof numbering of files
	newNum="$( expr $num + 1 )"
	if [[ ${#newNum} -eq 1 ]]
	then
		newNum="0${newNum}"
	fi
fi

name="$1"
name="$(echo $name | tr ' ' '-')"
upperName="$(tr '[:lower:]' '[:upper:]' <<< ${name:0:1})${name:1}"
folder="${newNum}-${upperName}"
mkdir $folder

echo -e "# $upperName\n\n" > ${folder}/README.md

nonTack="$(echo $upperName | tr '-' ' ')"

echo "[$nonTack Slideshow](https://49thsecuritydivision.github.io/slideshows/${tmpFolder}/${folder})" >> ${folder}/README.md
