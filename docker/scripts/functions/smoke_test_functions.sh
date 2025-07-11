#!/bin/bash

# function to check a URL and output a message to the user based on the HTTP code
function curl_check_url ()
{
	# store the function parameters as local bash variables
	local APP_NAME="$1"
	local URL="$2"

	echo "Checking \"$app_name\" ($app_url)"

	# Combine options set curl options (discard html content, capture http_code, ignore certificate warnings, follow redirects)  
	local CURL_OPTIONS="-s -o /dev/null -w %{http_code} -k -L"

	# Execute curl and capture stdout (just the http_code due to -w flag) into HTTP_STATUS
	local HTTP_STATUS=$(curl ${CURL_OPTIONS} "$URL")

#	echo "The value of HTTP_STATUS is: $HTTP_STATUS"

	# print out a message to the user based on the HTTP status code
	if [ "$HTTP_STATUS" -eq 200 ]; then
		echo "PASS: Application Request Successful (HTTP 200) for \"$APP_NAME\" ($URL)"
	elif [ "$HTTP_STATUS" -eq 302 ]; then
		echo "PASS: Application Up and Redirecting, likely due to APEX login redirection (HTTP 302) for \"$APP_NAME\" ($URL)"
	elif [ "$HTTP_STATUS" -ge 400 ]; then
		echo "FAIL: Request failed with client or server error (HTTP $HTTP_STATUS) for \"$APP_NAME\" ($URL)."
	else
		echo "FAIL: Unexpected HTTP status code: $HTTP_STATUS for \"$APP_NAME\" ($URL)"
	fi
}


# function that creates a logfile and populates it with all output from the script
# this function accepts one parameter, the logfile prefix
# Usage:
#   create_logfile "$1"
function create_logfile ()
{
	# store the log file prefix in a local variable
	local passed_logfile_prefix="$1"

	# create the logfile with a date/time suffix
	LOGFILE="./logs/$passed_logfile_prefix.$(date +%Y%m%d_%H%M%S).log"
	exec > >(tee -a "$LOGFILE") 2>&1
}