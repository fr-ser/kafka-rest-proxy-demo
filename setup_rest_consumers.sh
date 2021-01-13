#!/usr/bin/env bash

# Specify auto.offset.reset to be earliest so it starts at the beginning of the topic.
echo 'Create a consumer "consumer-readings" belonging to consumer group "group-readings"'
curl -X POST --silent \
     -H "Content-Type: application/vnd.kafka.v2+json" \
     --data '{"name": "consumer-readings", "format": "json", "auto.offset.reset": "earliest"}' \
     http://localhost:8082/consumers/group-readings | jq .

echo 'Create a consumer "consumer-alarms" belonging to consumer group "group-alarms"'
curl -X POST --silent \
     -H "Content-Type: application/vnd.kafka.v2+json" \
     --data '{"name": "consumer-alarms", "format": "json", "auto.offset.reset": "earliest"}' \
     http://localhost:8082/consumers/group-alarms | jq .


echo 'Subscribe the "consumer-readings" to topic "test.telemetry.readings"'
curl -X POST --silent \
     -H "Content-Type: application/vnd.kafka.v2+json" \
     --data '{"topics":["test.telemetry.readings"]}' \
     http://localhost:8082/consumers/group-readings/instances/consumer-readings/subscription | jq .

echo 'Subscribe the "consumer-alarms" to topic "test.telemetry.alarms"'
curl -X POST --silent \
     -H "Content-Type: application/vnd.kafka.v2+json" \
     --data '{"topics":["test.telemetry.alarms"]}' \
     http://localhost:8082/consumers/group-alarms/instances/consumer-alarms/subscription | jq .
