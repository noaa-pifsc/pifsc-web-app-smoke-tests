#!/bin/bash

# function to check a URL and output a message to the user based on the HTTP code
function curl_check_url ()
{
	param_app_name="$1"
	param_app_url="$2"

	echo "running curl_check_url ($param_app_name, $param_app_url)"

	# send the curl request for $param_app_url and store the HTTP code in the HTTP_CODE variable
	HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$param_app_url")

	echo "HTTP Status Code for $URL: $HTTP_CODE"

	# You can then use conditional logic based on the status code
	if [ "$HTTP_CODE" -eq 200 ]; then
		echo "$param_app_name ($param_app_url): Request successful (HTTP 200 OK)."
	elif [ "$HTTP_CODE" -ge 400 ]; then
		echo "$param_app_name ($param_app_url): Request failed with client or server error (HTTP $HTTP_CODE)."
	else
		echo "$param_app_name ($param_app_url): Unexpected HTTP status code: $HTTP_CODE."
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