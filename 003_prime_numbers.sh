#!/bin/sh

a=2

while test $a != 50; do
    b=2
    is_prime=1
    
    while test $b -lt $a; do
        if test $(expr $a % $b) = 0; then
            is_prime=0
            break
        fi

        b=$(expr $b + 1)
    done

    if test $is_prime = 1; then
        echo $a
    fi

    a=$(expr $a + 1)
done
