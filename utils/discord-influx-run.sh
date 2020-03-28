if [[ -z $GUILD_ID ]]; then
    echo "You need to specify a GUILD_ID in the env.discord_influx file"
elif [[ -z $GUILD_NAME ]]; then
    echo "You need to specify a GUILD_NAME in the env.discord_influx file"
fi
until $(curl --output /dev/null --silent --head --fail http://influxdb:8086/ping); do
    echo "waiting for InfluxDB"
    sleep 10
done
echo "InfluxDB is up and running"
echo "Creating discord database"
curl -XPOST 'http://influxdb:8086/query' --data-urlencode 'q=CREATE DATABASE "discord"'
/discord-influx $GUILD_NAME/$GUILD_ID -s 0 --all -h http://influxdb:8086