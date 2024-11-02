#!/bin/bash

if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root"
    exit 1
fi

BINARY_PATH="/usr/local/bin/file_lua"
SERVICE_PATH="/etc/systemd/system/file_lua.service"

curl -L -o "$BINARY_PATH" "https://github.com/USERNAME/REPO/releases/download/v1.0/file_lua"
chmod 755 "$BINARY_PATH"

cat > "$SERVICE_PATH" << EOL
[Unit]
Description=File Lua Service
After=network.target

[Service]
Type=simple
ExecStart=$BINARY_PATH
Restart=on-failure
RestartSec=5
StartLimitInterval=0

[Install]
WantedBy=multi-user.target
EOL

systemctl daemon-reload
systemctl enable file_lua
systemctl start file_lua
