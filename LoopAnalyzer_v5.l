%{
#include <stdio.h>
int forLoopCount = 0, whileLoopCount = 0, doWhileLoopCount = 0, noOfLines = 1;
%}


%%
\"[^"]*\" { } // Ignore all strings

    /* 
        This section of the code is used to identify the 'for', 'while' and 'do-while' keywords within the C++ code.

    */

"for"[ \t]*$ {
    printf("Found 'for' keyword on its own on line: %d\n", noOfLines);
}

"for"[ \t]*\([^)]*\) {
    printf("Found 'for' keyword followed by a set of brackets on line: %d\n", noOfLines);
}


"while"[ \t]*$ {
    printf("Found 'while' keyword on its own on line: %d\n", noOfLines);
}

"while"[ \t]*\([^)]*\) {
    printf("Found 'while' keyword followed by a set of brackets on line: %d\n", noOfLines);
}


"do"[ \t]*"while"[ \t]*$ {
    printf("Found 'do while' keyword on its own on line: %d\n", noOfLines);
}

"do"[ \t]*"while"[ \t]*\([^)]*\) {
    printf("Found 'do while' keyword followed by a set of brackets on line: %d\n", noOfLines);
}


    /* 
        This section of the code is used to identify loops and nested loops within the C++ code.
    
     */

for[ \t]*\([^;]*;[^;]*;[^)]*\)[ \t]*\n?[ \t]*\{[^}]*\} {
    printf("Found a 'for' loop on line: %d\n", noOfLines);
    forLoopCount++;
    int i;
    for (i = 0; yytext[i] != '\0'; i++) {
        if (yytext[i] == '\n') {
            noOfLines++;
        }

        if (strncmp(&yytext[i], "for[ \t]*([^;]*;[^;]*;[^)]*)[ \t]*\n?[ \t]*{[^}]*}", 3) == 0 && i > 0) {
            printf("Found a nested 'for' loop within a 'for' loop on line: %d\n", noOfLines);
            forLoopCount++;
        }
    }
}


    /* 
        This section of the code is used to identify loops and nested loops within the C++ code.

     */


while[ \t]*\([^)]*\)[ \t]*\n?[ \t]*\{[^}]*\} {
    printf("Found a 'while' loop on line: %d\n", noOfLines);
    whileLoopCount++;
    int i;
    for (i = 0; yytext[i] != '\0'; i++) {
        if (yytext[i] == '\n') {
            noOfLines++;
        }

        if (strncmp(&yytext[i], "while[ \t]*\([^)]*)[ \t]*\n?[ \t]*\{[^}]*}", 3) == 0 && i > 0) {
            printf("Found a nested 'while' loop within a 'while' loop on line: %d\n", noOfLines);
            whileLoopCount++;
        }
    }
}

    /* 
        This section of the code is used to identify loops and nested loops within the C++ code.

     */

do[ \t]*\n?[ \t]*\{[^}]*\}[ \t]*while[ \t]*\([^;]*\); {
    printf("Found a 'do-while' loop on line: %d\n", noOfLines);
    doWhileLoopCount++;
    int i;
    for (i = 0; yytext[i] != '\0'; i++) {
        if (yytext[i] == '\n') {
            noOfLines++;
        }

        if (strncmp(&yytext[i], "do[ \t]*\n?[ \t]*\{[^}]*}[ \t]*while[ \t]*\([^;]*);", 3) == 0 && i > 0) {
            printf("Found a nested 'while' loop within a 'while' loop on line: %d\n", noOfLines);
            doWhileLoopCount++;
        }

    }
}




\n        { noOfLines++; } // Count number of lines
.         { } // Ignore all other characters
%%

int main() {
    yyin = fopen("C++/t3.cpp", "r");
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