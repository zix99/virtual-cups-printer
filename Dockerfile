FROM debian:bullseye-slim
ARG USERNAME=print PASSWORD=print
ENV \
    PRINTER_ID=Paperless_Printer \
    PRINTER_NAME=Paperless\ Printer \
    HOSTNAME=127.0.0.1 \
    OUTPUT_SUBPATH=vprint \
    OUTPUT_USERNAME=$USERNAME

# Dependenicies
RUN apt-get update
RUN apt-get install -y --no-install-recommends cups printer-driver-cups-pdf gettext

# Cups config/setup
RUN useradd -G lp,lpadmin -s /bin/bash -p "$(openssl passwd -1 $PASSWORD)" $USERNAME

# discoverability
RUN apt-get install -y avahi-daemon
RUN sed -i 's/.*enable\-dbus=.*/enable\-dbus\=no/' /etc/avahi/avahi-daemon.conf

# Copy configs
WORKDIR /opt/vp
COPY . .

CMD ["./entrypoint.sh"]
