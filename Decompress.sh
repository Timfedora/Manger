#!/bin/bash

# Function to decompress a single file
decompress_file() {
    local file="$1"
    case $file in
        *.zip)
            unzip "$file" -d "${file%.zip}"
            ;;
        *.tar.gz | *.tgz)
            tar -xzf "$file"
            ;;
        *.tar.bz2 | *.tbz2)
            tar -xjf "$file"
            ;;
        *.tar.xz | *.txz)
            tar -xf "$file"
            ;;
        *.xz)
            unxz "$file"
            ;;
        *)
            echo "Unsupported file format: $file"
            ;;
    esac
}

# Function to decompress files in a directory
decompress_files_in_directory() {
    local directory="$1"
    cd "$directory" || { echo "Error: Directory '$directory' does not exist."; exit 1; }

    for file in *.{zip,tar.gz,tar.bz2,tar.xz,xz}; do
        [ -e "$file" ] || continue
        decompress_file "$file"
    done
}

# Main execution
echo "Enter the path to the file or directory containing the files to decompress:"
read -r path

if [ -d "$path" ]; then
    # If the path is a directory, decompress all files in it
    decompress_files_in_directory "$path"
elif [ -f "$path" ]; then
    # If the path is a file, decompress that single file
    decompress_file "$path"
else
    echo "Error: Path '$path' does not exist or is not a valid file/directory."
    exit 1
fi

echo "Decompression complete."
