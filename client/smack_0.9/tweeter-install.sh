#! /bin/bash

echo to install tweeter..
curl -X POST --header 'Content-Type: */*' --header 'Accept: application/json' -d @tweeter.json 'http://localhost:10004/v1/appsets/'
curl -X PUT --header 'Content-Type: */*' --header 'Accept: application/json' 'http://localhost:10004/v1/appsets/tweeter/start'
echo tweeter already installed.
