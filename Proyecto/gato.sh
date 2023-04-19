#!/bin/bash

jugador_1="X"
jugador_2="O"

turno=1
juego_encendido=true

juego=1

movimiento=( 1 2 3 4 5 6 7 8 9 )
bienvenida() {
  clear
  echo "========================"
  echo "==========GATO=========="
  echo "========================"
  sleep 1
}

tablero() {
  clear
  echo " ${movimiento[0]} | ${movimiento[1]} | ${movimiento[2]} "
  echo "-----------"
  echo " ${movimiento[3]} | ${movimiento[4]} | ${movimiento[5]} "
  echo "-----------"
  echo " ${movimiento[6]} | ${movimiento[7]} | ${movimiento[8]} "
  echo "============="
}

seleccion_jugador(){
  # JUEGA LA PC
  if [[ $juego -eq 1 ]]
  then  
   if [[ $(($turno % 2)) == 0 ]]
    then
      jugar=$jugador_2
      casilla=$(( $RANDOM % 10 ))
      echo $casilla
    else
      echo -n "JUGADOR 1 ESCOGE UNA CASILLA:"
      jugar=$jugador_1
      read casilla
    fi
  else
    # JUEGA HUMANO
    if [[ $(($turno % 2)) == 0 ]]
    then
      jugar=$jugador_2
      echo -n "JUGADOR 2 ESCOGE UNA CASILLA:"
      read casilla
    else
      jugar=$jugador_1
      echo -n "JUGADOR 1 ESCOGE UNA CASILLA:"
      read casilla
    fi
  fi
  echo "no seleccionaste nada"

  space=${movimiento[($casilla -1)]} 

  if [[ $casilla =~ ^-[0-9]+$ ]] || [[ ! $space =~ ^[0-9]+$  ]]
  then 
    echo "No es una casilla valida."
    seleccion_jugador
  else
    movimiento[($casilla -1)]=$jugar
    ((turno=turno+1))
  fi
  space=${movimiento[($casilla-1)]} 
}

coicidencia() {
  if  [[ ${movimiento[$1]} == ${movimiento[$2]} ]]&& \
      [[ ${movimiento[$2]} == ${movimiento[$3]} ]]; then
    juego_encendido=false
  fi
  if [ $juego_encendido == false ]; then
    if [ ${movimiento[$1]} == 'X' ];then
      echo "Jugador 1 gana!"
      return 
    else
      echo "Jugador 2 gana!"
      return 
    fi
  fi
}

checar_ganador(){
  if [ $juego_encendido == false ]; then return; fi
  coicidencia 0 1 2
  if [ $juego_encendido == false ]; then return; fi
  coicidencia 3 4 5
  if [ $juego_encendido == false ]; then return; fi
  coicidencia 6 7 8
  if [ $juego_encendido == false ]; then return; fi
  coicidencia 0 4 8
  if [ $juego_encendido == false ]; then return; fi
  coicidencia 2 4 6
  if [ $juego_encendido == false ]; then return; fi
  coicidencia 0 3 6
  if [ $juego_encendido == false ]; then return; fi
  coicidencia 1 4 7
  if [ $juego_encendido == false ]; then return; fi
  coicidencia 2 5 8
  if [ $juego_encendido == false ]; then return; fi

  if [ $turno -gt 9 ]; then 
    juego_encendido=false
    echo "Empate!"
  fi
}

bienvenida
tablero
echo "Quieres jugar con la computadora? [Y/n]"
read quien
echo $quien
if [[ $quien == "n" ]]
then
  juego=0
fi

while $juego_encendido
do
  seleccion_jugador
  tablero
  checar_ganador
done
