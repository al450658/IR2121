#!/bin/bash

# 1. Pedir los últimos números de la IP
read -p "Introduce los últimos números de la IP del robot (ej: 105, 111, 203): " ip_suffix
IP="192.168.0.$ip_suffix"

# 2. Pedir el ROS_DOMAIN_ID
read -p "Introduce el ROS_DOMAIN_ID para este robot: " user_domain_id

# 3. Asignar variables según el número de robot
if [ "$ip_suffix" -ge 101 ] && [ "$ip_suffix" -le 110 ]; then
    MODEL="burger"
    LDS="LDS-01"
elif [ "$ip_suffix" -ge 111 ] && [ "$ip_suffix" -le 112 ]; then
    MODEL="waffle_pi"
    LDS="LDS-01"
elif [ "$ip_suffix" -ge 202 ] && [ "$ip_suffix" -le 206 ]; then
    MODEL="burger"
    LDS="LDS-02"
else
    MODEL="burger"
    LDS="LDS-01"
fi

echo "------------------------------------------------------"
echo "Conectando a ubuntu@$IP"
echo "Modelo: $MODEL | LDS: $LDS | Domain ID: $user_domain_id"
echo "Contraseña de SSH: turtlebot"
echo "------------------------------------------------------"

# 4. SSH interactivo con auto-aceptación de huella
ssh -t -o StrictHostKeyChecking=no ubuntu@$IP "
    source /opt/ros/humble/setup.bash
    export TURTLEBOT3_MODEL=$MODEL
    export LDS_MODEL=$LDS
    export ROS_DOMAIN_ID=$user_domain_id

    echo '>>> Entorno cargado correctamente. Iniciando bringup...'
    ros2 launch turtlebot3_bringup robot.launch.py

    # Mantiene la sesión SSH abierta en la Pi al pulsar Ctrl+C
    exec bash
"
