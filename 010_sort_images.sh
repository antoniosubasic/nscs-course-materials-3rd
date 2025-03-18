#!/bin/sh

image_dir="all_images"
mkdir -p "$image_dir"

while read -r image_link; do
    image_name=$(basename "$image_link")
    image_path="$image_dir/$image_name"

    if test ! -e "$image_path"; then
        curl -s -o "$image_path" "$image_link" || exit 1
        
        year="$(exiftool -s3 -d '%Y' -DateTimeOriginal "$image_path")"
        link_dir="$year"
        mkdir -p "$link_dir"
        ln -s "$(realpath "$image_path")" "$link_dir/$image_name"
    fi
done <<< "$(curl -s https://mb.sb/image_urls.txt)"
