#!/bin/bash

function control_c {
    echo -e "\nSeñal SIGINT recibida, el programa no se cerrará."
}

function control_z {
    echo -e "\nSeñal SIGTSTP recibida, el programa no se cerrará."
}

trap control_c SIGINT
trap control_z SIGTSTP

# Acceso a la terminal
echo "Bienvenido a la Terminal de Trabajo"
echo "Por favor, ingrese su usuario para continuar"

read -p "Usuario: " usuario

if  ! id -u "$usuario" >/dev/null 2>&1; then
    echo "El usuario '$usuario' no existe en el sistema"
    exit 1
fi

read -s -p "Contraseña del usuario $usuario: " contrasena

if ! echo "$contrasena" | sudo -S id -u >/dev/null 2>&1; then
    echo "La contraseña es incorrecta"
    exit 1
fi

# Comandos
trap '' INT
stty susp ^0
ruta=$(pwd) 
comandos=("ayuda" "buscar" "gato" "infosisPro" "creditos" "fecha" "reproductor")
comando=""
while true;
do
    terminalnueva="$(pwd)"
    printf ">""\e[0;36m$terminalnueva\e[0;37m " 
    read -e -p " " comando 
    for aux in "${comandos[@]}"
    do
        # Compara si la palabra dada es igual a un comando
        if [ "$comando" == "$aux" ]
        then
                . "$ruta/$comando.sh"
                comando=" "
                break
        fi
    done
    if [ "$comando" == "salir" ]; then
            comando=" "
            break
    fi
    $comando
    
done

echo "Hasta luego."