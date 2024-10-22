#!/bin/sh

if test $# != 2; then
    echo "2 Parameter erfolderlich"
    exit 1
fi

echo "Starte $2 um $1"

while true; do
    zeit=$(date | cut -c12-16)
    if test $zeit = $1; then
        break
    fi
    echo $zeit
    sleep 1
done

$2