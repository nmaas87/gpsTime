# gpsTime

balena enabled GPS NTP timeserver

## Setup

Get yourself an GPS module that works with this setup, wire it to your RPi and deploy the application with balena.

[![balena deploy button](https://www.balena.io/deploy.svg)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/nmaas87/gpsTime)


## Variables

There are multiple environmental variables in case you need to customize the setup:

* BAUD: sets the baudrate of your GPS module. Default is 9600, however, if you need e.g. 115200, just set BAUD=115200.
* ALLOW: sets the allow variable within the [NTP server of chrony](https://chrony.tuxfamily.org/doc/3.4/chrony.conf.html). Example: "192.168.178.0/24" as ALLOW will allow only hosts from the network of 192.168.178.0/24 to use the NTP server. If you set ALLOW to "" or "all", it will allow all hosts from anywhere.
* OFFSET: sets the [OFFSET value for GPS within chrony](https://chrony.tuxfamily.org/doc/3.4/chrony.conf.html). Default is 0.0 - and an empty ("") or default value ("0.0") will mean that no offset will be applied.

## Which GPS module to use

All 3v3 TTL-LvL GPS modules with PPS output should be working, it was tested with [Watterott's CAM-M8Q-Breakout Multi GNSS Modul (GPS, QZSS, GLONASS, BeiDou, Galileo)](https://shop.watterott.com/CAM-M8Q-Breakout-Multi-GNSS-Modul-GPS-QZSS-GLONASS-BeiDou-Galileo), but should also work with e.g. [Adafruit Ultimate GPS Breakout - 66 channel w/10 Hz updates - Version 3](https://www.adafruit.com/product/746).

## Wiring

* GPS 3v3 -> RPi 3v3 power
* GPS GNS -> RPi Ground
* GPS TX -> RPi GPIO 15 (RXD)
* GPS RX -> RPi GPIO 14 (TXD)
* GPS PPS -> RPi GPIO 18 (PCM_CLK)

![Pinout](docs/GPIO-Pinout-Diagram-2.png)

Pinout taken from official [Raspberry Pi Documentation](https://www.raspberrypi.org/documentation/usage/gpio/). Please bear in mind this wiring schematic is correct for RPi 1A+/B+ and following.

## Thanks

A lot of this is taken from the excellent work of beta-tester's Repo, but also other websites. To give an overview to all these awesome people:

* https://github.com/beta-tester/RPi-GPS-PPS-StratumOne
* https://github.com/patricktokeeffe/rpi-ntp-server
* https://www.tomvoboril.com/2021/06/gps-and-raspberry-pi-stratum-1-server.html
* https://github.com/misterpeee/balena-gps-ntpsecd
