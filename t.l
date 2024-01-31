%{
#include <stdio.h>

int line_counter = 1;
int for_loop_counter = 0;
int inside_for_loop = 0;
%}

%%
for[ \t]*\([^;]*;[^;]*;[^)]*\)[ \t]*[ \n]+\{[^}]*\} {
    printf("Found a 'for' loop with brackets on the next line on line: %d\n", line_counter);
    inside_for_loop = 1;
    for_loop_counter = 0;
}

. {
    if (inside_for_loop) {
        if (yytext[0] == '\n') {
            for_loop_counter++;
        }
    }
}

\n {
    line_counter++;
    if (inside_for_loop) {
        printf("Inside 'for' loop, Line: %d\n", line_counter);
    }
}

\n        { line_counter++; } // Count lines
.         { } // Ignore all other characters

%%

int main() {

    yyin = fopen("c++/t3.cpp", "r");
    if (yyin == NULL) {
        printf("Failed to open file\n");
        return 1;
    }

    yylex();

    printf("Total lines: %d\n", line_counter);
    printf("Total lines inside 'for' loop: %d\n", for_loop_counter);
    return 0;
}
