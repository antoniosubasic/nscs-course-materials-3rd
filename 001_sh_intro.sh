#!/bin/sh

a=1

while test $a != 11; do
    echo "$a * $a = $(expr $a \* $a)"
    a=$(expr $a + 1)
done
