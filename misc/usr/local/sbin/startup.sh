#!/bin/sh

echo "Startup at $(date)" >> /tmp/startup.log 2>&1
sleep 1

echo "Configure TTL" >> /tmp/startup.log 2>&1
sysctl -w net.inet.ip.ttl=65 >> /tmp/startup.log 2>&1
