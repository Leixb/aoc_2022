#!/usr/bin/env -S awk -f

/^$/ {
    if (CURRENT > RECORD) {
        RECORD = CURRENT
    }
    CURRENT = 0
}

{ CURRENT += $1 }

END { print RECORD }
