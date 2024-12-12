#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {

    printf("hello");

    goto fail;
    goto fail;

    printf("hello");
fail:
    printf("hello");
    printf("hello");

    exit(0);
}
