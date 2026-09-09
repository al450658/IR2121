#!/bin/bash

echo "Cargando entorno ROS 2 Humble..."
source /opt/ros/humble/setup.bash
export ROS_LOCALHOST_ONLY=1

echo "Verificando dispositivo de joystick (/dev/input/js0)..."
if [ ! -e /dev/input/js0 ]; then
    echo "¡AVISO! No se detecta ningún joystick en /dev/input/js0."
    echo "Asegúrate de pulsar el botón Start (3 segundos) para activar el modo Gamepad."
    exit 1
fi

echo "Iniciando joy_node y teleop_twist_joy con modo Turbo en R1..."

# Lanzar joy_node en segundo plano
ros2 run joy joy_node &
PID_JOY=$!

# Lanzar teleop_twist_joy con velocidad normal, turbo en R1 (botón 5) y ejes de la Steam Deck
ros2 run teleop_twist_joy teleop_node --ros-args \
  -p require_enable_button:=false \
  -p axis_linear.x:=1 \
  -p axis_angular.yaw:=0 \
  -p scale_linear.x:=0.15 \
  -p scale_linear_turbo.x:=0.35 \
  -p enable_turbo_button:=5 \
  -p scale_angular.yaw:=1.0 &
PID_TELEOP=$!

echo "------------------------------------------------------"
echo " - Conducción normal con el stick (progresiva)."
echo " - Mantiene pulsado R1 (botón 5) para activar el Turbo."
echo " - Pulsa [Ctrl + C] para cerrar ambos nodos."
echo "------------------------------------------------------"

# Capturar Ctrl+C (SIGINT) para matar limpiamente los dos procesos antes de salir
trap "echo 'Cerrando nodos del joystick...'; kill $PID_JOY $PID_TELEOP 2>/dev/null; wait $PID_JOY $PID_TELEOP 2>/dev/null; echo 'Terminado.'; exit 0" SIGINT

# Mantener el script en ejecución bloqueado hasta recibir la señal de cierre
wait
