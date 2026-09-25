#!/bin/bash
source /opt/ros/humble/setup.bash
export ROS_LOCALHOST_ONLY=1
ros2 bag play rosbag2_2026_09_25-10_55_37
