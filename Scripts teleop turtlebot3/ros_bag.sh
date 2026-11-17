#!/bin/bash

# 1. Pedir los últimos números de la IP
read -p "Introduce los últimos números de la IP del robot (ej: 105, 111, 203): " ip_suffix

# 2. Pedir el ROS_DOMAIN_ID
read -p "Introduce el ROS_DOMAIN_ID para este robot: " user_domain_id

# 3. Asignar variables según el número de robot
if [ "$ip_suffix" -ge 101 ] && [ "$ip_suffix" -le 110 ]; then
    MODEL="burger"
elif [ "$ip_suffix" -ge 111 ] && [ "$ip_suffix" -le 112 ]; then
    MODEL="waffle_pi"
elif [ "$ip_suffix" -ge 202 ] && [ "$ip_suffix" -le 206 ]; then
    MODEL="burger"
else
    MODEL="burger"
fi

echo "------------------------------------------------------"
echo "Modelo: $MODEL | Domain ID: $user_domain_id"
echo "------------------------------------------------------"

# 4. Cargar entorno y lanzar RViz
source /opt/ros/humble/setup.bash
export TURTLEBOT3_MODEL=$MODEL
export ROS_DOMAIN_ID=$user_domain_id

echo '>>> Entorno cargado. Iniciando grabación...'

# Se ejecuta ros bag en primer plano
ros2 bag record /clock /tf /tf_static /map /robot_description /scan /particle_cloud /plan /local_plan /waypoints /global_costmap/costmap /global_costmap/costmap_updates /local_costmap/costmap /local_costmap/costmap_updates /local_costmap/published_footprint /goal_pose /amcl_pose

# Mensaje tras la salida/cancelación
echo '>>> Grabación guardada correctamente.'
