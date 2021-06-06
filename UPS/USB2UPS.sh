#!/bin/sh
charge=$(upsc qnapups@127.0.0.1 2>/dev/null| grep 'battery.charge:' | cut -d ' ' -f 2)
load=$(upsc qnapups@127.0.0.1 2>/dev/null| grep 'ups.load:' | cut -d ' ' -f2)
power=$(upsc qnapups@127.0.0.1 2>/dev/null| grep 'ups.power:' | cut -d ' ' -f2)
frequency=$(upsc qnapups@127.0.0.1 2>/dev/null| grep 'output.frequency:' | cut -d ' ' -f2)
voltage=$(upsc qnapups@127.0.0.1 2>/dev/null| grep 'battery.voltage:' | cut -d ' ' -f2)
input_frequency=$(upsc qnapups@127.0.0.1 2>/dev/null| grep 'input.frequency:' | cut -d ' ' -f2)
input_voltage=$(upsc qnapups@127.0.0.1 2>/dev/null| grep 'input.voltage:' | cut -d ' ' -f2)
realpower=$(upsc qnapups@127.0.0.1 2>/dev/null| grep 'ups.realpower:' | cut -d ' ' -f2)
runtime=$(upsc qnapups@127.0.0.1 2>/dev/null| grep 'battery.runtime:' | cut -d ' ' -f2)

echo "ups,ups_name=eaton,host=127.0.0.1 charge=$charge,load=$load,power=$power,frequency=$frequency,voltage=$voltage,realpower=$realpower,input_frequency=$input_frequency,input_voltage=$input_voltage,runtime=$runtime