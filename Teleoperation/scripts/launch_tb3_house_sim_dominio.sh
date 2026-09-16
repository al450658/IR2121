#!/bin/bash
# 1. Pedir el ROS_DOMAIN_ID
read -p "Introduce el ROS_DOMAIN_ID para este robot: " user_domain_id
echo "Domain ID: $user_domain_id"
source /opt/ros/humble/setup.bash
export ROS_DOMAIN_ID=$user_domain_id
export TURTLEBOT3_MODEL=burger
ros2 launch turtlebot3_gazebo turtlebot3_house.launch.py
