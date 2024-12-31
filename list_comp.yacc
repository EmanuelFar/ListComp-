%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include "exp_tree.h"
#include "int_list.h"

/* Lexer and Error Handling */
int yylex(void);
void yyerror(const char *s);

/* Global Variables */

// Holds the comprehension variable name
char* word = NULL;
bool word_found = false;

/* Function to process comprehension */
struct IntList* process_comprehension(TreeNode* expr_node, struct IntList* input_list);
%}

%union {
    int num;
    char* id;
    struct TreeNode* node;
    struct IntList* list;
}

%start program


%token <num> NUMBER
%token <id> ID
%token PLUS MINUS MUL DIV MOD
%token LPAREN RPAREN LBRACKET RBRACKET COMMA SEMICOLON
%token BADTOKEN
%token FOR IN

%type <node> expr pure_expr
%type <list> list expr_list comprehension

/* Operator Precedence */
%left PLUS MINUS
%left MUL DIV MOD

%%


program
    : /* empty */
    | statement SEMICOLON program 
    ;

statement
    : expr {
        // if expression contains a variable (e.g x;, x+1;)
        if (word_found){
            char prompt[32];
            snprintf(prompt, sizeof(prompt), "Undefined variable '%s'", word);
            yyerror(prompt);
            free(word);
            word = NULL;        // Prevent dangling pointer
            word_found = false; // Update flag
            exit(1);
        } 
        printf("%d\n", eval($1, 0));
        cleanup_tree($1);
      }
    | list 				{ print_list($1); cleanup_list($1); }
    | comprehension 	{ print_list($1); cleanup_list($1); }
    | BADTOKEN 			{ yyerror("error: syntax error"); exit(1); }
    ;

expr
    : pure_expr 		{ $$ = $1; }
    | expr PLUS expr 	{ $$ = create_operator_node('+', $1, $3); }
    | expr MINUS expr 	{ $$ = create_operator_node('-', $1, $3); }
    | expr MUL expr 	{ $$ = create_operator_node('*', $1, $3); }
    | expr DIV expr { 
        int right_val = eval($3, 0); // Evaluate right-hand side
        if (right_val == 0) {
            yyerror("Division by zero");
            exit(1);
        }
        $$ = create_operator_node('/', $1, $3); 
      }
    | expr MOD expr { 
        int right_val = eval($3, 0); // Evaluate right-hand side
        if (right_val == 0) {
            yyerror("Division by zero");
            exit(1);
        }
        $$ = create_operator_node('%', $1, $3); 
      }
    ;

pure_expr
    : ID { 
        if (word_found) {
            // In case multiple variables are found (e.g., x for y in [])
            if (strcmp(word, $1) != 0) {
               char prompt[32];
               snprintf(prompt, sizeof(prompt), "Undefined variable '%s'", $1);
               free(word);
               word = NULL;        // Prevent dangling pointer
               word_found = false; // Update flag
               yyerror(prompt);
               exit(1);
            } else {
                $$ = create_variable_node();
            }
        } else {
            word = strdup($1);
            if (!word) {
                fprintf(stderr, "Memory allocation failed for variable name.\n");
                exit(1);
            }
            word_found = true;
            $$ = create_variable_node();
        }
        free($1); // Free the duplicated string from lexer
      }
    | NUMBER { $$ = create_number_node($1); }
    | LPAREN expr RPAREN { $$ = $2; }
    ;

list
    : LBRACKET expr_list RBRACKET { 
        $$ = $2; 
      }
    ;

expr_list
    : /* empty list */ { 
        $$ = init_list(); 
      }
    | expr { 
        $$ = init_list(); 
        int val = eval($1, 0); 
        append_list($$, val); 
        cleanup_tree($1); 
      }
    | expr_list COMMA expr { 
        int val = eval($3, 0); 
        append_list($1, val); 
        cleanup_tree($3); 
        $$ = $1; 
      }
    ;

comprehension
    : expr FOR ID IN list {
        // expression can be a variable or a pure integer
        if ((word == NULL && $1->type == NUM) || strcmp(word, $3) == 0){
            $$ = process_comprehension($1, $5); 
            
        } else {
            char prompt[32];
            snprintf(prompt, sizeof(prompt), "Undefined variable '%s'", $3);
            yyerror(prompt);
            cleanup_tree($1);
            free($3); // Free the duplicated string from lexer
            if (word) {
                free(word);
                word = NULL;        
                word_found = false; 
            }
            exit(1);
        }
        cleanup_tree($1); 
        free($3); // Free the duplicated string from lexer
        if (word) {
            free(word);
            word = NULL;        
            word_found = false;
        }
      }
    ;

%%

/* C Code Implementations */
     
/* Process comprehension function */
struct IntList* process_comprehension(TreeNode* expr_node, struct IntList* input_list) {
    IntList* result = init_list(); // Initialize a new IntList
    for (size_t i = 0; i < input_list->size; i++) {
        int val = eval(expr_node, input_list->data[i]); 
        append_list(result, val); 
    }
    return result; 
}

/* Error handling function */
void yyerror(const char *s) {
    fprintf(stderr,  "%s\n", s);
}

int main(void) {
    int parse_result = yyparse();
    if (word) {
        free(word);
    }
    return parse_result;                
}
