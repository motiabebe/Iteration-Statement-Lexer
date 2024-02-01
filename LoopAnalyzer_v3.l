%{
    /* 
        [ \t]* = 0 or more spaces or tabs
        [^;]* = 0 or more characters that are not a semicolon
        [^)]* = 0 or more characters that are not a closing bracket
        [^}]* = 0 or more characters that are not a closing curly bracket
        [ \n] = 0 or more spaces or tabs or new lines
    */

#include <stdio.h>
int forLoopCount = 0, whileLoopCount = 0, doWhileLoopCount = 0;
int nestedForLoopCount = 0, nestedWhileLoopCount = 0, nestedDoWhileLoopCount = 0;
int noOfLines = 1;

%}

%%

    /*
        This section contains expressions for incomplete for loops. 
     */

    /* for ( */
for[ \t]*\($ {
    printf("Pattern found -> 'for (' \n");
    printf("incomplete 'for' loop on line: %d\n", noOfLines);
}

    /* for () */
for[ \t]*\([^\n]*\)[ \t]*$ {
    printf("Pattern found -> 'for ()' \n");
    printf("incomplete 'for' loop on line: %d\n", noOfLines);
}

    /* for ( ; */
for[ \t]*\([^;]*;[ \t]*\n {
    printf("Pattern found -> 'for (;' \n");
    printf("incomplete 'for' loop on line: %d\n", noOfLines);
}

    /* for ( ; ; */
for[ \t]*\([^;]*;[^;]*;[ \t]*\n {
    printf("Pattern found -> 'for (;;' \n");
    printf("incomplete 'for' loop on line: %d\n", noOfLines);
}

    /* for () { } */
for[ \t]*\([ \t]*\)[ \t]*\{[^}]*\}[ \t]*$ {
    printf("Pattern found -> 'for () { }' \n");
    printf("incomplete 'for' loop on line: %d\n", noOfLines);
}

    /* for ( ; ; ) */
for[ \t]*\([^;]*;[^\n;]*;[^\n)]*\)[ \t]*$ {
    printf("Pattern found -> 'for (;;)' \n");
    printf("incomplete 'for' loop on line: %d\n", noOfLines);
}



    /* 

        This section contains expressions for for loops.
        
        The first expression is for a for loop that is on the same line as the for keyword.
        The second expression is for a for loop that has the opening bracket on the next line.
        The third expression is for a nested for loop that has the opening bracket on the next line.

    */

    /* expression for for loop */
for[ \t]*\([^;]*;[^;]*;[^)]*\)[ \t]*\{[^}]*\} {
    printf("'for' loop on line: %d\n", noOfLines); 
    forLoopCount++;
}

    /* expression for for loop with brackets on the next line */
for[ \t]*\([^;]*;[^;]*;[^)]*\)[ \t]*[ \n]*\{[^}]*\} {
    printf("'for' loop with brackets on the next line on line: %d\n", noOfLines);
    forLoopCount++;
}
    /* expression for nested for loop with brackets on the next line */
for[ \t]*\([^;]*;[^;]*;[^)]*\)[ \t]*[ \n]*\{[ \n]*for[ \t]*\([^;]*;[^;]*;[^)]*\)[ \t]*[ \n]+\{[^}]*\}[^}]*\} {
    printf("nested 'for' loop with brackets on the next line on line: %d\n", noOfLines);
    nestedForLoopCount++;
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

    /* expression for nested while loop with brackets on the next line */
while[ \t]*\([^)]*\)[ \t]*[ \n]*\{[ \n]*while[ \t]*\([^)]*\)[ \t]*[ \n]+\{[^}]*\}[^}]*\} {
    printf("nested 'while' loop with brackets on the next line on line: %d\n", noOfLines);
    nestedWhileLoopCount++;
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

    /* expression for nested do-while loop with brackets on the next line */
do[ \n]*\{[ \n]*[^}]*[ \n]*\}[ \t]*while[ \t]*\([^;]*\);[ \n]*\{[ \n]*do[ \n]*\{[^}]*\}[ \t]*while[ \t]*\([^;]*\);[^}]*\} {
    printf("nested 'do-while' loop with brackets on the next line on line: %d\n", noOfLines);
    nestedDoWhileLoopCount++;
}



\n        { noOfLines++; } // Count number of lines
.         { } // Ignore all other characters
%%

int main() {

    /* Open the file */
    yyin = fopen("C++/t4.cpp", "r");
    if (yyin == NULL) {
        printf("Failed to open file\n");
        return 1;
    }

    /* Scan the file */
    yylex();

    int totalLoops = forLoopCount + whileLoopCount + doWhileLoopCount;
    int nestedLoops = nestedForLoopCount + nestedWhileLoopCount + nestedDoWhileLoopCount;

    printf("\n -- Summary -- \n");
    printf("Total number of lines: %d\n", noOfLines);
    printf("Total number of loops: %d\n", totalLoops);
    printf("Total number of nested loops: %d\n", nestedLoops);
    printf("\n -- Breakdown of loops -- \n");
    printf("Number of for loops: %d\n", forLoopCount);
    printf("Number of nested for loops: %d\n", nestedForLoopCount);
    printf("Number of while loops: %d\n", whileLoopCount);
    printf("Number of nested while loops: %d\n", nestedWhileLoopCount);
    printf("Number of do-while loops: %d\n", doWhileLoopCount);
    printf("Number of nested do-while loops: %d\n", nestedDoWhileLoopCount);

    fclose(yyin); // Close the file
        
    return 0;
}

int yywrap() {
    return 1;
}
