#!/bin/sh
xterm -e "roslaunch turtlebot_gazebo turtlebot_world.launch world_file:=$ROOT_REPO_PATH/src/world/Miao.world"&
sleep 5
xterm -e "roslaunch turtlebot_gazebo gmapping_demo.launch" &
sleep 5
xterm -e "roslaunch turtlebot_rviz_launchers view_navigation.launch"&
sleep 5
xterm -e " roslaunch turtlebot_teleop keyboard_teleop.launch "

