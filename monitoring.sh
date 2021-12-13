#!/bin/bash
Memused=$(free -m|grep Mem | sed -e 's/  */ /g'|cut -d ' ' -f 3)
Memtotal=$(free -m|grep Mem | sed -e 's/  */ /g'|cut -d ' ' -f 2)
if (lsblk | grep -q LVM)
then
	LVM=yes
else
	LVM=no
fi

wall -n "
	#Architecture : $(uname -a)
	#CPU physical : $(getconf _NPROCESSORS_ONLN)
	#vCPU : $(cat /proc/cpuinfo | grep processor | wc -l)
	#Memory Usage: $Memused/$Memtotal"MB"$(free -t | awk 'NR ==2 {print $3/$2*100}' | cut -d '.' -f 1 | sed -e 's/ˆ/\(/')%)
	#Disk Usage: $(df --total -h | grep "total" | sed -e '/s/  */ /g'|cut -d' ' -f 3)/$(df --total -h | grep "total"|sed -e 's/  */ /g'| cut -d ' ' -f 2, 5)
	#CPU load: $(top -bn1 | grep "Cpu"| cut -d ' ' -f 2,5)
	#Lastboot: $(who -b | sed -e 's/  */ /g' | cut -d ' ' -f 4-)
	#LVM use: $LVM
	#Connexions TCP : $(ss | grep "tcp"| wc -l) ESTABLISHED
	#User log: "$(($(w | wc -l) -2))"
	#Network: IP $(ip addr | grep inet | cut -d$'\n' -f 3 | cut -d '/' -f 1 | cut -d ' '-f 6) ($(ip addr | grep "ether"| cut -d ' '-f 6))
	#Sudo : $(($(cat /var/log/sudo/sudo.log | wc -l)/2)) cmd"
