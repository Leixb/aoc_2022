#!/usr/bin/env python3

count = 0

while True:
    try:
        range_pair = input()
    except EOFError:
        break

    range_a, range_b = range_pair.split(',')
    fa, sa = range_a.split('-')
    fb, sb = range_b.split('-')

    fa, sa, fb, sb = int(fa), int(sa), int(fb), int(sb)

    if (fa >= fb and sa <= sb) or (fa <= fb and sa >= sb):
        count += 1

print(count)
