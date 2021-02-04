# kafka-rest-proxy-demo

This repository is meant to be a quick demo of how to set up a local kafka rest proxy.
It contains docker-compose file, which runs a multi-replica distributed kafka and a connected
rest-proxy.

The example is meant to be run on a Linux machine, but even on Windows this **should** run.

## Kafka Rest Proxy

This is a pre-built HTTP-Server that exposes Kafka. The API is very coupled to the regular
Kafka Consumer API.

An overview and documentation can be found here:
<https://docs.confluent.io/platform/current/kafka-rest/quickstart.html>

## Setup

Run `make start` to start the kafka cluster and the rest proxy

Run `make consume-setup` to register the consumers via the rest-proxy

Run `make consume-run` to actually consume messages via the rest-proxy

## Producing messages

run `make produce-messages` to produce some messages

Explore the script itself to run variations.
The producer script is `produce_messages_via_cli.sh` and uses the kafka cli to produce messages.
One can also use other libraries (e.g. Python) to produce messages or even the rest proxy.

## Example commands

```sh
# create consumer group
curl -u user:pass -X POST http://localhost:8082/consumers/group-readings \
     -H "Content-Type: application/vnd.kafka.v2+json" \
     --data '{"name": "readings", "format": "json", "auto.offset.reset": "earliest", "auto.commit.enable": "true"}'

# subscribe consumer (normal rest proxy)
curl -X POST http://localhost:8080/consumers/group-readings/instances/readings/subscription \
     -H "Content-Type: application/vnd.kafka.v2+json" \
     --data '{"topics":["test.telemetry.readings"]}'

# proxied (topic restricted subscribe)
curl -u user:pass -X POST http://localhost:8082/consumers/group-readings/instances/readings/subscription \
     -H "Content-Type: application/vnd.kafka.v2+json"

# get records
curl -u user:pass -X GET http://localhost:8082/consumers/group-readings/instances/readings/records \
  -H "Accept: application/vnd.kafka.json.v2+json"

# get subscription
curl -u user:pass -X GET http://localhost:8082/consumers/group-readings/instances/readings/subscription \
  -H "Content-Type: application/vnd.kafka.json.v2+json"

# get offsets
curl -u user:pass -X GET http://localhost:8082/consumers/group-readings/instances/readings/offsets \
  -H "Content-Type: application/vnd.kafka.json.v2+json" \
  --data '{"partitions": [{"topic": "test.telemetry.readings", "partition": 0}, {"topic": "test.telemetry.readings", "partition": 1}]}'

# set position
curl -u user:pass -X POST http://localhost:8082/consumers/group-readings/instances/readings/positions \
  -H "Content-Type: application/vnd.kafka.json.v2+json" \
  --data '{ "offsets": [ { "topic": "test.telemetry.alarms", "partition": 0, "offset": 0 } ] }'
```
