#!/bin/bash

echo "Información del sistema:"
echo "-----------------------"
echo "Memoria RAM:"
echo "Total: $(grep MemTotal /proc/meminfo | awk '{print $2/1024/1024 " GB"}')"
#echo "Libre: $(grep MemFree /proc/meminfo | awk '{print $2/1024/1024 " GB"}')"
#echo "En uso: $(grep -w Active /proc/meminfo | awk '{print $2/1024/1024 " GB"}')"
#echo "Porcentaje de uso: $(free | awk '/^Mem:/ {print $3/$2 * 100.0 "%"}')"
echo "Arquitectura del sistema: $(uname -m)"
echo "Versión del SO: $(lsb_release -d | awk '{print $2 " " $3 " " $4}')"
