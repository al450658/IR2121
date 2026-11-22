#!/bin/bash

# Configurar el entorno de ROS 2 Humble
source /opt/ros/humble/setup.bash
export ROS_LOCALHOST_ONLY=1

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
    ros2 run nav2_map_server map_saver_cli -f "$CARPETA_MAPA/map_cartographer_$contador"
    
    echo "¡Mapa $CARPETA_MAPA/map$contador guardado correctamente!"
    echo "-----------------------------------------------------"
    
    # Preguntar al usuario si desea continuar
    read -p "Pulsa [Intro] para hacer otro mapa (o Ctrl+C para salir): "
    
    # Incrementar el contador para el siguiente mapa
    contador=$((contador + 1))
    echo ""
done

