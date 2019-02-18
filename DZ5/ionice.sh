#!/usr/bin/env bash
<<<<<<< HEAD:DZ4/untitled.sh


# Services to check
SERVICES=('mysql' 'nginx' 'php-fpm')

# Contact email
EMAIL="info@example.com"

# Hostname (automatic)
HOST=$HOSTNAME

# Subject
STATUS="Service-Status {$HOSTNAME}"


# - stop editing - #


for SERVICE in "${SERVICES[@]}"; do
        var=`ps -eaf | grep ${SERVICE} | grep -v grep | wc -l`

        if [ "$var" -lt "1" ]; then
                service ${SERVICE} restart

                if [ "$var" -lt "1" ]; then
                        echo "${HOST}: ${SERVICE} konnte nicht neugestartet werden!" | mail -s "$STATUS" $EMAIL
                else
                        echo "${HOST}: ${SERVICE} wurde erfolgreich neugestartet." | mail -s "$STATUS" $EMAIL
                fi
        else
                echo "${SERVICE} laeuft bereits."
        fi

done
=======
>>>>>>> e3dae234c2d0fc7c73e646ec8a4ea5eda45a6c65:DZ5/ionice.sh
