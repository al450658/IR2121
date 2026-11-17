#!/bin/bash
source /opt/ros/humble/setup.bash
export ROS_LOCALHOST_ONLY=1
ros2 bag record /clock /tf /tf_static /map /robot_description /scan /particle_cloud /plan /local_plan /waypoints /global_costmap/costmap /global_costmap/costmap_updates /local_costmap/costmap /local_costmap/costmap_updates /local_costmap/published_footprint /goal_pose /amcl_pose

