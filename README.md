# Cups/paperless-printer Docker Container

This docker file will create a virtual printer in cupsd that will output to `/mnt/output`. This will allow printing
from a network postcript printer that will output a pdf to a volume or mount. You can change the output path in `cups-pdf.conf`

One possible use of this is in conjunection with a [paperless-ngx](https://github.com/paperless-ngx/paperless-ngx) consume directory
to read pdf's.

## Install

See `docker-compose.yml` for example. Names and targets can be parameterized via variables

The http/print server will listen on port `631`. The default username/password is print/print, and can be changed in the `Dockerfile`

## Avahi (Optional, but recommended)

In order to make the printer discoverable, avahi needs to be set up.  For it to work correctly on the network, it should share the network space
with its own IP.  There are two ways to do this: either by using the `host` network, or by assigning it a static IP in non-dhcp space via `macvlan`.

If you plan on running more than 1 instance/printer, you'll need to use `macvlan`

### Host Network

Uncomment `network_mode: host` in the `docker-compose.yml` file and comment out the `network` section.

### Macvlan

Docker-compose setup, for example in `192.168.0.0/24` space.

```yaml
network:
  vlan:
    driver: macvlan
    driver_opts:
      parent: eth0 #Update as necessary
    ipam:
      config:
        - subnet: "192.168.0.0/24"
          ip_range: "192.168.0.200/32"
          gateway: "192.168.0.1"
```
