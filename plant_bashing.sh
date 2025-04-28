#!/bin/bash
echo "Hello welcome to PlantBashing, what is your name?"
read name
echo "It's nice to meet you $name"
echo "do you want to plant a seed? (answer yes or no)"
read answer
if [ "$answer" = "yes" ];then
	echo "you have dug a hole and planted a seed the size of an almond"
elif [ "$answer" != "yes" ];then
	echo "what are you even doing here than you know this is a plant growing simulator right?"
fi
echo "In this world time moves much faster than in yours,a seccond in your world could be hours in this one!"
