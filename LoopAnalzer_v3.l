%{
#include <stdio.h>
int forLoopCount = 0, whileLoopCount = 0, doWhileLoopCount = 0, noOfLines = 1;
%}

%%

    /* Regular Expressions for tokens */
"for" {
    printf("Found token 'for' on line: %d\n", noOfLines); 
}

"while" {
    printf("Found token 'while' on line: %d\n", noOfLines); 
}

"do" {
    printf("Found token 'do' on line: %d\n", noOfLines); 
}

    /* Regular Expressions for loops */
for[ \t]*\([^;]*;[^;]*;[^)]*\)[ \t]*\{ {
    printf("Found 'for Loop' on line: %d\n", noOfLines); 
    forLoopCount++;
}
    /* For loop with no brackets on the same line */
for[ \t]*\([^;]*;[^;]*;[^)]*\)[ \t]*$ {
    printf("Found 'for Loop with no brackets' on line: %d\n", noOfLines);
    forLoopCount++;
}


while[ \t]*\([^)]*\)[ \t]*\{ {
    printf("Found 'while Loop' on line: %d\n", noOfLines); 
    whileLoopCount++;
}

    /* While loop with no brackets on the same line */
while[ \t]*\([^)]*\)[ \t]*$ {
    printf("Found 'while Loop with no brackets' on line: %d\n", noOfLines);
    whileLoopCount++;
}

do[ \t]*\{[^}]*\}[ \t]*while[ \t]*\([^;]*\); {
    printf("Found 'do-while Loop' on line: %d\n", noOfLines); 
    doWhileLoopCount++;
}

    /* Do-while loop with no brackets on the same line */
do[ \t]*$[^}]*$[ \t]*while[ \t]*\([^;]*\); {
    printf("Found 'do-while Loop with no brackets' on line: %d\n", noOfLines);
    doWhileLoopCount++;
}


\n        { noOfLines++; } // Count number of lines
.         { } // Ignore all other characters
%%

int main() {

    yyin = fopen("c++/t2.cpp", "r");
    if (yyin == NULL) {
        printf("Failed to open file\n");
        return 1;
    }

    yylex();

    int totalLoops = forLoopCount + whileLoopCount + doWhileLoopCount;

    printf("\n -- Summary -- \n");
    printf("Total number of lines: %d\n", noOfLines);
    printf("Total number of loops: %d\n", totalLoops);
    printf("\n -- Breakdown of loops -- \n");
    printf("Number of for loops: %d\n", forLoopCount);
    printf("Number of while loops: %d\n", whileLoopCount);
    printf("Number of do-while loops: %d\n", doWhileLoopCount);

    fclose(yyin); // Close the file
        
    return 0;
}

int yywrap() {
    return 1;
}
