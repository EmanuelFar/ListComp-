#include "int_list.h"

/* initialize a list with a default size */
IntList* init_list() {
    IntList* list = (IntList*)malloc(sizeof(IntList));
    if (!list){
        fprintf(stderr, "Malloc failed");
        exit(1);
    }
    list->size = 0;
    list->capacity = DEFAULT_SIZE;

    list->data = (int *)malloc(list->capacity * sizeof(int));
    if (!list->data) {
        free(list);
        fprintf(stderr, "Malloc failed");
        exit(1);
    }
    return list;
}

void resize_list(IntList *list) {
    list->capacity *= 2;  // Double the capacity
    list->data = (int *)realloc(list->data, list->capacity * sizeof(int));
    if (!list->data) {
        fprintf(stderr, "Malloc failed");
        exit(1);
    }
}

void append_list(IntList *list, int value) {
    if (list->size == list->capacity) {
        resize_list(list);  // Resize if capacity is exceeded
    }
    list->data[list->size] = value;
    list->size++;
}

void replace_list(IntList* list, int index, int value){
  if (index < 0 || index >= list->size){
    return;
  }
  list->data[index] = value;
}

void cleanup_list(IntList *list) {
    free(list->data);
    list->data = NULL;
    list->size = 0;
    list->capacity = 0;
    free(list);
}

void print_list(IntList *list) {
    printf("[");
    for (size_t i = 0; i < list->size; i++) {
        printf("%d", list->data[i]);
        if (i < list->size - 1){
            printf(",");
        }
    }
    printf("]\n");
}

