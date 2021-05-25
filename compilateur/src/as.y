%{
#include <stdio.h>
#include "tableInstructions.h"
#include "tableSymboles.h"

int yylex();
void yyerror (char*);

enum Type type; // = TYPE_INT

%}

%union {
	int nb;
	char * str;
  	Instruction instr;
}

%token <nb> tNB
%token tADD
%token tSUB
%token <nb>tOB
%token tCB
%token tPV
%token tMAIN
%token tCONST
%token tOA
%token tCA
%token tINT
%token tMUL
%token tDIV
%token tEG
%token tDOUBLEEG
%token tV
%token tTAB
%token tRL
%token tPRINT
%token <nb>tIF
%token tELSE
%token tERROR
%token <str> tMOT
%token tVOID
%token <nb>tWHILE
%token tSUP
%token tINF
%token tAND
%token tOR
%token tNOT

%type <nb> Operation
%type <nb> CopieVar
%type <nb> NomsVars
%type <instr> Opp



%%

S : Main
  ;

Main : tINT tMAIN tOB tCB Body {afficherTableSymboles(); 
								afficherTableInstructions();
								creationFichierASM();}
	 ;

Body : tOA DeclaVars Instrs tCA
     ;

DeclaVars : Declavar DeclaVars 
		  | 
		  ;

Declavar : Type NomsVars tPV
         ;

Type : tINT {type = TYPE_INT;} 
	 | tCONST tINT {type = TYPE_CONST_INT;}
	 ;

NomsVars : tMOT CopieVar {$$ = ajouterCopie($1,$2,type); libererVarTemp();}  
		 | tMOT {ajouterSymboleTop($1,type,0);} MultiVars
		 ;

CopieVar : tEG Operation {$$ = $2;}
		 ;


MultiVars : tV NomsVars
		  | 
		  ;


Instrs : Instr Instrs
	   | 
	   ;

Instr : Print 
	  | If 
	  | While 
	  | Affectation 
	  ;

Print : tPRINT tOB tMOT tCB tPV {ajouterPrint($3);}
	  ;

If : tIF tOB Operation tCB {$1 = ajouterJump($3);} Body {$1 = updateJump($1);} tELSE Body 	{updateJumpElse($1);}  
   ;  

While : tWHILE tOB {$2 = getIndexInstrs();} Operation tCB {$1 = ajouterJump($4);} Body {updateJumpWhile($1,$2);} 
	  ;


Affectation : tMOT tEG Operation tPV {initialisationSymbole($1); ajouterAffectaction($1,$3);libererVarTemp();}
			;

Operation : Operation Opp Operation {$$ = ajouterCalcul($2,$1,$3);}
		  | tSUB Operation {int addr = ajouterSymboleBottom(type,1); 
							  ajouterInstruction2(COP,addr,0); 
							  $$ = ajouterCalcul(SOU,addr,$2); }
		  | tOB Operation tCB {$$=$2;}
		  | tMOT {$$ = findSymbole($1);}
		  | tNB {$$ = ajouterCopieTemp($1,type);}
		  ;



Opp : tADD {$$ = ADD;}
  	| tMUL {$$ = MUL;}  
  	| tSUB {$$ = SOU;} 
  	| tDIV {$$ = DIV;} 
  	| tAND {$$ = MUL;} 
  	| tOR  {$$ = ADD;}
  	| tDOUBLEEG {$$ = EQU;}
  	| tSUP {$$ = SUP;}
  	| tINF {$$ = INF;}
  	;

%%

void yyerror(char *s){
  printf("Error : %s\n",s); 
}

int main(void) {
	return yyparse();
}






