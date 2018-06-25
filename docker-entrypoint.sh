#! /bin/sh

if [ "$NODE" ]
then
        cat > /config.json << EOF
{
    "languages": [{"name":"akoma3.0"}],
    "fieldsDefaults": {
        "docLocale": "it"
    },
    "server": {
        "node": "$NODE"
    }
}
EOF

        if [ "$(diff /limebuild/config.json /config.json)" != "" ]
        then
                echo >&2 "New url for lime-server!"
                cp /config.json /limebuild/config.json
                cd /limebuild
#                /sencha/Sencha/Cmd/5.1.3.61/sencha app clean
                /sencha/Sencha/Cmd/5.1.3.61/sencha app refresh
                cd -
        fi
else
        echo >&2 "Please, use NODE to point to the full url of lime-server (e.g. localhost:9006)"
fi

service apache2 start 
cd /limeserver/lime-server/ && node server.js
