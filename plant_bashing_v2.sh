echo "Hello, welcome to PlantBashing! What is your name?"
read name
echo "Nice to meet you, $name."

echo "Do you want to plant a seed? (yes/no)"
read answer

if [ "$answer" = "yes" ]; then
    echo "You have planted a seed the size of an almond.(day 1)"
else
    echo "Why are you even here? This is a plant simulator!"
    exit 1
fi

echo "would you like to wait a day? (yes/no)"
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

echo "would you like to wait a day"  
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
        echo "Thanks for growing your tree and playing the game!"
        break
    fi

    echo "Wait another day? (yes/no)"
    read answer
done

if [ "$answer" != "yes" ]; then
    echo "You left. When you returned, the plant was unrecognizable."
fi