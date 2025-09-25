# /opt/myapp/start.sh
#!/bin/bash
# 确保没有重复启动
if pgrep -x "npc" > /dev/null
then
    echo "npc is running"
else
    echo "launching npc..."
    /mnt/disk_0/softwares/nps/npc > /var/log/myapp.log 2>&1 &
    echo $! > /var/run/npc.pid
fi