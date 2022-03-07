#!/bin/bash
#docker run -dit brianlmerritt/neato_ros_foxy:latest --device=/dev/ttyACM0
docker run -t -i --privileged -v /dev/bus/usb:/dev/bus/usb  brianlmerritt/neato_ros_foxy:latest  -u ros