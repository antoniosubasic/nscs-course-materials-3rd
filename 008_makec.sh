#!/bin/sh

outdir="$(pwd)/out"

if test ! -d "$outdir"; then
    echo "- erstelle $outdir..."
    mkdir -p "$outdir"
fi

ofiles=""
linking="nein"

for cfile in *.c; do
    ofile="$outdir/$(basename "$cfile" .c).o"
    ofiles="$ofiles$ofile "

    if test ! -e "$ofile" || test "$cfile" -nt "$ofile"; then
        linking="ja"
        echo "- kompiliere $cfile..."
        cc -Wall -c "$cfile" -o "$ofile" || exit 1
    fi
done

program="$outdir/$(basename $(pwd))"

if test ! -e "$program" || test "$linking" = "ja"; then
    echo "- linke ${ofiles}zu $(basename "$program")"
    cc $ofiles -o "$program"
fi

echo "- starte $(basename "$program")"
"$program"