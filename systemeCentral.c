#include <pthread.h>
#include "moduleComm.h"
#include "ordonnanceur.h"

typedef struct Piece Piece;
struct Piece {
     char nom[25];
     int temperature;
     int nivChauffage;
};
Piece *tabValeurs = NULL;

int main(int argc, char *argv[])
{
     if(argc != 2) {
          printf("Erreur dans les arguments !\nParamètre attendu : portEcoute\n");
          return -1;
     }

     int port = atoi(argv[1]);
     printf("sizeof(Piece) = %d\n", sizeof(Piece));

     Piece *temp = NULL;
     temp = realloc(tabValeurs, sizeof(Piece));

     if (temp != NULL)
          tabValeurs = temp;
     else {
          printf("Erreur realloc\n");
          return -1;
     }

     tabValeurs[0].temperature = 5;
     strcpy(tabValeurs[0].nom, "polo");
     printf("temperature = %d\n", tabValeurs[0].temperature);
     printf("nom = %s\n", tabValeurs[0].nom);

     return 0;

     //Déclaration d'un thread
	const int nbThread = 2;
	pthread_t thread[nbThread];

     pthread_create(&thread[0], NULL, init_moduleComm, (void*)&port);
     pthread_create(&thread[1], NULL, init_ordonnanceur, NULL);

	int i;
	for(i = 0; i < nbThread; ++i)
	     pthread_join(thread[i], NULL);

     return 0;
}
