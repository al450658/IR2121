#!/bin/bash
source /opt/ros/humble/setup.bash
export ROS_LOCALHOST_ONLY=1
ros2 bag record /clock /odom /robot_description /scan /tf /tf_static
