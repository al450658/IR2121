source /opt/ros/humble/setup.bash
export ROS_LOCALHOST_ONLY=1
export TURTLEBOT3_MODEL=burger
ros2 launch rtabmap_demos \
    turtlebot3_scan.launch.py \
    use_sim_time:=True

