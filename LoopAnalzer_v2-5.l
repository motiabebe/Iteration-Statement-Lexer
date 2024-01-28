%{
#include <stdio.h>
int forLoopCount = 0, whileLoopCount = 0, dowhileLoopCount = 0, noOfLines =  1;

%}

%%

while[ \t]*\([^)]*\)[ \t]*\{ {printf("Found 'while Loop' on line: %d\n", noOfLines), whileLoopCount++;}


do[ \t]*\{[^}]*\}[ \t]*while[ \t]*\([^;]*\); {printf("Found 'do-while Loop' on line:: %d\n", noOfLines); dowhileLoopCount++;}


for[ \t]*\([^;]*;[^;]*;[^)]*\)[ \t]*\{ {printf("Found 'for Loop' on line: %d\n", noOfLines); forLoopCount++;}


while[ \t]*\(?[^;{}]*\)?[ \t]*$ {printf("Found token 'while' on line: %d\n", noOfLines);}

for[ \t]*\(?[^)]*\)?[ \t]*$ {printf("Found token 'for' on line: %d\n", noOfLines);}

do[ \t]*\{?\}? { printf( "Found token 'do' on line %d\n", noOfLines );}
\n { noOfLines++; }

. ;
%%

int main() {

    yyin = fopen("c++/t.cpp", "r");
    if (yyin == NULL) {
        printf( "File Opening failed ! ");
        return 1;
    }

    yylex();

    printf("______________________________\n\n");
    printf("Number of for Loops: %d\n", forLoopCount);
    printf("Number of while Loops: %d\n", whileLoopCount);
    printf("Number of do_while Loops: %d\n", dowhileLoopCount);
    
    printf("Total Number of lines: %d\n", noOfLines);
    printf("Total Number of Loops: %d\n", forLoopCount + whileLoopCount + dowhileLoopCount);

    fclose(yyin);
    
    return 0;
}

int yywrap() {
        return 1;
}
