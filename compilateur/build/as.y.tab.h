/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     tNB = 258,
     tADD = 259,
     tSUB = 260,
     tOB = 261,
     tCB = 262,
     tPV = 263,
     tMAIN = 264,
     tCONST = 265,
     tOA = 266,
     tCA = 267,
     tINT = 268,
     tMUL = 269,
     tDIV = 270,
     tEG = 271,
     tDOUBLEEG = 272,
     tV = 273,
     tTAB = 274,
     tRL = 275,
     tPRINT = 276,
     tIF = 277,
     tELSE = 278,
     tERROR = 279,
     tMOT = 280,
     tVOID = 281,
     tWHILE = 282,
     tSUP = 283,
     tINF = 284,
     tAND = 285,
     tOR = 286,
     tNOT = 287
   };
#endif
/* Tokens.  */
#define tNB 258
#define tADD 259
#define tSUB 260
#define tOB 261
#define tCB 262
#define tPV 263
#define tMAIN 264
#define tCONST 265
#define tOA 266
#define tCA 267
#define tINT 268
#define tMUL 269
#define tDIV 270
#define tEG 271
#define tDOUBLEEG 272
#define tV 273
#define tTAB 274
#define tRL 275
#define tPRINT 276
#define tIF 277
#define tELSE 278
#define tERROR 279
#define tMOT 280
#define tVOID 281
#define tWHILE 282
#define tSUP 283
#define tINF 284
#define tAND 285
#define tOR 286
#define tNOT 287




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 13 "src/as.y"
{
	int nb;
	char * str;
  	Instruction instr;
}
/* Line 1529 of yacc.c.  */
#line 119 "build/as.y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

