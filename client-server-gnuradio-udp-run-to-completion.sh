#!/bin/bash
echo "$(date): source gnuradio environment"
source /cortexlab/toolchains/current/bin/cxlb-toolchain-user-conf
echo "$(date): start gnuradio udp server in run to completion mode"
#./server_run_to_completion.py | tee gnuradio-udp-server-run-to-completion.log &
nohup ./server_run_to_completion.py | tee gnuradio-udp-server-run-to-completion.log &
echo "$(date): wait a bit"
sleep 5
echo "$(date): start gnuradio udp client in run to completion mode"
./client_run_to_completion.py | tee gnuradio-udp-client-run-to-completion.log
echo "$(date): wait a bit"
sleep 5
echo "$(date): ensure server job is killed"
kill %1
echo "$(date): wait a bit"
sleep 5
echo "$(date): sync filesystem"
sync
echo "$(date): end"
