%{
#include "tableInstructions.h"
#include "as.y.tab.h"
%}

NOMBRE (-)?[0-9]+("e"(-)?[0-9]+)?


%%

"+"			{ return tADD; }
"-"			{ return tSUB; }
"("			{ return tOB; }
")"			{ return tCB; }
";"			{ return tPV; }
"main"      { return tMAIN; }
"const"     { return tCONST;}
"{"			{ return tOA; }
"}"			{ return tCA; }
"int"		{ return tINT; }
"*"			{ return tMUL; }
"/"			{ return tDIV; }
"="			{ return tEG; }
"=="		{ return tDOUBLEEG; }
"<"			{ return tINF; }
">"			{ return tSUP; }
","			{ return tV; }
"\t"		{ }
"\n"		{ }
"||"		{ return tOR;}
"not"		{ return tNOT;}
"&&"		{ return tAND;}
"printf"	{ return tPRINT;}
"if"		{ return tIF;}
"else"		{ return tELSE;}
"while"		{return tWHILE;}
" "			{ }
"void"		{return tVOID;}

[a-zA-Z_]+ { yylval.str = (char *) malloc(yyleng * sizeof(char));
        		strcpy(yylval.str, yytext);
				return tMOT;
			}
			
{NOMBRE}	{ yylval.nb = atoi(yytext);
				return tNB;
			}
			
.			{ return tERROR; }



%%

int yywrap(void){return 1;}

//int main(void){
//	yylex();
//}


