#include <stdlib.h>
#include <stdio.h>
#include "fomalib.h"

int main(int argc, char **argv) 
{
    struct fsm *net = NULL;
    struct apply_handle *ah = NULL;
    char *result = NULL;

    if(argc != 2) {
        fprintf(stderr, "usage: %s input_word\n", argv[0]);
        exit(1);
    }

    net = fsm_read_binary_file("stemmer.fst");
    /* check for error */
    ah = apply_init(net);
    /* check for error */
    result = apply_up(ah, argv[1]);
    while (result != NULL) {
        printf("%s\n", result);
        result = apply_up(ah, NULL);
    }

    return 0;
}
