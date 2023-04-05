#!/bin/bash


read -p "Ingrese la carpeta donde desea buscar: " carpeta
read -p "Ingrese el nombre del archivo a buscar: " archivo
if [ ! -d "$carpeta" ]; then
    echo "La carpeta '$carpeta' no existe"
elif [ ! -f "$carpeta/$archivo" ]; then
    echo "El archivo '$archivo' no se encontró en la carpeta '$carpeta'"
else
    echo "El archivo '$archivo' se encontró en la carpeta '$carpeta'"
fi