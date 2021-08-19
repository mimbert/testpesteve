reproduce CorteXlab GNURadio docker task execution concurrency issues
=====================================================================

description
-----------

the shell scripts are to be run in the containers on the node and will
start a "server" in background, then a "client", and perform network
transfer between them

there are four tests:

- iperf (network testing tool) in TCP mode
  
- iperf (network testing tool) in UDP mode
  
- GNURadio UDP in run-to-completion mode
  
- GNURadio UDP in prompt-for-exit mode
  
The GNURadio client/server are two very simple designs:

- server listening with an UDP source block

- client sending with an UDP sink block

Both design output the data stream to a file with a .out extension,
and to stdout.

Some start / stop logs are manually added to the generated .py files

The CorteXlab task scenario is in folder task

Results
-------

Nodes 3 and 4: the iperf tests work perfectly

Nodes 7 and 8: different behavior between "run to completion" or
"prompt for exit" modes:

- node7: client/server in run-to-completion mode: the logs show that
  the client and server both run and exit correctly, and both server
  and client .out files are generated and are of the correct size

- node8: client/server in prompt-for-exit mode: the logs show that
  client and server both run correctly, but both client and server
  .out files are empty

Before adding a throttle block to all flowgraphs, there were issues in
run-to-completion mode: the logs showed that the client and server
both run and exit correctly, but the server output file contained no
data. The explanation (thanks Léo) is that without the throttle block,
and when the threshold of the [head] block is lower than the buffer
size, the [head] block can trigger the stop of the flowgraph *before*
[file sink] sees any data.
