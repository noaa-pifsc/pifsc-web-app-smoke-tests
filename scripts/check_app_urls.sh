#!/bin/bash

# change to the directory the script is running in
cd "$(dirname "$(realpath "$0")")"

# include functions
source ./functions/smoke_test_functions.sh

create_logfile "check_app_urls"

CSV_FILE="./app_list/app_list.csv"

# define the csv delimiter
DELIMITER=","


echo "*************************************************************************"
echo "********* Executing Smoke Tests for the Specified Applications  *********"
echo "*************************************************************************"
echo "*Note: This script will check each of the URLs in the $CSV_FILE and use CURL to check the HTTP return codes to determine if each application is available"

echo "The results of the script will be available onscreen as well as in \"$LOGFILE\""
echo ""

if [[ ! -f "$CSV_FILE" ]]; then
    echo "Error: CSV file not found at '$CSV_FILE'."
    echo "Please ensure the file exists and the path is correct."
    exit 1 # Exit the script with an error code
fi

echo "CSV file '$CSV_FILE' found. Proceeding with processing."
echo ""

# Read the CSV file line by line (skip the header row)
tail -n +2 "$CSV_FILE" | while IFS="$DELIMITER" read -r app_name app_url; do
	echo "app_name: $app_name"
	echo "app_url: $app_url"


	# --- Validation Checks ---
    VALID_ROW=true # Assume row is valid until a blank is found

    if [[ -z "$app_name" ]]; then
        echo "Error: Application Name is blank for this row."
        VALID_ROW=false
    fi

    if [[ -z "$app_url" ]]; then
        echo "Error: URL is blank for this row."
        VALID_ROW=false
    fi

    # --- Process row based on validation ---
    if $VALID_ROW; then
        echo "Validated Application Name: $app_name"
        echo "Validated URL: $app_url"

		echo "run the curl_check_url() function"
		echo "app_name: $app_name"
		echo "app_url: $app_url"

		curl_check_url "$app_name" "$app_url"

    else
        echo "Skipping row due to blank values: $app_name,$app_url"
    fi
 
 echo "-----------------------------------"

done


read -p "The script has finished executing, press Enter to exit"