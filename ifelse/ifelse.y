%{
#include <stdio.h>
#include <stdlib.h>
extern FILE *yyin;
int ifcount = 0 ,elsecount = 0 , a ,i;
%}
%token IF ELSE VARIABLE COMP UNARY BIN NUM
%%
s: ifstmt { printf("Valid statement\n"); }
|
;
ifstmt: IF '(' expr ')' '{'
statements
'}'
{ ifcount++; }
|
IF '(' expr ')' '{'
statements
'}' ELSE '{'
statements
'}'
{ ifcount++; elsecount++;}
;
expr:
VARIABLE
| NUM
| VARIABLE '=' expr
| expr BIN expr
| expr UNARY
| expr COMP expr
|
;
statements:
statement statements
|
;
statement:
ifstmt
| expr ';'
;
%%
yyerror() {
printf("Invalid statement\n");
printf("If statements: %d\n", ifcount);
printf("else statements: %d\n", elsecount);
//printf("If - else : %d\n", a);
exit(1);
}
int main(){
yyin = fopen("ifelse.txt", "r");
yyparse();
if(ifcount > elsecount)
{
	a = ifcount - elsecount;
}	
//printf("If statements: %d\n", ifcount);
//printf("else statements: %d\n", elsecount);
//printf("If - else : %d\n", a);
fclose(yyin);
yyin = fopen("ifelse.txt", "a");
for(i=0;i<a;i++)
{
	fprintf(yyin,"else { }");
}
return 0;
}
