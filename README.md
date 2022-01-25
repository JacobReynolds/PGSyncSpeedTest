# PgSync DB sync test
This repo performs testing on the awesome (PGSync)[https://pgsync.com] to identify bottlenecks in the syncing between the database and redis. There are two modes to run this in, 1) with PGSync version 2.1.10, and one with a (proposed pull request)[https://github.com/toluaina/pgsync/pull/234] containing batched writes to redis. To toggle between those two update `./docker-compose.yml` line 50 to `Dockerfile.new` for the new version and `Dockerfile` for the old version.

## Results
When 100k rows are inserted into postgres the new version queues those results into Redis in ~4 seconds. With the previous version it would take about a minute. The subsequent processing of those items and pushing to Elasticsearch depend on system performance, but significant improvements in overall sync speed can be seen on multi-core systems.

## Running
```console
me@terminal-1:~$ docker-compose up --build
me@terminal-1:~$ docker logs pgsync -f
me@terminal-2:~$ docker exec -it postgres /bin/bash
me@postgres:~$ psql -U postgres
> insert into numbers (item) SELECT d from generate_series(0, 100000) d;
```
Watch the logs from the pgsync container to see results. Primarily the count of `Db: [0]` and `Redis: [pending]` to see the results of the DB->Redis sync.