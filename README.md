SEND IP_address slack or Local!
====

Throw your IP address into Slack. If you are not connected to the Internet, use socket (UDP) communication.
It is assumed to work on Raspberry Pi.

## Usage
$ git clone https://github.com/t-lab-hirosaki/ip-send-slack.git

Please edit the slack "URL", channel, and individual management name accordingly.

$ export RPI_NAME=''

$ export SLACK_TOKEN=''

$ export SLACK_CHANNEL=''

If there is a possibility of restarting, it is recommended to write the above export command in bash_profile or bashrc.


in /etc/rc.local

sleep 60

/home/pi/ip-send-slack/ip_send_slack.sh &

By filling in , it will tell you the IP address when the power is turned on.

Be sure to include the sleep command as it takes time to pick up the network.

## Setup

I created start_up.sh to simplify the setup.

See below for details.

$ bash start_up.sh




-------------------------------------------------

When using socket (UDP) communication, please describe the ip of the send destination.

$ export SLACK_SEND_IP=''

You also need to set up the receiving PC.

Write the following on the receiving server PC and execute ip_slack_recv.py.

$ export SLACK_TOKEN=''

## Author

sosa

t-lab member

Translated to english and modified some minor details by devicemanager
