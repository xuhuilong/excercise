#! /bin/bash

logfile="/var/log/stat-top10-ps-mem.log"
while true;
do
    echo `date` | tee -a $logfile
    echo "top 10 of cpu usage ----------" | tee -a $logfile
    ps ax o pid,pcpu,args --sort -pcpu | head -n 11 | tee -a $logfile
    echo "top 10 of mem usage ----------" | tee -a $logfile
    ps ax o pid,pmem,rss,args --sort -pmem | head -n 11 | tee -a $logfile
    echo "wait 5 minutes"
    sleep 300
done
