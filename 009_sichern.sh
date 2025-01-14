#!/bin/sh

if test $# -gt 1; then
    echo "nutzung: $(basename "$0") <ausgabe_verzeichnis>"
    exit 1
fi

out_dir="${1:-backup}"
mkdir -p "$out_dir"

for file in *.sh *.txt; do
    test $file = "*.sh" -o $file = "*.txt" && continue

    time="$(expr "$(date +%s)" - 1735686000)"

    out_file="$out_dir/$file"
    out_file_timestamp="$out_file.$time"
    out_file_diff="$out_file.diff"

    if ! test -e "$out_file" || test "$file" -nt "$out_file"; then
        echo "--> $file"

        if test -e "$out_file"; then
            echo "------ Version $time ------" >> "$out_file_diff"
            diff "$file" "$out_file" >> "$out_file_diff"
            echo >> "$out_file_diff"
        fi

        cp "$file" "$out_file"
        cp "$file" "$out_file_timestamp"
    fi
done
