
#include <cstdlib>
#include <cstdint>
#include <cstdio>
#include <cassert>

void hello(int aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
           double bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb) {
    //    return 4;
}

int hello2(int aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
                       double bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb) {

    int i;
    int *ptr = &i;

    return *ptr;
}

int deadFunction() {}

int main(int argc, char *argv[]) {
    uint8_t *buf = nullptr;
    char a[10];

    printf("hello");
    int i;
    int *ptr = &i;

    hello(1, 2);
    int aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa;
    double bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb;
    hello(aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
          bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb);

    // if( argc == 1l) {
    buf[2] = 1;
    delete[] buf;

    a[10] = 0;
    goto fail;

    printf("helloo");
    // }

    goto fail;

    printf("hello");
fail:
    printf("hello");
    printf("hello");
    // exit(*ptr);
}
