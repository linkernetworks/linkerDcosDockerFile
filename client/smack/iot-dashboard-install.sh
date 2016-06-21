#! /bin/bash

influxdbip=`dcos node|grep -v "HOSTNAME"|head -1|awk '{print $1}'`
grafanaip=`dcos node|grep -v "HOSTNAME"|tail -1|awk '{print $1}'`


echo influxdbip=$influxdbip
echo grafanaip=$grafanaip
rm -f iot-dashboard.json
cp iot-dashboard_template.json iot-dashboard.json
sed -i s/influxdbip/$influxdbip/ iot-dashboard.json
sed -i s/grafanaip/$grafanaip/ iot-dashboard.json

echo to install iot-dashboard..
curl -X POST --header 'Content-Type: */*' --header 'Accept: application/json' -d @iot-dashboard.json 'http://localhost:10004/v1/appsets/'
curl -X PUT --header 'Content-Type: */*' --header 'Accept: application/json' 'http://localhost:10004/v1/appsets/iot-dashboard/start'
echo iot-dashboard already installed.
