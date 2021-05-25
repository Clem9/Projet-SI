#ifndef TABLE_SYMBOLES_H
#define TABLE_SYMBOLES_H

#define TABLE_SIZE 50

enum Type 
{
	TYPE_INT, 
	TYPE_CONST_INT
};


/**
 * Affiche la table des symboles
 * @param None
 */
void afficherTableSymboles();


/**
 * Vérifie si un symbole donnée est, ou non, dans la table
 * @param nameVar
 * @return 1 si le symbole appartient à la table, 0 sinon
 */
int hasSymbole(char * nameVar);


/**
 * Ajoute un symbole dans la table, à l'indice accessible en haut de la table
 * @param nomVar
 * @param typeVar
 * @param init
 * @return 0 si le symbole a bien été ajouté, -1 si la table est pleine, et -2 si le symbole est déjà dans la table
 */
int ajouterSymboleTop(char * nomVar, enum Type typeVar , int init);

/**
 * Ajoute un symbole temporaire dans la table, à l'indice accessible en bas de la table
 * @param typeVar
 * @param init
 * @return 0 si le symbole a bien été ajouté, -1 si la table est pleine, et -2 si le symbole est déjà dans la table
 */
int ajouterSymboleBottom(enum Type typeVar , int init);

/**
 * Libère une variable temporaire.
 */
void libererVarTemp();

/**
 * Renvoie l'adresse d'un symbole dans la table
 * @param nomVar
 */
int getAdresse(char * nomVar);


/**
 * Renvoie l'adresse un symbole qui est dans la table
 * @param nameVar
 * @return l'adresse s'il est dans la table, -1 sinon
 */
int findSymbole(char * nameVar);


/**
 * Marque qu'un symbole vient d'être initialisé
 * @param nomVar
 */
void initialisationSymbole(char * nomVar);


#endif

