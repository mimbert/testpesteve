#!/bin/bash

iperf -s | tee iperf-tcp-server.log &
sleep 5
iperf -c 127.0.0.1 | tee iperf-tcp-client.log
