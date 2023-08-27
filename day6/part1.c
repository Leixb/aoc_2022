#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFF_SIZE 5000

int main(int argc, char *argv[]) {

    char input[BUFF_SIZE];
    int *dist = calloc(BUFF_SIZE, sizeof(int));

    scanf("%s", input);

    int i, ok;
    for (i = 0; i < strlen(input); ++i) {
        ok = 1;
        for (int j = 4; j >= 1; --j) {
            if (i - j < 0) continue;
            if (input[i] == input[i - j]) {
                dist[i] = j;
                ok = 0;
            }
            if (dist[i-j] && dist[i - j] + j < 4) {
                ok = 0;
            }
        }
        if (ok && i>=4) break;
    }

    printf("%d\n", i+1);

    return EXIT_SUCCESS;
}
