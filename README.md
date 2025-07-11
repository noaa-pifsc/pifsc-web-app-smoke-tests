# PIFSC Web App Smoke Tests

## Overview
This project was developed to provide a simple automated method for verifying that a given set of web applications are available.  The project was developed using bash and curl to execute the web app requests.  There are two options for executing the script: [Standalone](#standalone) and [Docker](#docker).  

## Resources
-   Version Control Information:
    -   URL: git@github.com:noaa-pifsc/pifsc-web-app-smoke-tests.git
    -   Version 1.0 (git tag: web-app-smoke-test-v1.0)

## Version Control Platform
- Git

## Setup
-   Clone this repository into a working directory
-   Create an app_list.csv file in the working directory's [app_list](./docker/scripts/app_list) folder using [app_list.template.csv](./docker/scripts/app_list/app_list.template.csv) file
    -   \*Note: this contains the application information for the applications that will be checked with this script

## Executing the Script
-   ### Standalone
    -   Prerequisites: Linux, bash
    -   Invoke the bash script:
        ```
        bash /path/to/working/dir/docker/scripts/check_app_urls.sh
        ```
    -   The results will print out in the terminal and be saved as a time-stamped file in the [logs](./docker/scripts/logs) folder.  
-   ### Docker
    -   Prerequisites: Docker
    -   Build and run the docker container:
        ```
        docker compose -f docker-compose.yml up -d  --build
        ```
    -   Start a bash session within the container and run the script:
        ```
        docker exec -it smoke_test_app bash
        bash /usr/src/app/check_app_urls.sh
        ```
    -   Stop/Remove the docker container:
        ```
        docker compose down
        ```
    -   The results will print out in the terminal and be saved as a time-stamped file in the /usr/src/app/logs folder within the container.  

## Interpreting Results
-   Each of the applications will be followed by a "PASS" indicating the application is available, or "FAIL" indicating the application is not available or in a non-standard state

## License
See the [LICENSE.md](./LICENSE.md) for details

## Disclaimer
This repository is a scientific product and is not official communication of the National Oceanic and Atmospheric Administration, or the United States Department of Commerce. All NOAA GitHub project code is provided on an ‘as is’ basis and the user assumes responsibility for its use. Any claims against the Department of Commerce or Department of Commerce bureaus stemming from the use of this GitHub project will be governed by all applicable Federal law. Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by the Department of Commerce. The Department of Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used in any manner to imply endorsement of any commercial product or activity by DOC or the United States Government.
