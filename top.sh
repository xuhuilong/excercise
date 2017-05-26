#!/bin/sh
# cpu 最高的前10个进程
ps aux | head -1 | gawk '{print $11,$2,$3,$4}' | tee /var/log/stat-top10-ps-cpu.log ; ps aux | grep -v PID | sort -rn -k +3 | head | gawk '{print $11,$2,$3,$4}' | tee -a /var/log/stat-top10-ps-cpu.log

# 内存 最高的前10个进程
ps aux | head -1 | gawk '{print $11,$2,$3,$4}' | tee /var/log/stat-top10-ps-mem.log ; ps aux | grep -v PID | sort -rn -k +4 | head | gawk '{print $11,$2,$3,$4}' | tee -a /var/log/stat-top10-ps-mem.log
