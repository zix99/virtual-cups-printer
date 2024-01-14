#!/bin/bash
set -ev

cat cups-pdf.conf | envsubst > /etc/cups/cups-pdf.conf
cat cupsd.conf | envsubst > /etc/cups/cupsd.conf
cat printers.conf | envsubst > /etc/cups/printers.conf
cat vprint.service | envsubst > /etc/avahi/services/vprint.service
cp /usr/share/ppd/cups-pdf/CUPS-PDF_noopt.ppd /etc/cups/ppd/${PRINTER_ID}.ppd


/usr/sbin/avahi-daemon --daemonize
exec /usr/sbin/cupsd -f
