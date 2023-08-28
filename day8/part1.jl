#!/usr/bin/env julia

function check_tree(i, j, mx, data, records)
    found = data[i][j] >= mx
    if found
        mx = data[i][j]
    end
    if records[i,j] == -1 || records[i,j] >= mx
        records[i,j] = mx
    end

    if found
        return mx + 1
    end

    return mx
end

data = map(readlines()) do line
    map(x -> parse(Int, x), line |> collect)
end

n = length(data)

records = -ones(Int, n, n)
for i in 1:n
    maximums = zeros(Int, 4)
    for j in 1:n
        maximums[1] = check_tree(i, j, maximums[1], data, records)
        maximums[2] = check_tree(i, n - j + 1, maximums[2], data, records)
        maximums[3] = check_tree(j, i, maximums[3], data, records)
        maximums[4] = check_tree(n-j+1, i, maximums[4], data, records)
    end
end

visible = 0
for i in 1:n
    for j in 1:n
        if records[i,j] <= data[i][j]
            global visible += 1
            print(data[i][j])
        else
            print('.')
        end
    end
    print("\n")
end

println(visible)
