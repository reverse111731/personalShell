#!/bin/bash

function_video_format_checker()
{
	echo "Please enter link: "
	read link
	 youtube-dl -F $link 
	if [[ $? -eq 0 ]];
	then
		echo "Do you want to DL this link? [Y/N]: "
		read answer
			if [[ $answer == "y" ]];
			then
				function_video_downloader "$link"
			else
				echo "Ending Video Downloader"
			fi
	else
		echo "Something went wrong"
	fi
}

function_video_downloader()
{

	echo "Please enter format"
	read input_string
	if [[ $# -eq 0 ]];
	then
		echo "Please enter link: "
		read link
		youtube-dl -o "%(title)s.%(ext)s" -f $input_string $link
	
	else
		youtube-dl -o "%(title)s.%(ext)s" -f $input_string $1
	fi
}


function_video()
{
	echo "Files will be save on the Video directory"
	cd Videos/
	echo -n "current path: "
	pwd
		
	echo "[1] - Check the format available of the video"
	echo "[2] - Download the video"
	echo "[3] - Download batch video"
	
	read selection
	
	if [[ $selection == 1 ]];
	then
		function_video_format_checker
		
	elif [[ $selection == 2 ]];
	then
		function_video_downloader
	
	elif [[ $selection == 3 ]];
	then
		echo "Please enter file name: "
		read file
		youtube-dl -o "%(title)s.%(ext)s" -a $file.txt
		>>$file.txt
		
	else
		echo "Not in the selection"
	fi
}


function_music()
{
	echo "Files will be save on the Music directory"
	cd Music/
	echo -n "current path: "
	pwd

	echo "[1] - Download 1 link"
	echo "[2] - Download via batch"
	
	echo -n "Enter selection: "
	
	read selection
	
	if [[ $selection == 1 ]];
	then
		echo "Please enter link: "
		read link
		youtube-dl -o "%(title)s.%(ext)s" -x --audio-format mp3 $link

	elif [[ $selection == 2 ]];
	then
		echo "Please enter file name: "
		read file
		youtube-dl -o "%(title)s.%(ext)s" -x --audio-format mp3 -a $file.txt
		>$file.txt
	else
		echo "Not in the selection"
	fi
}

function_crop()
{
	bash ffmpeg.sh
}

function_uninstall()
{
	sudo rm /usr/local/bin/y-dl
	echo "y-dl has been uninstalled exiting ...."
	exit
}

mode_selector()
{
	if [[ $1 == 1 ]];
	then
		function_video
	elif [[ $1 == 2 ]];
	then
		function_music
	elif [[ $1 == 3 ]];
	then
		function_crop
	elif [[ $1 == 4 ]];
	then
		function_uninstall
	elif [[ -z "$1" ]]
    then
        echo ""
	else
		echo "Not in the selection"
	fi
	
	echo "Do you want to repeat the program? [Y/N]: "
	read repeat
	
	if [[ $repeat == "y" ]];
	then
		cd ~
		main
	else
		echo "Ending Program..."
	fi
}

main()
{
	echo "[1] - Video"
	echo "[2] - Audio"
	echo "[3] - Crop Music"
	echo "[4] - Uninstall"
	echo -n "Enter mode: "
	
	read mode
	mode_selector "$mode"
}

main


#ffmpeg -ss <start time> -i input.mp3 -t <time you want to end> output.mp3
