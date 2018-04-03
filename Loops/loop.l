%{
	#include<stdio.h>
	#include "y.tab.h"
%}

text [a-zA-Z0-9+\-=/*<>!&|,]
block [a-zA-Z0-9.]
%%
for			yylval.str=strdup(yytext);return FOR;
do			yylval.str=strdup(yytext);return DO;
while			yylval.str=strdup(yytext);return WHILE;
"("			yylval.str=strdup(yytext);return OPEN;
")"			yylval.str=strdup(yytext);return CLOSE;
"{"			yylval.str=strdup(yytext);return OPENparan;
"}"			yylval.str=strdup(yytext);return CLOSEparan;
";"			yylval.str=strdup(yytext);return SEMI; 
({text}" "?)*		yylval.str=strdup(yytext);return TEXT;
({block}" "?)*		yylval.str=strdup(yytext);return BLOCK;
[\n \t]+		printf("%s",yytext);
.			yylval.str=strdup(yytext);return END;
%%
