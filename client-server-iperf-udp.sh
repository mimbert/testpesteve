#!/bin/bash

iperf -us | tee iperf-udp-server.log &
sleep 5
iperf -uc 127.0.0.1 | tee iperf-udp-client.log
