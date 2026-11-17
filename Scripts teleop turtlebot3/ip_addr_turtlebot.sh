#!/bin/bash

# 1. Pedir los últimos números de la IP
read -p "Introduce los últimos números de la IP del robot (ej: 105, 111, 203): " ip_suffix
IP="192.168.0.$ip_suffix"

echo "------------------------------------------------------"
echo "Conectando a ubuntu@$IP"
echo "Contraseña de SSH: turtlebot"
echo "------------------------------------------------------"

# 2. SSH interactivo con auto-aceptación de huella
ssh -t -o StrictHostKeyChecking=no ubuntu@$IP "
    # Cargar ROS 2
    source /opt/ros/humble/setup.bash

    echo \"------------------------------------------------------\"
    if [ -z \"\$RMW_IMPLEMENTATION\" ]; then
        echo \"Middleware (DDS) actual: rmw_fastrtps_cpp (Por defecto)\"
    else
        echo \"Middleware (DDS) actual: \$RMW_IMPLEMENTATION\"
    fi
    echo \"------------------------------------------------------\"

    ip addr

    # Mantiene la sesión SSH abierta en la Pi al pulsar Ctrl+C
    exec bash
"
