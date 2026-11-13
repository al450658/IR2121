#!/bin/bash

# Definir el nombre de la carpeta de destino en una variable
CARPETA="Segundo intento"

# Crear la carpeta si todavía no existe (el parámetro -p evita errores si ya existe)
mkdir -p "$CARPETA"

echo "Moviendo los archivos .pgm a la carpeta '$CARPETA'..."
mv *.pgm "$CARPETA/"

echo "Eliminando los archivos .yaml..."
rm *.yaml

echo "¡Listo! Los archivos .pgm se han movido y los .yaml han sido eliminados."
