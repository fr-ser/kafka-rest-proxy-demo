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

## Scripts

Explore the scripts themselves to run variations.

- The producer script is `produce_messages_via_cli.sh` and uses the kafka cli to produce messages.
  One can also use other libraries (e.g. Python) to produce messages or even the rest proxy.

- The scripts `setup_rest_consumers.sh` and `consume_via_rest.sh` showcase the rest proxy via
  command line `curl` commands. This can be adapted to use any http library.
