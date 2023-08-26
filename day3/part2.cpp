#include <iostream>
#include <bitset>


int idx(char c) {
    if (c >= 'a') {
        return c - 'a';
    }

    return c - 'A' + 26;
}

int main(int argc, char *argv[]) {

    auto set_first = std::bitset<52>(), set_second = std::bitset<52>();

    int sum = 0;

    for (std::string first, second, third; std::cin >> first >> second >> third;) {
        for (const auto c : first) set_first.set(idx(c));
        for (const auto c : second) set_second.set(idx(c));

        set_first &= set_second;

        for (const auto c : third) {
            if (set_first.test(idx(c))) {
                sum += idx(c) + 1;
                break;
            }
        }

        set_first.reset();
        set_second.reset();
    }

    std::cout << sum << std::endl;

    return EXIT_SUCCESS;
}
