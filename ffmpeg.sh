#!/bin/bash

function_check_audio_file()
{
    cd Music/
    echo "Files will be save on the Music directory"
    echo -n "current path: "
    pwd

    local secs=3
    while [ $secs -gt 0 ]; 
    do
        echo -ne "Loading list in $secs\033[0K\r"
        sleep 1
        : $((secs--))
    done

    selected_audio="$(fzf)"

    ffmpeg -i "$selected_audio" 2>&1 | grep -A1 Duration:

    if [[ $? -eq 0 ]];
	then
		echo "Do you want to crop audio? [Y/N]: "
		read answer
			if [[ $answer == "y" ]];
			then
				function_crop_audio
			else
				echo "Going back to main menu"
                main
			fi
	else
		echo "Something went wrong"
	fi

}

function_crop_audio()
{
    currentLocation=$(pwd)
    musicFolder="$HOME/Music"

    if [[ $currentLocation != $musicFolder ]];
    then
        echo "Current location: $currentLocation"
        echo "Moving to $musicFolder"
        cd $musicFolder
        function_crop_audio
    else
         local secs=3
         while [ $secs -gt 0 ]; 
         do
            echo -ne "Loading list in $secs\033[0K\r"
            sleep 1
            : $((secs--))
        done

        input_file="$(fzf)"
        echo "Selected file: $input_file"
        echo -n "Enter time where to cut or input q to quit [00:00:00] format: "
        read upto
        if [[ $upto == 'q' ]];
        then
            return
        else
            echo -n "New filename: "
            read output
            ffmpeg -i "$input_file" -ss 00:00:00 -to "$upto" -c copy "$output".mp3
        fi
    fi

}


mode_selector()
{
    if [[ $1 == 1 ]];
    then
        function_check_audio_file
    
    elif [[ $1 == 2 ]];
    then
        function_crop_audio

    elif [[ $1 == 3 ]];
    then 
        echo "Closing program"
        exit
    # elif [[ -z "$1" ]]
    # then
    #     echo ""
    
    else
        echo "Not in the selection"
         echo "Do you want to repeat the program? [Y/N]: "
         read repeat
         if [[ $repeat == "y" ]];
         then
            cd ~
            main
        else
            echo "Ending Program..."
	    fi
    fi
   
}

main()
{
    echo "[1] - Check Audio file"
    echo "[2] - Crop audio"
    echo "[3] - Exit"
    echo -n "Enter mode: "

    read mode
    mode_selector "$mode"
}

main

# this is to crop
#ffmpeg -ss <start time> -i input.mp3 -t <time you want to end> output.mp3
# this is to grep specific part only
#ffmpeg -i 'Wonder Wall feat. 5lack.mp3' 2>&1 | grep -A10 Duration: