source /opt/ros/humble/setup.bash
export ROS_LOCALHOST_ONLY=1
ros2 run nav2_map_server map_saver_cli -f ./map

