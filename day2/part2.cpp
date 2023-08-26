#include <iostream>
using namespace std;

const char WIN_SCORE = 6, DRAW_SCORE = 3;

int main(int argc, char *argv[]) {
    int score = 0;

    for (char opponent, outcome; cin >> opponent >> outcome; ) {
        // Normalize to 0,1,2 (Rock, Paper, Scissors)
        opponent -= 'A';

        // Normalize to 0,1,2 (Lose, Draw, Win)
        if (outcome == 'X') { // Lose
            score += (opponent + 2) % 3 + 1;
        } else if (outcome == 'Y') { // Draw
            score += DRAW_SCORE + opponent + 1;
        } else if (outcome == 'Z') { // Win
            score += WIN_SCORE + (opponent + 1) % 3 + 1;
        }
    }

    cout << score << endl;

    return EXIT_SUCCESS;
}
