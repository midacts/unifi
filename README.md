unifi
=====

Script to install Ubiquiti's unifi controller on a Debian Linux machine

My only other recommendation besides running this script is to make your partition you will be installing unifi on to be in 
the neighborhood of 20GBs. Otherwise you will get error messages like this in /var/log/mongodb/mongodb.log

Tue May 13 13:08:21.851 [initandlisten] ERROR: Insufficient free space for journal files
Tue May 13 13:08:21.851 [initandlisten] Please make at least 3379MB available in /var/lib/mongodb/journal or use --smallfiles
Tue May 13 13:08:21.851 [initandlisten]
Tue May 13 13:08:21.891 [initandlisten] exception in initAndListen: 15926 Insufficient free space for journals, terminating
Tue May 13 13:08:21.891 dbexit:
