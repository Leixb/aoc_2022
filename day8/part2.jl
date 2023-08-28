#!/usr/bin/env julia

function get_by_dir(i, j, di, dj, n, data)
    [data[i + k*di][j + k*dj] for k in 1:n if i + k*di <= n && j + k*dj <= n && i + k*di >= 1 && j + k*dj >= 1]
end

gen_up(i, j, n, data) = get_by_dir(i, j, -1, 0, n, data)
gen_down(i, j, n, data) = get_by_dir(i, j, 1, 0, n, data)
gen_left(i, j, n, data) = get_by_dir(i, j, 0, -1, n, data)
gen_right(i, j, n, data) = get_by_dir(i, j, 0, 1, n, data)

all_gen(i, j, n, data) = map([gen_up, gen_down, gen_left, gen_right]) do gen
    gen(i, j, n, data)
end

function score_tree(i, j, n, data)
    total = 1
    house = data[i][j]
    for trees in all_gen(i, j, n, data)
        score = 0
        for tree in trees
            score += 1
            if tree >= house
                break
            end
        end
        total *= score
    end

    total
end

data = map(readlines()) do line
    map(x -> parse(Int, x), line |> collect)
end

n = length(data)

mx = 0
for i in 1:n, j in 1:n
    global mx = max(mx, score_tree(i, j, n, data))
end

println(mx)
