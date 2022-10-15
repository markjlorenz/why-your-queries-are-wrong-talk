## Why your SQL queries are wrong and what to do about it.

```sh
export PG_PASSWORD="password"
export PG_PORT="5437"
```

```sh
# run the database server
docker run -it --rm \
  --publish "$PG_PORT":5432 \
  --env POSTGRES_PASSWORD="$PG_PASSWORD" \
postgres
```

```
# get the sample database
curl \
  --location \
  --remote-header-name \
  --remote-name \
https://github.com/robconery/dvdrental/raw/master/dvdrental.tar > dvdrental.tar
```

```sh
# load the sample data
docker run -it --rm \
  --env PGPASSWORD="$PG_PASSWORD" \
  --volume "$PWD":/work \
  --workdir /work \
postgres pg_restore \
  -h host.docker.internal \
  -p "$PG_PORT" \
  -U postgres \
  --verbose \
  --dbname postgres \
  ./dvdrental.tar
```

```sh
# connect to the test database
docker run -it --rm \
  --env PGPASSWORD="$PG_PASSWORD" \
  --volume "$PWD/queries":/queries \
  --workdir /queries \
postgres psql \
  -h host.docker.internal \
  -p "$PG_PORT" \
  -U postgres
```

