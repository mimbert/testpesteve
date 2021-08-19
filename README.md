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

Nodes 7 and 8: there are issues with the GNURadio client/servers:

- node7: client/server in run-to-completion mode: the logs show that
  the client and server both run and exit correctly, but the server
  output file or stdout contain no data

- node8: client/server in prompt-for-exit mode: the logs show that
  client and server both run correctly, but both client and server
  output files or stdout contain no data

Additionnaly, if run interactively in a container on my workstation:

- run-to-completion version seem to run and exit correctly but both
  client and server output files are empty

- prompt-for-exit version show two "Press Enter to quit:" prompts
  (server and client). If I hit Ctrl-C at the second one (the client
  one), this is the only case where I have the two client and server
  output files as expected (20Kbytes for client, 10Kbytes for server)
