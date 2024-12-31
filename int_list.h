#ifndef INT_LIST_H
#define INT_LIST_H

#include <stdio.h>
#include <stdlib.h>

#define DEFAULT_SIZE 32

typedef struct IntList {
    int *data;    
    size_t size;  
    size_t capacity; 
} IntList;

/* Function prototypes */
IntList* init_list();
void resize_list(IntList *list);
void append_list(IntList *list, int value);
void cleanup_list(IntList *list);
void print_list(IntList *list);

#endif // INT_LIST_H
