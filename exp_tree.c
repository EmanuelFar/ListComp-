/* tree.c */
#include "exp_tree.h"

TreeNode* create_number_node(int value) {
    TreeNode* node = malloc(sizeof(TreeNode));
    if (node == NULL) {
        fprintf(stderr, "Failed Malloc: error\n");
        exit(1);
    }
    node->type = NUM;
    node->number = value;
    node->left = NULL; 
    node->right = NULL;
    return node;
}

TreeNode* create_variable_node() {
    TreeNode* node = malloc(sizeof(TreeNode));
    if (node == NULL) {
        fprintf(stderr, "Failed Malloc: error\n");
        exit(1);
    }
    node->type = VARIABLE;
    node->left = NULL; 
    node->right = NULL;
    return node;
}

TreeNode* create_operator_node(char operator, TreeNode* left, TreeNode* right) {
    TreeNode* node = malloc(sizeof(TreeNode));
    if (node == NULL) {
        fprintf(stderr, "Failed Malloc: error\n");
        exit(1);
    }
    node->type = OPERATOR;
    node->operator = operator;
    node->left = left;
    node->right = right;
    return node;
}

void cleanup_tree(TreeNode* root){
    if (root == NULL){
        return;
    }
    if (root->type == OPERATOR){
        cleanup_tree(root->left);
        cleanup_tree(root->right);
    }
    free(root); 
}

/* Evaluates the expression tree as it replaces VARIABLE with val */
int eval(TreeNode* root, int val){
    if (root->type == VARIABLE){
        return val; 
    }
    if (root->type == NUM){
        return root->number;
    }  
    
    int left_val = eval(root->left, val);
    int right_val = eval(root->right, val);
    
    switch(root->operator){
        case '+': return left_val + right_val;
        case '-': return left_val - right_val;
        case '*': return left_val * right_val;
        case '/': return left_val / right_val;
        case '%': return left_val % right_val; 
        default:
            fprintf(stderr, "Unknown operator: %c\n", root->operator);
            exit(1);
    }
}

