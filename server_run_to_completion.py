#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#
# SPDX-License-Identifier: GPL-3.0
#
# GNU Radio Python Flow Graph
# Title: server-run-to-completion
# GNU Radio version: v3.8.3.1-14-g34ea1a45

from gnuradio import blocks
from gnuradio import gr
from gnuradio.filter import firdes
import sys
import signal
from argparse import ArgumentParser
from gnuradio.eng_arg import eng_float, intx
from gnuradio import eng_notation


class server_run_to_completion(gr.top_block):

    def __init__(self):
        gr.top_block.__init__(self, "server-run-to-completion")

        ##################################################
        # Variables
        ##################################################
        self.samp_rate = samp_rate = 32000

        ##################################################
        # Blocks
        ##################################################
        self.blocks_udp_source_0 = blocks.udp_source(gr.sizeof_char*1, '127.0.0.1', 5987, 1472, True)
        self.blocks_head_0 = blocks.head(gr.sizeof_char*1, 10240)
        self.blocks_file_sink_0 = blocks.file_sink(gr.sizeof_char*1, 'server-run-to-completion.out', False)
        self.blocks_file_sink_0.set_unbuffered(True)
        self.blocks_file_descriptor_sink_0 = blocks.file_descriptor_sink(gr.sizeof_char*1, 1)


        ##################################################
        # Connections
        ##################################################
        self.connect((self.blocks_head_0, 0), (self.blocks_file_descriptor_sink_0, 0))
        self.connect((self.blocks_head_0, 0), (self.blocks_file_sink_0, 0))
        self.connect((self.blocks_udp_source_0, 0), (self.blocks_head_0, 0))


    def get_samp_rate(self):
        return self.samp_rate

    def set_samp_rate(self, samp_rate):
        self.samp_rate = samp_rate





def main(top_block_cls=server_run_to_completion, options=None):
    tb = top_block_cls()

    def sig_handler(sig=None, frame=None):
        tb.stop()
        tb.wait()

        sys.exit(0)

    signal.signal(signal.SIGINT, sig_handler)
    signal.signal(signal.SIGTERM, sig_handler)

    tb.start()

    tb.wait()


if __name__ == '__main__':
    import datetime
    print(f"{datetime.datetime.isoformat(datetime.datetime.today())}: server-run-to-completion start")
    main()
    print(f"{datetime.datetime.isoformat(datetime.datetime.today())}: server-run-to-completion end")
