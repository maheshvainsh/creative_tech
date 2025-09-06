#!/bin/bash
# =====================================================
# Script to add header to all .sv and .svh files in a project
# Author: Rutvik Makwana
# =====================================================

# ------------------------------
# Set the project folder path
# ------------------------------
PROJECT_DIR="/home/rutvik/Protocol/PCIe/creative_tech/pcie"   # Change this to your project folder

# ------------------------------
# Set PROJECT name from argument
# ------------------------------
if [ -z "$1" ]; then
    echo "Usage: $0 <PROJECT_NAME>"
    exit 1
fi

PROJECT_NAME="$1"  # e.g., DEMO_VIP

# Check if folder exists
if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: Project directory $PROJECT_DIR does not exist!"
    exit 1
fi

# Loop through all .sv and .svh files recursively
find "$PROJECT_DIR" -type f \( -name "*.sv" -o -name "*.svh" \) | while read f; do
    # Skip file if it already contains "Project"
    if grep -q "Project" "$f"; then
        echo "Skipping $f (header already exists)"
        continue
    fi

    # Get current date
    DATE=$(date +%Y-%m-%d)

    # Get file name and unit name (file name without extension)
    FILENAME=$(basename "$f")        # e.g., counter_transaction.sv
    UNITNAME="${FILENAME%.*}"        # e.g., counter_transaction

    # Create header content
    HEADER="//----------------------------------------------------------------------\n"
    HEADER+="// Project       : $PROJECT_NAME\n" 
    HEADER+="// File          : $FILENAME\n"
    HEADER+="//----------------------------------------------------------------------\n"
    HEADER+="// Created by    : MAHESH VANISH\n"
    HEADER+="//               : RUTVIK MAKWANA\n"
    HEADER+="// Creation Date : $DATE\n"
    HEADER+="//----------------------------------------------------------------------\n"
    HEADER+="// Description   : \n"
    HEADER+="//                 \n"
    HEADER+="//----------------------------------------------------------------------"

    # Insert header at the top of file
    TEMP_FILE=$(mktemp)
    echo -e "$HEADER" > "$TEMP_FILE"
    cat "$f" >> "$TEMP_FILE"
    mv "$TEMP_FILE" "$f"

    echo "Header added to $f"
done

