#!/bin/bash

dir=$(cd $(dirname $0); pwd)

slack_post () {
curl -m 10 -s -X POST --data-urlencode \
  "payload={ \"channel\": \"$4\",
             \"username\": \"$2\",
             \"text\": \"$3\",
             \"icon_emoji\": \":raspberry:\"}" $1
}

slack_URL=${SLACK_TOKEN}
#Give the Raspberry Pi a Recognizable Name
name=${RPI_NAME}

flag=true
wlan_ip=$(ip a show wlan0 | grep "inet " | cut -f6 -d ' ')
if test -n $wlan_ip; then
  text="wlan0="$wlan_ip
  echo $text
  slack_post $slack_URL $name $text ${SLACK_CHANNEL} 
fi

eth_ip=$(ip a show eth0 | grep "inet " | cut -f6 -d ' ')
if  test -n $eth_ip; then
  text="eth0="$eth_ip
  echo $text
  slack_post $slack_URL $name $text ${SLACK_CHANNEL}
fi

g_ip=$(curl -m 10 inet-ip.info)
if test -n $g_ip; then
  text="global_IP_address="$g_ip
  echo $text
  slack_post $slack_URL $name $text ${SLACK_CHANNEL} && flag=false
fi

if "${flag}" ; then
  text="w:"$wlan_ip"e:"$eth_ip"g:"$g_ip
  python3 $dir/local_network/socket_send.py $name $text
fi
