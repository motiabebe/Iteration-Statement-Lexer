%{
#include <stdio.h>
int forLoopCount = 0, whileLoopCount = 0, doWhileLoopCount = 0, noOfLines = 1;
%}

%%

for[ \t]*\([^;]*;[^;]*;[^)]*\)[ \t]*\{ { forLoopCount++; printf("Found 'for' loop on line %d\n", noOfLines); }
while[ \t]*\([^)]*\)[ \t]*\{ { whileLoopCount++; printf("Found 'while' loop on line %d\n", noOfLines); }
do[ \t]*\{[^}]*\}[ \t]*while[ \t]*\([^;]*\); { doWhileLoopCount++; printf("Found 'do-while' loop on line %d\n", noOfLines); }

\n        { noOfLines++; }
.         { } // Ignore all other characters
%%

int main() {

    yyin = fopen("c++/t2.cpp", "r");
    if (yyin == NULL) {
        printf("Failed to open file\n");
        return 1;
    }

    yylex();

    printf("Total number of lines: %d\n", noOfLines);
    printf("Total number of loops: %d\n", forLoopCount + whileLoopCount + doWhileLoopCount);
    printf("\n");
    printf("Number of for loops: %d\n", forLoopCount);
    printf("Number of while loops: %d\n", whileLoopCount);
    printf("Number of do-while loops: %d\n", doWhileLoopCount);

    fclose(yyin); // Close the file
        
    return 0;
}

int yywrap() {
    return 1;
}