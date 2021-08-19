FROM m1mbert/cxlb-gnuradio-3.8:1.1
ENV APT="apt-get -y"
RUN ${APT} update && ${APT} dist-upgrade
WORKDIR /root
RUN ${APT} install iperf
COPY *.sh /root/
COPY *.grc /root/
COPY *.py /root/
