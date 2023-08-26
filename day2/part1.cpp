#include <iostream>
using namespace std;

const char WIN_SCORE = 6, DRAW_SCORE = 3;

int main(int argc, char *argv[]) {
    int score = 0;

    for (char opponent, me; cin >> opponent >> me; ) {
        // Normalize to 0,1,2 (Rock, Paper, Scissors)
        opponent -= 'A';
        me -= 'X';

        score += me + 1;

        if (me == opponent) {
            score += DRAW_SCORE;
        } else if (me == (opponent + 1) % 3) {
            score += WIN_SCORE;
        }
    }

    cout << score << endl;

    return EXIT_SUCCESS;
}
