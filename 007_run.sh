# Antonio Subašić
# Programm funktioniert für C und Java Programme

#!/bin/sh

if test -z "$1"; then
    echo "nutzung: $0 <datei>"
    exit 1
elif ! test -f "$1"; then
    echo "$1 existiert nicht"
    exit 1
fi

endung=$(cut -d. -f2 <<< "$(basename "$1")")
ausgabe_pfad="/tmp/$(id -un)"

case "$endung" in
    c)
        programm="$ausgabe_pfad/$(basename "$1" .$endung)"
        compile="cc -Wall $1 -o $programm"
        run="$programm"
        ;;
    java)
        compile="javac -d $ausgabe_pfad $1"
        programm="$ausgabe_pfad/$(basename "$1" .$endung).class"
        run="java -cp $ausgabe_pfad $(basename "$1" .$endung)"
        ;;
    *)
        echo ".$endung dateien werden nicht unterstützt"
        exit 1
        ;;
esac

if ! test -f "$programm" || test "$programm" -ot "$1"; then
    echo "-> Kompiliere..."
    mkdir -p "$(dirname "$programm")"
    if ! $compile; then
        echo "Fehler beim Kompilieren"
        exit 1
    fi
fi

$run