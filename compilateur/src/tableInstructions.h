#ifndef TABLE_INSTRUCTIONS_H
#define TABLE_INSTRUCTIONS_H

#include "tableSymboles.h"


#define INSTR_TABLE_SIZE 50

typedef enum Instruction{
	ADD, 
	MUL, 
	SOU, 
	DIV,
	COP,
	AFC,
	JMP,
	JMF,
	INF,
	SUP,
	EQU,
	PRI
}Instruction;


typedef struct LigneInstruction{
	Instruction instruction;
	int arg1;
	int arg2;
	int arg3;
}LigneInstruction;


int getIndexInstrs();

/**
 * Affiche la table des instructions
 * @param None
 */
void afficherTableInstructions();


/**
 * Crée et remplie le fichier des instructions ASM
 * @param None
 */
void creationFichierASM();

/**
 * Convertie une logne d'instructions en string
 * @param instr
 * @return une ligne d'instruction sous forme de string
 */
char * ecrireASM(LigneInstruction instr);


/**
 * Ajoute une instruction dans la table, à l'indice accessible
 * @param instr
 * @param arg1
 * @param arg2
 * @param arg3
 */
void ajouterInstruction3(Instruction instr, int arg1, int arg2, int arg3);

/**
 * Ajoute une instruction dans la table, à l'indice accessible
 * @param instr
 * @param arg1
 * @param arg2
 */
void ajouterInstruction2(Instruction instr, int arg1, int arg2);


/**
 * Ajoute une instruction dans la table, à l'indice accessible
 * @param instr
 * @param arg1
 */
void ajouterInstruction1(Instruction instr, int arg1);

/**
 * Ajoute un calcul dans la table
 * @param instr
 * @param arg1
 * @param arg2
 * @return l'adresse du calcul 
 */
int ajouterCalcul(Instruction instr, int arg1, int arg2);


/**
 * Ajoute une copie dans la table
 * @param var
 * @param arg1
 * @param type
 * @return l'adresse du symbole ajouté
 */
int ajouterCopie(char* var,int arg1, enum Type type);

/**
 * Ajoute une copie de var temporaire dans la table (lui affecte sa valeur)
 * @param arg1
 * @param type
 * @return l'adresse du symbole ajouté
 */
int ajouterCopieTemp(int arg1, enum Type type);

/**
 * Ajoute une affectation dans la table
 * @param var
 * @param arg1
 */
void ajouterAffectaction(char* var,int arg1);


/**
 * Ajoute un print dans la table
 * @param var
 */
void ajouterPrint(char * var);


/**
 * Ajoute un jump dans la table
 * @param arg1
 * @return l'adresse du JMF
 */
int ajouterJump(int arg1);


/**
 * Update un jump dans la table (pour les JMF)
 * @param addr
 * @return l'adresse du JMF
 */
int updateJump(int addr);


/**
 * Update un jump dans la table (pour les JMP Else)
 * @param addr
 */
void updateJumpElse(int addr);


/**
 * Update un jump dans la table (pour les JMP While)
 * @param addr
 */
void updateJumpWhile(int addr1, int addr2);







#endif
