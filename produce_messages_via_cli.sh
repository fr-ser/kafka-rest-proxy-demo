#!/usr/bin/env bash

echo "This will now produce messages every 2 seconds unless stopped"

# needs to be adjusted whether this script runs inside a docker container or on the host
KAFKA_BROKER=kafka0:29092

COUNTER=0
while true; do
	timestamp=$(date +%s)
	COUNTER=$((COUNTER+1))

    echo "{\"asset_id\": 1, \"measure_point_id\": 1, \"timestamp\": ${timestamp}, \"numeric_val\": ${COUNTER}, \"bool_val\": null, \"text_val\": null}" \
        | kafka-console-producer.sh --broker-list ${KAFKA_BROKER} --topic test.telemetry.readings

    echo "{\"asset_id\": 1, \"measure_point_id\": 2, \"timestamp\": ${timestamp}, \"error\": \"FMI: 8, severity: ${COUNTER}\"}" \
        | kafka-console-producer.sh --broker-list ${KAFKA_BROKER} --topic test.telemetry.alarms

    sleep 2
done