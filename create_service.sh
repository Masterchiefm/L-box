#!/bin/bash
echo 输入service名
read name
echo 输入service指令
read cmd



cat << EOF > /etc/systemd/system/$name.service 
[Unit]

Description=Rclone

After=network-online.target



[Service]

Type=simple

ExecStart=$cmd

Restart=on-abort

User=root



[Install]

WantedBy=default.target

EOF
#cat /etc/systemd/system/$name.service
systemctl daemon-reload
systemctl enable $name
systemctl start $name
echo '完成'
