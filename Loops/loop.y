%{
#include<stdio.h>
#include<string.h>
void yyerror(const char* st);
int yywrap();

%}

%token FOR OPEN CLOSE CLOSEparan OPENparan SEMI TEXT END DO WHILE BLOCK

%type<str> S s st do for FOR OPEN CLOSE CLOSEparan OPENparan SEMI TEXT END DO WHILE BLOCK

%union{
	char *str;
}

%%

S:	for S
	| do S
	| s S
	|;

for: FOR OPEN TEXT SEMI TEXT SEMI TEXT CLOSE {printf("%s;\nwhile(%s)",$3,$5);} OPENparan{printf("{");} s {printf("%s;\n",$7);}CLOSEparan {printf("}");};

s:	TEXT{printf("%s",$1);} SEMI{printf(";");} S
	|BLOCK{printf("%s",$1);}
	| ;

st: TEXT SEMI st
	| ;

do:	DO OPENparan st CLOSEparan WHILE OPEN TEXT CLOSE SEMI {printf("while(%s){%s;}",$7,$3);};
	
%%

void yyerror(const char* st){
	printf("error: %s\n",st);
}

int yywrap(){	return 1;	}

int main(){	yyparse();	}
