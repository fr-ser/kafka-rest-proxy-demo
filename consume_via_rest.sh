#!/usr/bin/env bash

echo 'Consume data for "consumer-readings"'
curl -X GET --silent \
     -H "Accept: application/vnd.kafka.json.v2+json" \
     http://localhost:8082/consumers/group-readings/instances/consumer-readings/records | jq .


echo 'Consume data for "consumer-alarms"'
curl -X GET --silent \
     -H "Accept: application/vnd.kafka.json.v2+json" \
     http://localhost:8082/consumers/group-alarms/instances/consumer-alarms/records | jq .
