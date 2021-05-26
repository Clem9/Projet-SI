
DIR_TEST = tests
DIR_SOURCE = src
DIR_BUILD = build


FILE_TEST= test1.c
LEX = al.lex
EXE_LEX = compile
OUT_LEX = yy.lex.c
YACC = as.y
OUT_YACC = as.y.tab.c
SOURCES = tableInstructions.c src/tableSymboles.c
all:
	mkdir -p $(DIR_BUILD)
	yacc -b $(DIR_BUILD)/$(YACC) -d $(DIR_SOURCE)/$(YACC)
	lex -o $(DIR_BUILD)/$(OUT_LEX) $(DIR_SOURCE)/$(LEX) 
	gcc $(DIR_BUILD)/$(OUT_LEX) $(DIR_SOURCE)/$(SOURCES) $(DIR_BUILD)/$(OUT_YACC) -o $(DIR_BUILD)/$(EXE_LEX) -Ibuild -Isrc
test:
	$(DIR_BUILD)/$(EXE_LEX) < $(DIR_TEST)/$(FILE_TEST)