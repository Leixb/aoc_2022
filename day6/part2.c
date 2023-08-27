#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFF_SIZE 5000
#define DEFAULT_DIST_SIZE 14

int main(int argc, char *argv[]) {
    int DIST_SIZE = argc > 1 ? atoi(argv[1]) : DEFAULT_DIST_SIZE;

    char input[BUFF_SIZE];
    int *dist = calloc(BUFF_SIZE, sizeof(int));

    scanf("%s", input);

    int i, ok;
    for (i = 0; i < strlen(input); ++i) {
        ok = 1;
        for (int j = DIST_SIZE; j >= 1; --j) {
            if (i - j < 0) continue;
            if (input[i] == input[i - j]) {
                dist[i] = j;
                ok = 0;
            }
            if (dist[i-j] && dist[i - j] + j < DIST_SIZE) {
                ok = 0;
            }
        }
        if (ok && i>=DIST_SIZE) break;
    }

    printf("%d\n", i+1);

    return EXIT_SUCCESS;
}
