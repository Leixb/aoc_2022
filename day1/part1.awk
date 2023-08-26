#!/usr/bin/env awk

BEGIN {
    CURRENT = 0
    RECORD = 0
}

END {
    print RECORD
}

/^$/ {
    if (CURRENT > RECORD) {
        RECORD = CURRENT
    }
    CURRENT = 0
}

{
    CURRENT += $1
}
