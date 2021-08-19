#!/bin/bash
echo "$(date): source gnuradio environment"
source /cortexlab/toolchains/current/bin/cxlb-toolchain-user-conf
echo "$(date): start gnuradio udp server in prompt for exit mode"
#./server_prompt_for_exit.py | tee gnuradio-udp-server-prompt-for-exit.log &
nohup ./server_prompt_for_exit.py > gnuradio-udp-server-prompt-for-exit.log &
echo "$(date): wait a bit"
sleep 5
echo "$(date): start gnuradio udp client in prompt for exit mode"
./client_prompt_for_exit.py | tee gnuradio-udp-client-prompt-for-exit.log
echo "$(date): wait a bit"
sleep 5
echo "$(date): ensure server job is killed"
kill %1
echo "$(date): wait a bit"
sleep 5
echo "$(date): sync filesystem"
sync
echo "$(date): end"
