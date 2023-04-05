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
echo "\nBienvenido, $usuario"
while true; do
    read -p ">$usuario:$(pwd)$ " comando
    case $comando in
        salir)
            echo "¡Hasta luego!"
            break
            ;;
        ayuda)
            sh ayuda.sh ayuda
            ;;
        infosis)
            sh infosisPro.sh infosisPro
            ;;
        fecha)
            sh fecha.sh fecha
            ;;
        buscar)
            sh buscar.sh buscar
            ;;
        creditos)
            sh creditos.sh creditos
            ;;
        reproductor)
            sh reproductor.sh
            ;;
        *)
            if command -v "$comando" >/dev/null 2>&1; then
                "$comando"
            else
                echo "Comando no reconocido, escriba 'ayuda' para ver la lista de comandos disponibles"
            fi
            ;;
    esac
done
