#!/bin/sh

echo "Startup at $(date)" >> /tmp/startup.log 2>&1

echo "Wait" >> /tmp/startup.log 2>&1
sleep 10

echo "Configure TTL" >> /tmp/startup.log 2>&1
sysctl -w net.inet.ip.ttl=65 >> /tmp/startup.log 2>&1

echo "Remap tilda" >> /tmp/startup.log 2>&1
hidutil property --matching '{"ProductID":0x29a}' --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000064},{"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035}]}' >> /tmp/startup.log 2>&1
