%{
#include "y.tab.h"   
%}

%x CMT

%%

"for"       { return FOR; }
"in"        { return IN; }

[0-9]+      { yylval.num = atoi(yytext); return NUMBER; }

[a-zA-Z_][a-zA-Z0-9_]*  { yylval.id = strdup(yytext); return ID; }

"#"			{ BEGIN(CMT); }
<CMT>[\n\r] { BEGIN(INITIAL); }
<CMT>.      ;

"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MUL; }
"/"         { return DIV; }
"%"         { return MOD; }

"("         { return LPAREN; }
")"         { return RPAREN; }
"["         { return LBRACKET; }
"]"         { return RBRACKET; }
","         { return COMMA; }
";"         { return SEMICOLON; }

[ \t\n\r]  ; 

.           { return BADTOKEN; }

%%

int yywrap() {
    return 1;
}

