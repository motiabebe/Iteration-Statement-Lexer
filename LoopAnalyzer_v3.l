%{
#include <stdio.h>
int forLoopCount = 0, whileLoopCount = 0, doWhileLoopCount = 0, noOfLines = 1;
%}

%%

    /* Regular Expressions for loops */

    /* 
        [ \t]* = 0 or more spaces or tabs
        [^;]* = 0 or more characters that are not a semicolon
        [^)]* = 0 or more characters that are not a closing bracket
        [^}]* = 0 or more characters that are not a closing curly bracket
        [ \n] = 0 or more spaces or tabs or new lines
    */

    /* 

        This section contains expressions for for loops.
        
        The first expression is for a for loop that incompletely written.
        The second expression is for a for loop that is on the same line as the for keyword.
        The third expression is for a for loop that has the opening bracket on the next line.

    */

    /* expression for incomplete for loop */
"for"[ \t]*\([^;]*;[^;]*;[^)]*\)[ \t]* {
    printf("Found a 'for' loop token on line: %d\n", noOfLines);
}

    /* expression for for loop */
for[ \t]*\([^;]*;[^;]*;[^)]*\)[ \t]*\{[^}]*\} {
    printf("Found a 'for' loop on line: %d\n", noOfLines); 
    forLoopCount++;
}

    /* expression for for loop with brackets on the next line */
for[ \t]*\([^;]*;[^;]*;[^)]*\)[ \t]*[ \n]+\{[^}]*\} {
    printf("Found a 'for' loop with brackets on the next line on line: %d\n", noOfLines);
    forLoopCount++;
}



    /* 

        This section contains expressions for while loops.
        
        The first expression is for a while loop that is on the same line as the while keyword.
        The second expression is for a while loop that has the opening bracket on the next line.

    */

    /* expression for while loop */
while[ \t]*\([^)]*\)[ \t]*\{ {
    printf("Found a 'while' loop on line: %d\n", noOfLines); 
    whileLoopCount++;
}

    /* expression for while loop with brackets on the next line */
while[ \t]*\([^)]*\)[ \t]*[ \n] {
    printf("Found a 'while' loop with brackets on the next line on line: %d\n", noOfLines);
    whileLoopCount++;
}

    /* 

        This section contains expressions for do-while loops.
        
        The first expression is for a do-while loop that is on the same line as the do keyword.
        The second expression is for a do-while loop that has the opening bracket on the next line.

    */

    /* expression for do-while loop */
do[ \t]*\{[^}]*\}[ \t]*while[ \t]*\([^;]*\); {
    printf("Found a 'do-while' loop on line: %d\n", noOfLines); 
    doWhileLoopCount++;
}

    /* expression for do-while loop with brackets on the next line */
do[ \n]*\{[ \n]*[^}]*[ \n]*\}[ \t]*while[ \t]*\([^;]*\); {
    printf("Found a 'do-while' loop with brackets on the next line on line: %d\n", noOfLines);
    doWhileLoopCount++;
}


\n        { noOfLines++; } // Count number of lines
.         { } // Ignore all other characters
%%

int main() {

    yyin = fopen("c++/t3.cpp", "r");
    if (yyin == NULL) {
        printf("Failed to open file\n");
        return 1;
    }

    yylex();

    int totalLoops = forLoopCount + whileLoopCount + doWhileLoopCount;

    printf("\n -- Summary -- \n");
    printf("Expected number of lines: %d\n", 70);
    printf("Total number of lines: %d\n", noOfLines);
    printf("Expected number of loops: %d\n", 8);
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
