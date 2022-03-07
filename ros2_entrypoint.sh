#!/bin/bash
source /opt/ros/foxy/setup.bash
source /home/ros/dev_ws/install/setup.bash
ros2 launch botvac_node botvac_base.launch.py
#tail -f /dev/null #if launch doesn't work, comment it out and uncomment this