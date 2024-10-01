#!/bin/sh

a=1

while test $a != 11; do
    b=1
    
    while test $b != 11; do
        echo "$a * $b = $(expr $a \* $b)"
        b=$(expr $b + 1)
    done

    a=$(expr $a + 1)
done
