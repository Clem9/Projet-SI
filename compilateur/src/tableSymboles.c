#include "tableSymboles.h"
#include <stdio.h>
#include<string.h>


typedef struct Symbole 
{
	char * name;
	enum Type type;
	int initialised; // 0 : Not inistialised, 1 : initialised
}Symbole;

struct Symbole table[TABLE_SIZE];

/* Indice dans la table, et également adresse du symbole*/
int indexTop = 0; 
/* Indice dans la table, et également adresse du symbole temporaire*/
int indexBottom = TABLE_SIZE - 1;


/**
 * Affiche la table des symboles
 * @param None
 */
void afficherTableSymboles(){
	char * typeVar;
	char * init;
	printf("	+---------------------------------------------+\n");
	printf("	|               Table des symboles            |\n");
	printf("	+---------------------------------------------+\n");

	for (int i=0; i < indexTop ; i++) {
		if ((table[i].type) == TYPE_INT) {typeVar = "Int";}
		else {typeVar = "Const int";}
		if (table[i].initialised == 0) {init = "Non initialisée";}
		else {init = "Initialisée";}

		printf("	| %5s | %9s | %8s | %3d |\n",table[i].name, typeVar , init, i);
		printf("	+---------------------------------------------+\n");
	}

	printf("	+---------------------------------------------+\n");
	printf("	|             Variables temporaires           |\n");
	printf("	+---------------------------------------------+\n");

	for (int i=(indexBottom+1); i < TABLE_SIZE; i++) {
		if ((table[i].type) == TYPE_INT) {typeVar = "Int";}
		else {typeVar = "Const int";}
		if (table[i].initialised == 0) {init = "Non initialisée";}
		else {init = "Initialisée";}

		printf("	| %5s | %9s | %8s | %3d |\n",table[i].name, typeVar, init, i);
		printf("	+---------------------------------------------+\n");
	}

}

/**
 * Vérifie si un symbole donnée est, ou non, dans la table
 * @param nameVar
 * @return 1 si le symbole appartient à la table, 0 sinon
 */
int hasSymbole(char * nameVar){
	   for (int i = 0; i < indexTop; i++){
        if (strcmp(nameVar, table[i].name) == 0){
            return 1;
        }
    }

    for (int i = (indexBottom + 1); i < TABLE_SIZE; i++){
        if (strcmp(nameVar, table[i].name) == 0){
            return 1;
        }
    }
    return 0;
}


/**
 * Ajoute un symbole dans la table, à l'indice accessible en haut de la table
 * @param nomVar
 * @param typeVar
 * @param init
 * @return 0 si le symbole a bien été ajouté, -1 si la table est pleine, et -2 si le symbole est déjà dans la table
 */
int ajouterSymboleTop(char * nomVar, enum Type typeVar , int init){
	if (indexTop < 0 ||indexTop >= TABLE_SIZE ||indexTop > indexBottom){
		printf("Erreur d'ajout au niveau de l'indice \n");
		return (-1);
	}
	else if (hasSymbole(nomVar) == 1 ){
		printf("Erreur : symbvole déjà présent dans la table \n");
		return (-2);
	}
	else{ //Ajout du symbole :
		struct Symbole symbole;
		symbole.name = nomVar;
		symbole.type = typeVar;
		symbole.initialised = init;
		table[indexTop] = symbole;
		indexTop ++;
		return(indexTop-1);
	}

}

/**
 * Ajoute un symbole temporaire dans la table, à l'indice accessible en bas de la table
 * @param typeVar
 * @param init
 * @return 0 si le symbole a bien été ajouté et -1 si la table est pleine
 */
int ajouterSymboleBottom(enum Type typeVar , int init){
	if (indexBottom < 0 ||indexBottom >= TABLE_SIZE ||indexBottom < indexTop){
		printf("Erreur d'ajout au niveau de l'indice \n");
		return (-1);
	}
	else{ //Ajout du symbole :
		struct Symbole symbole;
		symbole.name = "_NBTemp";
		symbole.type = typeVar;
		symbole.initialised = init;
		table[indexBottom] = symbole;
		indexBottom --;
		return(indexBottom+1);
	}

}


/**
 * Libère une variable temporaire.
 */
void libererVarTemp(){
	indexBottom = TABLE_SIZE - 1;
}


/**
 * Renvoie l'adresse d'un symbole dans la table
 * @param nomVar
 * @return l'adresse du symbole passé en paramètre, -1 s'il n'est pas dans la table
 */
int getAdresse(char * nomVar){
	for (int i = 0; i < indexTop; i++){
        if (strcmp(nomVar, table[i].name) == 0){
            return i;
        }
    }
    for (int i = (indexBottom + 1); i < TABLE_SIZE; i++){
        if (strcmp(nomVar, table[i].name) == 0){
            return i;
        }
    }
    return -1;
}



/**
 * Renvoie l'adresse un symbole qui est dans la table
 * @param nameVar
 * @return l'adresse s'il est dans la table, -1 sinon
 */
int findSymbole(char * nameVar){
	for (int i = 0; i < indexTop; i++){
        if (strcmp(nameVar, table[i].name) == 0){
             return i;
        }
    }
    return (-1);
}

/**
 * Marque qu'un symbole vient d'être initialisé
 * @param nomVar
 */
void initialisationSymbole(char * nomVar){
	int i = getAdresse(nomVar);
	if (table[i].type == TYPE_CONST_INT){
		printf("Erreur : on ne peux pas changer la valeur d'une constante.\n");
	}
	else{
		table[i].initialised = 1;
	}
}



