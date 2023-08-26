package main;

import (
    "bufio"
    "fmt"
    "strconv"
    "os"
)

type Top3 [3]int

func (t *Top3) Push(v int) {
    if v > t[0] {
        t[0], t[1], t[2] = v, t[0], t[1]
    } else if v > t[1] {
        t[1], t[2] = v, t[1]
    } else if v > t[2] {
        t[2] = v
    }
}

func (t *Top3) Sum() int {
    return t[0] + t[1] + t[2]
}

func main() {
    scanner := bufio.NewScanner(os.Stdin)

    var input string
    top3 := Top3{0, 0, 0}

    sum := 0

    for scanner.Scan() {
        input = scanner.Text()

        if input == "" {
            top3.Push(sum)
            sum = 0
            continue
        }

        num, err := strconv.Atoi(input)
        if err != nil {
            fmt.Println(err)
            os.Exit(1)
        }

        sum += num
    }

    fmt.Println("Top 3: ", top3)
    fmt.Println(top3.Sum())
}
