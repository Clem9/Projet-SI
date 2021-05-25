#include "tableInstructions.h"
#include "tableSymboles.h"
#include <stdio.h>
#include<string.h>
#include <stdlib.h>

char * print_instructions[12] = {
        "ADD",
        "MUL",
        "SOU",
        "DIV",
        "COP",
        "AFC",
        "JMP",
        "JMF",
        "INF",
        "SUP",
        "EQU",
        "PRI"
};


struct LigneInstruction tableInstructions[INSTR_TABLE_SIZE];

/* Indice dans la table*/
int indexInstrs = 0; 

int getIndexInstrs(){
	return indexInstrs;
}

/**
 * Affiche la table des instructions
 * @param None
 */
void afficherTableInstructions() {

	printf("	+------------------------------------------------+\n");
	printf("	|                 Code assembleur                |\n");
	printf("	+------------------------------------------------+\n");
	for (int i=0; i < indexInstrs ; i++) {
		printf("	| %2d | %3s | %10d | %10d |%10d |\n",i, print_instructions[tableInstructions[i].instruction], tableInstructions[i].arg1, tableInstructions[i].arg2, tableInstructions[i].arg3);
			printf("	+------------------------------------------------+\n");
	}

}


/**
 * Crée et remplie le fichier des instructions ASM
 * @param None
 */
void creationFichierASM(){
	FILE * f;
	f = fopen("output.txt","w");
	if (f != NULL){
		for (int i = 0; i < indexInstrs; i++){
			char * ligne = ecrireASM(tableInstructions[i]);
			fputs(ligne, f);
			free(ligne);
		}
		fclose(f);
	}
	else
		perror("error.txt");
}



/**
 * Convertie une logne d'instructions en string
 * @param instr
 * @return une ligne d'instruction sous forme de string
 */
char * ecrireASM(LigneInstruction instr){
	char * tab = malloc(sizeof(char)*200);
	switch (instr.instruction){
		case ADD:
			sprintf(tab,"ADD %3d %3d %3d\n",instr.arg1, instr.arg2, instr.arg3);
			break;
		case MUL:
			sprintf(tab,"MUL %3d %3d %3d\n",instr.arg1, instr.arg2, instr.arg3);
			break;
		case SOU:
			sprintf(tab,"SOU %3d %3d %3d\n",instr.arg1, instr.arg2, instr.arg3);
			break;
		case DIV:
			sprintf(tab,"DIV %3d %3d %3d\n",instr.arg1, instr.arg2, instr.arg3);
			break;
		case COP:
			sprintf(tab,"COP %3d %3d\n",instr.arg1, instr.arg2);
			break;
		case AFC:
			sprintf(tab,"AFC %3d %3d\n",instr.arg1, instr.arg2);
			break;
		case JMP:
			sprintf(tab,"JMP %3d\n",instr.arg1);
			break;
		case JMF:
			sprintf(tab,"JMF %3d %3d\n",instr.arg1, instr.arg2);
			break;
		case INF:
			sprintf(tab,"INF %3d %3d %3d\n",instr.arg1, instr.arg2, instr.arg3);
			break;
		case SUP:
			sprintf(tab,"SUP %3d %3d %3d\n",instr.arg1, instr.arg2, instr.arg3);
			break;
		case EQU:
			sprintf(tab,"DIV %3d %3d %3d\n",instr.arg1, instr.arg2, instr.arg3);
			break;
		case PRI:
			sprintf(tab,"PRI %3d\n",instr.arg1);
			break;
	}
	return tab;
}




/**
 * Ajoute une instruction dans la table, à l'indice accessible
 * @param instr
 * @param arg1
 * @param arg2
 * @param arg3
 */
void ajouterInstruction3(Instruction instr, int arg1, int arg2, int arg3){
	if (indexInstrs < 0 ||indexInstrs >= INSTR_TABLE_SIZE){
		printf("Erreur d'ajout au niveau de l'indice \n");
	}
	else{
		LigneInstruction instru;
		instru.instruction = instr;
		instru.arg1 = arg1;
		instru.arg2 = arg2;
		instru.arg3 = arg3;
		tableInstructions[indexInstrs] = instru;
		indexInstrs ++;
	}
}


/**
 * Ajoute une instruction dans la table, à l'indice accessible
 * @param instr
 * @param arg1
 * @param arg2
 */
void ajouterInstruction2(Instruction instr, int arg1, int arg2){
	ajouterInstruction3(instr,arg1,arg2,0);
}


/**
 * Ajoute une instruction dans la table, à l'indice accessible
 * @param instr
 * @param arg1
 */
void ajouterInstruction1(Instruction instr, int arg1){
	ajouterInstruction3(instr,arg1,0,0);
}


/**
 * Ajoute un calcul dans la table
 * @param instr
 * @param arg1
 * @param arg2
 * @return l'adresse du calcul 
 */
int ajouterCalcul(Instruction instr, int arg1, int arg2){
	int addr_temp = ajouterSymboleBottom(TYPE_INT, 1);
	ajouterInstruction3(instr, addr_temp, arg1, arg2);
	return addr_temp;
}

/**
 * Ajoute une copie dans la table
 * @param var
 * @param arg1
 * @param type
 * @return l'adresse du symbole ajouté
 */
int ajouterCopie(char* var,int arg1, enum Type type){
	int addr = ajouterSymboleTop(var,type,1);
	ajouterInstruction2(COP,addr,arg1);
	return addr;
}

/**
 * Ajoute une copie de var temporaire dans la table (lui affecte sa valeur)
 * @param arg1
 * @param type
 * @return l'adresse du symbole ajouté
 */
int ajouterCopieTemp(int arg1, enum Type type){
	int addr_temp = ajouterSymboleBottom(type,1);
	ajouterInstruction2(COP,addr_temp,arg1);
	return addr_temp;
}

/**
 * Ajoute une affectation dans la table
 * @param var
 * @param arg1
 */
void ajouterAffectaction(char* var,int arg1){
	int addr = findSymbole(var);
	ajouterInstruction2(AFC,addr,arg1);
}


/**
 * Ajoute un print dans la table
 * @param var
 */
void ajouterPrint(char * var){
	int addr = findSymbole(var);
	ajouterInstruction1(PRI,addr);
}


/**
 * Ajoute un jump dans la table
 * @param addr
 */
int ajouterJump(int arg1){
	ajouterInstruction2(JMF,arg1,-1); 
	return indexInstrs-1;
}


int updateJump(int addr){
	tableInstructions[addr].arg2 = indexInstrs+1;
  	ajouterInstruction1(JMP, -1);
  	return indexInstrs-1;
}


void updateJumpElse(int addr){
	tableInstructions[addr].arg1 = indexInstrs;
}


void updateJumpWhile(int addr1, int addr2){
	int addr_jump = updateJump(addr1);
	tableInstructions[addr_jump].arg1 = addr2;
}















