#!/bin/bash

# Check if required tools are installed
for cmd in nmap msfvenom; do
    if ! command -v $cmd > /dev/null; then
        echo "$cmd could not be found, please install it."
        sudo apt install $cmd
        exit 1
    fi
done

# Function to perform scans
perform_scans() {
    local url=$1

    echo "Starting Nmap scan on $url..."
    nmap -F -sV "$url" > nmap_results.txt

    echo "Nmap scan completed."
}

# Function to search for payloads based on service version
search_payloads() {
    echo "Searching for payloads in msfvenom based on Nmap results..."

    # Create an array to store found payloads
    local payloads=()

    # Extract services and versions from Nmap results
    while read -r line; do
        if [[ $line =~ ([^ ]+) ]]; then
            service=${BASH_REMATCH[1]}
            version=$(echo "$line" | awk '{print $3}')
            echo "Searching payloads for $service version $version..."
            # Get matching payloads from msfvenom
            local found_payloads=$(msfvenom --list payloads | grep "$service" | grep "$version")

            # If found, add to the array and display them
            if [[ ! -z "$found_payloads" ]]; then
                while IFS= read -r payload; do
                    payloads+=("$payload")
                    echo "$payload"
                done <<< "$found_payloads"
            fi
        fi
    done < <(grep "open" nmap_results.txt)

    # Ask user to select a payload if any were found
    if [ ${#payloads[@]} -gt 0 ]; then
        echo "Select a payload by entering the corresponding number:"
        select selected_payload in "${payloads[@]}"; do
            if [[ -n "$selected_payload" ]]; then
                echo "You selected: $selected_payload"
                break
            else
                echo "Invalid selection. Please try again."
            fi
        done
    else
        echo "No relevant payloads found for the detected services."
    fi
}

# Main execution flow
if [ $# -ne 1 ]; then
    echo "Usage: $0 <URL>"
    exit 1
fi

URL=$1

perform_scans "$URL"
search_payloads

echo "Process completed."
