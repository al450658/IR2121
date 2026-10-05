#!/bin/bash
source /opt/ros/humble/setup.bash
export ROS_LOCALHOST_ONLY=1
ros2 bag play rosbag2_2026_10_05-18_54_41
