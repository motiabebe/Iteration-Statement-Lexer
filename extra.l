
%%
while[ \t]*\(*[^;{}]*\)*[ \t]*$ {printf("Found token 'while' on line: %d\n", noOfLines);}

for[ \t]*\([^)]*\)[ \t]*$ {printf("Found token 'for' on line: %d\n", noOfLines);}

for[ \t]* { printf( "Found token 'for' on line: %d\n", noOfLines); }

do[ \t]*\{[^}]*\}[ \t]*$ { printf( "Found token 'do' on line %d\n", noOfLines ); }

do[ \t]* { printf( "Found token 'do' on line: %d\n", noOfLines ); }

%%