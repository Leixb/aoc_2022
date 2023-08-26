#include <iostream>
#include <bitset>


int main(int argc, char *argv[]) {

    auto list = std::bitset<52>();

    int sum = 0, idx = 0;

    for (std::string rutsack; std::cin >> rutsack; ) {
        size_t i;
        for (i = 0; i < rutsack.size()/2; ++i) {
            if (rutsack[i] >= 'a') {
                idx = rutsack[i] - 'a';
            } else {
                idx = rutsack[i] - 'A' + 26;
            }
            list.set(idx);
        }

        for (; i < rutsack.size(); ++i) {
            if (rutsack[i] >= 'a') {
                idx = rutsack[i] - 'a';
            } else {
                idx = rutsack[i] - 'A' + 26;
            }

            if (list[idx]) {
                sum += idx + 1;
                break;
            }
        }

        list.reset();
    }

    std::cout << sum << std::endl;

    return EXIT_SUCCESS;
}
