#!/bin/bash
#Cree funcion reproducir
reproducir(){
#accedi a la ubicacion antes pedida
cd "$r"
#inicialice el comando mpg123
mpg123 $r/*.mp3
}
#Cree la funcion lista
lista(){
#Borro la lista antes creada por que se creaba una antes pero le digo que no me muestre el error con &>/dev/null
rm .lista &>/dev/null
#Aqui lo que hago es mandar a llamar el comando ls y redireccionar a un nuevo doccumento pero que este se cree oculto
ls>>.lista
#con este comando creo la interfaz y le digo que imprima lo que dice lista
whiptail --title "REPRODUCTOR DE MUSICA" \
         --textbox .lista 20 80
#mando a llamar el mismo comando pero le digo que lo que obtenga lo guarde
op=$(whiptail --title "MENU" \
               --menu "Elige una opción" 10 80 2 \
               "LISTA" "MUESTRA LA LISTA DE CANCIONES" \
               "INSTRUCCIONES" "MUESTRA LAS INTRUCCIONES" \
	       "REPRODUCIR" "INICIALIZA EL REPRODUCTOR" \
               3>&1 1<&2 2>&3)
#la opcion que toma la mando a llamar y la meto en un case para saber que hacer
case $op in
	"LISTA")
	cd "$r" &>/dev/null
	rm .lista &>/dev/null
	lista
	;;
	"REPRODUCIR")
	reproducir
	;;
	"INSTRUCCIONES")
	instrucciones
	;;
esac
}
#cree la funcion instrucciones
instrucciones(){
#mando a llamar una interfaz y le digo como funciona mpg123
whiptail --title "INSTRUCCIONES"\
	 --msgbox "PRESIONA h en la terminal cuando se reprodusca la musica" 10 80
#aqui lo que hago es volver a llamar el menu para que cuando de una opcion en vez de salir a la terminal pueda ver las demas opciones
i=$(whiptail --title "MENU" \
               --menu "Elige una opción" 10 80 2 \
               "LISTA" "MUESTRA LA LISTA DE CANCIONES" \
	       "INSTRUCCIONES" "MUESTRA LAS INTRUCCIONES" \
               "REPRODUCIR" "INICIALIZA EL REPRODUCTOR" \
               3>&1 1<&2 2>&3)
case $i in
	"LISTA")
	instrucciones
	;;
	"REPRODUCIR")
	reproducir
	;;
	"INSTRUCCIONES")
	instrucciones
	;;
esac
}
#con esta funcion pido los datos para poder correr las demas funciones (pide ruta)
pedir(){
echo "Dime la ruta donde tienes tu musica con el siguiente formato"
echo "/ruta"
read r
cd "$r" &>/dev/null
if [ $? -eq 0 ];then
	mp3
else
	echo
	echo "La ruta que me diste esta mal"
	pedir
fi
}
#manda a llamar la interfaz principal
mp3(){
op=$(whiptail --title "MENU" \
               --menu "Elige una opción" 10 80 2 \
               "LISTA" "MUESTRA LA LISTA DE CANCIONES" \
	       "INSTRUCCIONES" "MUESTRA INSTRUCCIONES" \
               "REPRODUCIR" "INICIALIZA EL REPRODUCTOR" \
               3>&1 1<&2 2>&3)
case $op in
	"LISTA")
	lista
	;;
	"REPRODUCIR")
	reproducir
	;;
	"INSTRUCCIONES")
	instrucciones
	;;
esac
}
#en este verificamos si tiene instalado el paquete mpg123
Verificar(){
dpkg -l	| grep "mpg123"> /dev/null
if [ $? -eq 0 ];then
	pedir
else
	echo "Deseas instalar el paquete necesario para que el programa corra? (y/n) "
	read op
	case $op in
		y)
		#instalamos
		sudo apt-get update
		sudo apt-get install mpg123
		;;
		n)
		;;
		*)
		echo "LO SIENTO DESCONOZCO ESA OPCION"
		Verificar
		;;
	esac
fi
}
Verificar
