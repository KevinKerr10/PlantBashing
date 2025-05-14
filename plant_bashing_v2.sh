#!/bin/bash
play_count=0
asked_name=false
default_names=( "Morpheus" "Analiea" "Izzy" )
default_index=0
while true; do
    play_count=$((play_count + 1))
    echo "Run $play_count!"

    if [ "$asked_name" = false ]; then
    echo "Hello, welcome to PlantBashing!"
    echo "What is your name?"
    read name
    echo "Nice to meet you, $name."
    asked_name=true
    else
       echo "Welcome back $name"
    fi

    echo "Do you want to plant a seed? (yes/no)"
    read answer

    if [ "$answer" = "yes" ]; then
        echo "You have planted a seed the size of an almond.(day 1)"
    else
        echo "Why are you even here? This is a plant simulator!"
        exit 1
    fi
    
    if [ "$play_count" -ge 2 ]; then
        echo "Do you want to change your plants name? (yes/no)"
        read answer
        if [ "$answer" = "yes" ]; then
            echo "what is its new name? (type name)"
            read plant_name
            if [ -z "$plant_name" ]; then
                plant_name="${default_names[$default_index]}"
                echo "You didn't enter a name so it is now named $plant_name!"
                 default_index=$(( (default_index + 1) % ${#default_names[@]} ))
            else
               echo "Your plant is now named $plant_name."
            fi
        else 
            echo "Ok your plant is still named $plant_name."
        fi
    else 
        echo "Hey $name lets name your plant, (type in the name)"
        read plant_name
        if [ -z "$plant_name" ]; then
          plant_name="${default_names[$default_index]}"
                echo "You didn't enter a name so it is now named $plant_name!"
                 default_index=$(( (default_index + 1) % ${#default_names[@]} ))   
        else
           echo "Your plant is now named $plant_name."
        fi
    fi


    echo "Would you like to wait a day? (yes/no)"
    read answer
    if [ "$answer" = "yes" ]; then
        echo "nothing happened.(day 2)"
    else
        echo "The day you would come back never came and the plant eventually grew but you weren't there to see it"
        exit 1
    fi

    echo "would you like to wait a day? (yes/no)"
    read answer
    if [ "$answer" = "yes" ]; then
        echo "the seed germinated.(day 3)"
    else
        echo "The day you would come back never came and the plant eventually grew but you weren't there to see it"
        exit 1
    fi

    echo "In this world, time moves fast."
    echo "Would you like to wait until something happens? (yes/no)"
    read answer
    if [ "$answer" = "yes" ]; then
        echo "your plant turned into a sapling (day 6)"
    else
        echo "The day you would come back never came and the plant eventually grew but you weren't there to see it"
        exit 1
    fi 

    echo "would you like to wait a day (yes/no)"  
    read answer   
    # Growth logic
    height=2
    leaves=2
    day=6
    while [ "$answer" = "yes" ]; do
        height=$((height + 2))
        leaves=$((leaves + 2))
        day=$((day + 1))

        echo "Day $day: Your plant is $height cm tall and has $leaves leaves."

        if [ $day -ge 21 ]; then
            echo "Day $day: Your plant has reached full growth!"
            break
        fi

        echo "Wait another day? (yes/no)"
        read answer
    done

    if [ "$answer" != "yes" ]; then
        echo "You left. When you returned, the plant was unrecognizable."
    fi

    echo "Thanks for playing $name!"
    echo "Do you want to play again (yes/no)"
    read answer
    if [ "$answer" != "yes" ];then
        break
    fi
done