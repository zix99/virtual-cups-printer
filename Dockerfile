FROM debian:bullseye-slim
RUN apt-get update
RUN apt-get install -y --no-install-recommends cups printer-driver-cups-pdf

# Cups config/setup
# user/pass: print/print
RUN useradd -G lp,lpadmin -s /bin/bash -p '$1$Rou780QF$NSzw1twyIfu2zmZgob4tw0' print
COPY *.conf /etc/cups/
RUN cp /usr/share/ppd/cups-pdf/CUPS-PDF_noopt.ppd /etc/cups/ppd/Paperless_Printer.ppd

# discoverability
RUN apt-get install -y avahi-daemon
RUN sed -i 's/.*enable\-dbus=.*/enable\-dbus\=no/' /etc/avahi/avahi-daemon.conf
COPY vprint.service /etc/avahi/services/

COPY entrypoint.sh /opt/entrypoint.sh
CMD ["/opt/entrypoint.sh"]
