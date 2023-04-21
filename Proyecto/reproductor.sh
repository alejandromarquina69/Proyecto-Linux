#!/bin/bash

# Comprobar si mpg123 está instalado
if ! command -v mpg123 &> /dev/null; then
    echo "mpg123 no está instalado"
    read -p "¿Desea instalarlo? (s/n) " option
    if [ "$option" = "s" ]; then
        # Instalar mpg123
        sudo apt-get install mpg123
    else
        echo "Saliendo del programa"
        exit
    fi
fi

# Listar archivos MP3 en la carpeta actual
mp3_files=(*.mp3)

if [ ${#mp3_files[@]} -eq 0 ]; then
    echo "No se encontraron archivos MP3 en la carpeta actual"
    exit 1
fi

# Mostrar lista de canciones en un cuadro de diálogo
selected_song=$(whiptail --title "Reproductor de MP3" --menu "Seleccione una canción:" 15 60 4 "${mp3_files[@]}" 3>&1 1>&2 2>&3)



# Iniciar el reproductor con la canción seleccionada
mpg123 "$selected_song"

# Bucle para permitir la navegación por la biblioteca musical
while true; do
    # Mostrar información sobre la canción actual
    echo "Reproduciendo: $selected_song"

    # Leer la entrada del usuario
    read -p "Opciones: [n] Siguiente canción, [p] Canción anterior, [q] Salir " option

    # Procesar la entrada del usuario
    case $option in
        n)
            # Mostrar lista de canciones en un cuadro de diálogo
            selected_song=$(whiptail --title "Reproductor de MP3" --menu "Seleccione una canción:" 15 60 4 "${mp3_files[@]}" 3>&1 1>&2 2>&3)
            # Reproducir la siguiente canción en la lista
            mpg123 "$selected_song"
            ;;
        p)
            # Mostrar lista de canciones en un cuadro de diálogo
            selected_song=$(whiptail --title "Reproductor de MP3" --menu "Seleccione una canción:" 15 60 4 "${mp3_files[@]}" 3>&1 1>&2 2>&3)
            # Reproducir la canción anterior en la lista
            mpg123 "$selected_song"
            ;;
        q)
           # Salir del reproductor
            echo "Saliendo del reproductor de MP3"
            exit
            ;;
        *)
            echo "Opción inválida"
            ;;
    esac
done
