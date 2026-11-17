#!/bin/bash

# Eliminar las variables de entorno de ROS 2 de la sesión actual
unset ROS_DOMAIN_ID
unset ROS_LOCALHOST_ONLY
unset TURTLEBOT3_MODEL
unset LDS_MODEL

echo "------------------------------------------------------"
echo "Variables de ROS 2 eliminadas correctamente."
echo "El entorno de la terminal ha vuelto a sus valores por defecto."
echo "------------------------------------------------------"
