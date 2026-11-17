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

# 4. Cargar entorno y variables de ROS 2
source /opt/ros/humble/setup.bash
export TURTLEBOT3_MODEL=$MODEL
export ROS_DOMAIN_ID=$user_domain_id

echo ">>> Entorno cargado. Iniciando sistema de guardado continuo de mapas..."
echo "Pulsa Ctrl+C en cualquier momento para salir del script."
echo "-----------------------------------------------------"

# Definir la carpeta de destino para los mapas
CARPETA_MAPA="Mapa"

# Crear la carpeta si no existe
mkdir -p "$CARPETA_MAPA"

# Inicializar el contador para los mapas (el primero será map1)
contador=1

echo "=== Iniciando sistema de guardado continuo de mapas ==="
echo "Carpeta de destino: $CARPETA_MAPA"
echo "Pulsa Ctrl+C en cualquier momento para salir del script."
echo "-----------------------------------------------------"

while true; do
    echo ">> Guardando el mapa número $contador (archivo: $CARPETA_MAPA/map$contador)..."
    
    # Ejecutar el comando de ROS 2 para guardar el mapa en la carpeta especificada
    ros2 run nav2_map_server map_saver_cli -f "$CARPETA_MAPA/map$contador"
    
    echo "¡Mapa $CARPETA_MAPA/map$contador guardado correctamente!"
    echo "-----------------------------------------------------"
    
    # Preguntar al usuario si desea continuar
    read -p "Pulsa [Intro] para hacer otro mapa (o Ctrl+C para salir): "
    
    # Incrementar el contador para el siguiente mapa
    contador=$((contador + 1))
    echo ""
done



