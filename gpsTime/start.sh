#!/bin/bash

# if the BAUD enVar is set and not empty, set baud rate
if [[ ! -z $BAUD ]] 
  then
    # custom baud rate
    stty -F /dev/ttyAMA0 $BAUD
  else
    # default baud rate
    stty -F /dev/ttyAMA0 9600
fi

# if the ALLOW enVar is set and not empty add the appropriate flag
if [[ ! -z $ALLOW ]] 
  then
    # set allow for local network
    echo $'# certain NTP clients are allowed to access the NTP server.\nallow '$ALLOW > /etc/chrony/stratum1/01-allow.conf
  else
    # set allow for all
    echo $'# any NTP clients are allowed to access the NTP server.\nallow all' > /etc/chrony/stratum1/01-allow.conf
fi

# if the OFFSET enVar is set and not empty, set new offset
if [[ ! -z $OFFSET ]] 
  then
    # custom offset for GPS
    sed -i "s/offset.*$/offset $OFFSET/g" /etc/chrony/stratum1/10-refclocks-pps0.conf
  else
    # set default offset 0.0 for GPS
    sed -i "s/offset.*$/offset 0.0/g" /etc/chrony/stratum1/10-refclocks-pps0.conf
fi

# just let it all settle
sleep 1

# start GPSD with ttyAMA0/pps0 in background
/usr/sbin/gpsd -n -N -P /run/gpsd/gpsd.pid /dev/ttyAMA0 /dev/pps0 &

# just let it all settle
sleep 1

# start chronyd in foreground
/usr/sbin/chronyd -d 
