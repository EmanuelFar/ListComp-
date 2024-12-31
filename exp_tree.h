#ifndef TREE_H
#define TREE_H

#include <stdio.h>
#include <stdlib.h>

/* Tree node may contain 3 types */
typedef enum { NUM, VARIABLE, OPERATOR } TokenType;

typedef struct TreeNode {
    TokenType type;  
    union {
        int number;          // For NUM
        char operator;       // For OPERATOR
        /* VARIABLE doesn't store additional data */
    };
    struct TreeNode *left;  
    struct TreeNode *right; 
} TreeNode;

/* Function prototypes */
TreeNode* create_number_node(int value);
TreeNode* create_variable_node();
TreeNode* create_operator_node(char operator, TreeNode* left, TreeNode* right);
void cleanup_tree(TreeNode* root);
int eval(TreeNode* root, int val);

#endif // TREE_H

