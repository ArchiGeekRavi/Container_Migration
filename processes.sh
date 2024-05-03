#!/bin/bash

# Function to echo numbers in an infinite loop
echo_numbers() {
    i=0
    while true; do
        echo "First program: $i "
        i=$(expr $i + 1)
        sleep 1  # Adjust sleep duration as needed
    done
}

# Function to echo alphabets in increasing order
echo_alphabets() {
    char='a'
    while true; do
        echo "Second program: $char"
        char=$(echo "$char" | tr "[:lower:]" "[:upper:]")  # Convert to uppercase
        char=$(echo "$char" | tr "[:upper:]" "[:lower:]")  # Convert to lowercase
        char=$(echo -e "$char" | tr "a-z" "b-za")  # Shift to next alphabet
        sleep 1  # Adjust sleep duration as needed
    done
}


# Function to echo alphabets in increasing order
echo_Upper_alphabets() {
    char='A'
    while true; do
        echo "Third program: $char"
        char=$(echo "$char" | tr "[:upper:]" "[:lower:]")  # Convert to lowercase
        char=$(echo "$char" | tr "[:lower:]" "[:upper:]")  # Convert to uppercase
        char=$(echo -e "$char" | tr "A-Z" "B-ZA")  # Shift to next alphabet
        sleep 1  # Adjust sleep duration as needed
    done
}


# Function to echo alternating uppercase and lowercase alphabets
echo_alternating_alphabets() {
    char='A'
    while true; do
        echo "Third program: $char"
        if [ "$char" = "A" ]; then
            char='a'
        else
            char='A'
        fi
        sleep 1  # Adjust sleep duration as needed
    done
}

# Function to echo timestamps
echo_timestamps() {
    while true; do
        echo "Fourth program: $(date)"
        sleep 1  # Adjust sleep duration as needed
    done
}

# Function to echo random numbers
echo_random_numbers() {
    while true; do
        echo "Fourth program: $((RANDOM % 100)) "
        sleep 1  # Adjust sleep duration as needed
    done
}

# Start all processes in the background
echo_numbers & echo_alphabets & echo_Upper_alphabets & echo_random_numbers
# Wait for all processes to finish before exiting
#wait

