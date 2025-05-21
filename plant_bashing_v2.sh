#!/bin/bash

# ========================
# 🌱 INITIAL VARIABLES
# ========================
play_count=0
asked_name=false
windstorms_survived=0
default_names=("Morpheus" "Analiea" "Izzy")
default_index=0
events=(
    "It is Rainy"
    "It is Sunny"
    "It is Cloudy"
    "It is Overcast"
    "There is a Windstorm"
    "It is Foggy"
)

# ========================
# 🌿 FUNCTION DEFINITIONS
# ========================

# Check if the answer is "yes"
is_yes() {
    [ "$answer" = "yes" ]
}

# Ask the user to name the plant
name_plant() {
    read plant_name
    if [ -z "$plant_name" ]; then
        plant_name="${default_names[$default_index]}"
        echo "You didn't enter a name, so it is now named $plant_name!"
        default_index=$(( (default_index + 1) % ${#default_names[@]} ))
    else
        echo "Your plant is now named $plant_name."
    fi
}

# Show plant's current growth status
describe_growth() {
    echo "Day $day: Your plant '$plant_name' is $height cm tall and has $leaves leaves."
}

# Display a message and end the game
game_over() {
    echo "The day you would come back never came and the plant eventually grew, but you weren't there to see it."
    echo "Goodbye, $name."
    exit 0
}

# ========================
# 🌻 MAIN GAME LOOP
# ========================

while true; do
    play_count=$((play_count + 1))

    echo ""
    echo "======================="
    echo "🌼 Run $play_count!"
    echo "======================="

    if [ "$asked_name" = false ]; then
        echo "Hello, welcome to PlantBashing!"
        echo "What is your name?"
        read name
        echo "Nice to meet you, $name."
        asked_name=true
    else
        echo "Welcome back, $name!"
    fi

    echo "Do you want to plant a seed? (yes/no)"
    read answer
    if ! is_yes; then
        echo "Why are you even here? This is a plant simulator!"
        exit 1
    fi
    echo "You have planted a seed the size of an almond. (day 1)"

    if [ "$play_count" -ge 2 ]; then
        echo "Do you want to change your plant's name? (yes/no)"
        read answer
        if is_yes; then
            echo "What is its new name? (type name)"
            name_plant
        else
            echo "Ok, your plant is still named $plant_name."
        fi
    else
        echo "Hey $name, let's name your plant. (type in the name)"
        name_plant
    fi

    echo "Would you like to wait a day? (yes/no)"
    read answer
    if ! is_yes; then game_over; fi
    echo "Nothing happened. (day 2)"

    echo "Would you like to wait a day? (yes/no)"
    read answer
    if ! is_yes; then game_over; fi
    echo "The seed germinated. (day 3)"

    echo "In this world, time moves fast."
    echo "Would you like to wait until something happens? (yes/no)"
    read answer
    if ! is_yes; then game_over; fi
    echo "Your plant turned into a sapling. (day 6)"

    growth_rate=1.0
    height=2.0
    leaves=2.0
    day=6

    echo "Would you like to wait a day? (yes/no)"
    read answer

    while is_yes; do
        day=$((day + 1))

        # PICK RANDOM EVENT AND SET event_index AND event_desc
        event_index=$(( RANDOM % ${#events[@]} ))
        event_desc="${events[$event_index]}"
        echo "Event: $event_desc"

        growth_today=false

        case "$event_index" in
            0)  # Rainy
                echo "Rainy — No growth; growth rate increases by 2"
                growth_rate=$(echo "$growth_rate + 2" | bc)
                ;;
            1)  # Sunny
                echo "Sunny — Growth occurs; growth rate increases by 3"
                growth_today=true
                growth_rate=$(echo "$growth_rate + 3" | bc)
                ;;
            2)  # Cloudy
                echo "Cloudy — No growth"
                ;;
            3)  # Overcast
                echo "Overcast — Growth occurs"
                growth_today=true
                ;;
            4)  # Windstorm
                echo "Windstorm — No growth; growth rate decreases by 2; lose 3 leaves"
                growth_rate=$(echo "$growth_rate - 2" | bc)
                leaves=$(echo "$leaves - 3" | bc)
                windstorms_survived=$((windstorms_survived + 1))
                ;;
            5)  # Foggy
                echo "Foggy — No growth; growth rate decreases by 1"
                growth_rate=$(echo "$growth_rate - 1" | bc)
                ;;
        esac

        # Ensure growth rate is not negative
        if (( $(echo "$growth_rate < 0" | bc -l) )); then
          growth_rate=0
        fi

        if [ "$growth_today" = true ]; then
            height=$(echo "$height + 1.5 * $growth_rate" | bc)
            leaves=$(echo "$leaves + 2 + (2.5 * $growth_rate)" | bc)
            describe_growth

            if (( $(echo "$height >= 35" | bc -l) )); then
                echo "Day $day: Your plant '$plant_name' has reached full growth!"
                break
            fi
        else
            echo "Growth did not occur today."
        fi

        echo "Wait another day? (yes/no)"
        read answer
    done

    # Final summary
    echo ""
    echo "🌿 Final Growth Summary:"
    echo "Total days lived: $day"
    echo "Final height: $height cm"
    echo "Total leaves: $leaves"
    echo "Windstorms survived: $windstorms_survived"

    echo ""
    echo "Thanks for playing, $name!"
    echo "Do you want to play again? (yes/no)"
    read answer
    if ! is_yes; then
        echo "Goodbye!"
        break
    fi
done