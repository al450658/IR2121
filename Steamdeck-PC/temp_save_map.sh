#!/bin/bash

# Configurar el entorno de ROS 2 Humble
source /opt/ros/humble/setup.bash
export ROS_DOMAIN_ID=1
export TURTLEBOT3_MODEL=burger

# Inicializar el contador para los mapas (el primero será map1)
contador=1

echo "=== Iniciando sistema de guardado automático (cada 30 segundos) ==="
echo "Pulsa Ctrl+C en cualquier momento para salir del script."
echo "-----------------------------------------------------"

while true; do
    echo ">> Guardando el mapa número $contador (archivo: ./map$contador)..."
    
    # Ejecutar el comando de ROS 2 para guardar el mapa
    ros2 run nav2_map_server map_saver_cli -f ./map$contador
    
    echo "¡Mapa ./map$contador guardado correctamente!"
    echo "Próximo guardado en 30 segundos..."
    echo "-----------------------------------------------------"
    
    # Pausa de 30 segundos antes del siguiente guardado
    sleep 30
    
    # Incrementar el contador para el siguiente mapa
    contador=$((contador + 1))
    echo ""
done
