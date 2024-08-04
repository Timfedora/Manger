#!/bin/bash


echo "This is the finder script from Manger"

read -p "Enter the name you want to search for: " search_name

# Perform the search and store the results in a variable
results=$(find / -type f -name "$search_name" 2>/dev/null)

# Check if any results were found
if [ -z "$results" ]; then
    echo "No files found matching '$search_name'."
else
    echo "Searching for '$search_name' in files and directories..."
    echo

    # Print each result with a numbered list
    count=1
    for result in $results; do
        echo "$count. $result"
        ((count++))
    done

    echo
    echo "Total files found: $((count - 1))"
fi

