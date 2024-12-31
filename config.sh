yacc -d $1.yacc &&\
flex $1.lex &&\
gcc -o parser y.tab.c lex.yy.c int_list.c exp_tree.c -lfl &&\
./parser 
