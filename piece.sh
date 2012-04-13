#!/bin/bash

# Script shell bash qui permet de lancer les éléments d'une piece
# (Air, Thermometre et Chauffafe) en une seule fois, avec un seul
# passage de parametre.
# Les parametres sont :
# - adrMulticast : Adresse multicast de la piece
# - portMulticast : Port multicast de la piece
# - nomPiece : Le nom de la piece
# - adrSysteme : Adresse du systeme central
# - portSysteme : Port du systeme central

if [ $# -eq 5 ]
then
     set $1 $2 $3 $4 $5
elif [ $# -eq 3 ]
then
     set $1 $2 $3 localhost 12000
elif [ $# -eq 1 ] && [ $1 = "test" ]
then
     set 224.3.14.16 6000 chambre localhost 12000
else
     echo "Usage: ./piece.sh adrMulticast portMulticast nomPiece adrSysteme portSysteme
          - adrMulticast : Adresse multicast de la piece
          - portMulticast : Port multicast de la piece
          - nomPiece : Le nom de la piece
          - adrSysteme : Adresse du systeme central
          - portSysteme : Port du systeme central"
     exit 1;
fi

gnome-terminal --hide-menubar \
     --tab-with-profile=Default -t "Air" -e "java Air $1 $2 $3" \
     --tab-with-profile=Default -t "Thermometre" -e "java Thermometre $1 $2 $4 $5" \
     --tab-with-profile=Default -t "Chauffage" -e "java Chauffage $1 $2 $3 $4 $5"
