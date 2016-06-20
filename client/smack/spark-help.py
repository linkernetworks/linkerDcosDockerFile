import json
import urllib2

data = urllib2.urlopen("http://master.mesos:8123/v1/services/_spark._tcp.marathon.mesos")
js = data.read()
j = json.loads(js)

if len(j)>1:
  print j[1]["ip"]+":"+j[1]["port"]
else:
  print ':'


