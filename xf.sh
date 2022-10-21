#!/bin/sh
##

# Set ARG
UUID=4c864979-559a-4936-9c44-7be1049ca768
#ARCH="64"
cat <<EOF >/etc/cctv/config.json
{
    "log": {
        "loglevel": "warning"
    },
	"inbounds": [
		{
			"listen": "0.0.0.0",
			"port": 8080,
			"protocol": "vless",
			"settings": {
				"clients": [
					{
						"id": "$UUID"
					}
				],
			"decryption": "none"
		},
		"streamSettings": {
			"network": "ws",
			"wsSettings": {
					"path": "/$UUID-vless"
				}
			}
		}
	],
	"outbounds": [
		{
			"protocol": "freedom"
		}
	]
}
EOF


chmod +x /usr/bin/cctv/cctv
ls -la /usr/bin/cctv/*
echo "Install done"
echo "--------------------------------"
echo "Fly App Name: ${FLY_APP_NAME}"
echo "Fly App Region: ${FLY_REGION}"
echo "cctv UUID: ${UUID}"
echo "--------------------------------"

# Run cctv
/usr/bin/cctv/cctv  run -config=/etc/cctv/config.json
