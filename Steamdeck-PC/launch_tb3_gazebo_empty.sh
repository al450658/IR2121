#!/bin/bash
source /opt/ros/humble/setup.bash
export ROS_DOMAIN_ID=1
export TURTLEBOT3_MODEL=burger
ros2 launch turtlebot3_gazebo empty_world.launch.py
