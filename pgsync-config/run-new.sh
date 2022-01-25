#! /bin/sh
./wait-for-it.sh $PG_HOST:5432 -t 40
./wait-for-it.sh $ELASTICSEARCH_HOST:$ELASTICSEARCH_PORT -t 40
./wait-for-it.sh $REDIS_HOST:$REDIS_PORT -t 40

python3 bin/bootstrap --config schema.json
python3 bin/pgsync --config schema.json --daemon 