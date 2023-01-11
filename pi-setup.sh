#!/bin/bash
#set -x
source /home/ubuntu/.bashrc
#export ROS_MASTER_URI=/sbin/ip -o -4 addr list tun0 | awk '{print $4}' | cut -d/ -f1

export ROS_MASTER_URI=http://10.0.30.232:11311
#export ROS_IP=$(/sbin/ip -o -4 addr list wlan0 | awk '{print $4}' | cut -d/ -f1)

#Camera feed
motion

while true ; do
	if (pgrep -x openvpn > /dev/null)
	then
		echo "Openvpn running"
	else
		echo "Restarting openvpn"
		(openvpn --config /etc/openvpn/client/pi-client.ovpn & ) 
	fi
	if (pgrep -x mavros_node > /dev/null)
	then
		echo "Mavros running"
	else
		echo "Restarting mavros"
		export ROS_IP=$(/sbin/ip -o -4 addr list tun0 | awk '{print $4}' | cut -d/ -f1) && roslaunch mavros px4.launch &
	fi
	sleep 60
done





