clear
lex LoopAnalyzer_v5.l
gcc lex.yy.c
# if os is windows
if [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
  ./a.exe
else
  ./a.out
fi
