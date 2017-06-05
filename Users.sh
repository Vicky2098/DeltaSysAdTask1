#!/usr/bin/env bash
for (( i=0; i<=3; i++ ))
do
	groupadd GroupDelta$i
done

for (( i=0; i<=9; i++ ))
do
	adduser "user$i"
	mkdir /home/"user$i"/Delta
	for (( j=1; j<=10; j++ ))
	do
		mkdir /home/"user$i"/Delta/"Folder$j"
		cat /dev/urandom | tr -cd [:alnum:] | head -c 10 > /home/"user$i"/Delta/"Folder$j"/"random$i-$j.txt"
	done
	chown -R "user$i" /home/"user$i"/Delta
	chmod 770 -R /home/"user$i"/Delta
	if [[ $i = 0 ]]
	then
		chgrp -R DeltaGroup3 /home/"user$i"/Delta
		usermod -a -G GroupDelta0,GroupDelta1,GroupDelta2,GroupDelta3 user0
	elif [[ $i -gt 0 && $i -lt 4 ]]
	then 
		chgrp -R GroupDelta2 /home/"user$i"/Delta
		usermod -a -G GroupDelta0,GroupDelta1 user$i
	elif [[ $i -gt 3 && $i -lt 7 ]]
	then 
		chgrp -R GroupDelta1 /home/"user$i"/Delta
		usermod -a -G GroupDelta0 user$i
	elif [[ $i -gt 6 && $i -lt 10 ]]
	then 
		chgrp -R GroupDelta0 /home/"user$i"/Delta
	fi
done