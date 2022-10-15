#!/usr/bin/env bash
set -e

set +x
read -p "Press [enter] to start the show..."
set -v

open title.pdf
read -p "Press [ENTER] to continue..."

open https://www.sqltestingframework.com
read -p "Press [ENTER] to continue..."

open testing-data.pdf
read -p "Press [ENTER] to continue..."

docker run -it --rm \
  --env PGPASSWORD="$PG_PASSWORD" \
  --volume "$PWD/queries":/queries \
  --workdir /queries \
postgres psql \
  -h host.docker.internal \
  -p "$PG_PORT" \
  -U postgres
read -p "Press [ENTER] to continue..."

vim queries/last-week-sales.sql
read -p "Press [ENTER] to continue..."

docker run -it --rm \
  --env PGPASSWORD="$PG_PASSWORD" \
  --volume "$PWD/queries":/queries \
  --workdir /queries \
postgres psql \
  -h host.docker.internal \
  -p "$PG_PORT" \
  -U postgres \
  --variable today="2005-08-02" \
  --command '\include last-week-sales.sql'
read -p "Press [ENTER] to continue..."

open testing-data-questions.pdf
read -p "Press [ENTER] to continue..."

vim queries/test/last-week-sales.sql
read -p "Press [ENTER] to continue..."

cd ./queries/test/
./runner.sh last-week-sales.sql
read -p "Press [ENTER] to continue..."

vim payments-before-rentals.sql
read -p "Press [ENTER] to continue..."

./runner.sh last-week-sales.sql payments-before-rentals.sql
read -p "Press [ENTER] to continue..."

vim payments-happen-quickly.sql
read -p "Press [ENTER] to continue..."

./runner.sh last-week-sales.sql payments-before-rentals.sql payments-happen-quickly.sql
read -p "Press [ENTER] to continue..."

# -TESTING QUERIES------------------------------------

cd ../../
open testing-queries-intro.pdf
read -p "Press [ENTER] to continue..."

vim queries/degrees-of-kevin-bloom.sql
read -p "Press [ENTER] to continue..."

docker run -it --rm \
  --env PGPASSWORD="$PG_PASSWORD" \
  --volume "$PWD/queries":/queries \
  --workdir /queries \
postgres psql \
  -h host.docker.internal \
  -p "$PG_PORT" \
  -U postgres \
  --command '\include degrees-of-kevin-bloom.sql'
read -p "Press [ENTER] to continue..."

open testing-queries.pdf
read -p "Press [ENTER] to continue..."

cd ./queries/test/
vim dokb-single-degree-group.sql
read -p "Press [ENTER] to continue..."

./runner.sh dokb-single-degree-group.sql
read -p "Press [ENTER] to continue..."

vim dokb-first-degree.sql
read -p "Press [ENTER] to continue..."

./runner.sh dokb-single-degree-group.sql dokb-first-degree.sql
read -p "Press [ENTER] to continue..."

vim dokb-second-degree.sql
read -p "Press [ENTER] to continue..."

./runner.sh dokb-single-degree-group.sql dokb-first-degree.sql dokb-second-degree.sql
read -p "Press [ENTER] to continue..."

echo "Break one to show truncation"
read -p "Press [ENTER] to continue..."

vim dokb-first-degree.sql
read -p "Press [ENTER] to continue..."

./runner.sh dokb-single-degree-group.sql dokb-first-degree.sql dokb-second-degree.sql
read -p "Press [ENTER] to continue..."

git restore dokb-first-degree.sql

# -PRE-CHECK ASSERTIONS-------------------------------
cd ../../
open pre-check-assertions-intro.pdf
read -p "Press [ENTER] to continue..."

vim queries/sales-by-store-by-month.sql
read -p "Press [ENTER] to continue..."

docker run -it --rm \
  --env PGPASSWORD="$PG_PASSWORD" \
  --volume "$PWD/queries":/queries \
  --workdir /queries \
postgres psql \
  -h host.docker.internal \
  -p "$PG_PORT" \
  -U postgres \
  --command '\include sales-by-store-by-month.sql'
read -p "Press [ENTER] to continue..."

cd ./queries/test/
vim store-3-is-right.sql
read -p "Press [ENTER] to continue..."

./runner.sh store-3-is-right.sql
read -p "Press [ENTER] to continue..."

cd ../../
open pre-check-assertions.pdf
read -p "Press [ENTER] to continue..."

docker run -it --rm \
  --env PGPASSWORD="$PG_PASSWORD" \
  --volume "$PWD/queries":/queries \
  --workdir /queries \
postgres psql \
  -h host.docker.internal \
  -p "$PG_PORT" \
  -U postgres \
  --command 'SELECT * FROM store;'
read -p "Press [ENTER] to continue..."

cd ./queries/test/
vim store-3-is-right-pre.sql
read -p "Press [ENTER] to continue..."

./runner.sh store-3-is-right-pre.sql
read -p "Press [ENTER] to continue..."

echo "Time to fix the test ..."
read -p "Press [ENTER] to continue..."

vim store-3-is-right-pre.sql
read -p "Press [ENTER] to continue..."

./runner.sh store-3-is-right-pre.sql
read -p "Press [ENTER] to continue..."

git restore store-3-is-right-pre.sql

# -CONCLUSION-----------------------------------------

cd ../../
open conclusion.pdf
read -p "Press [ENTER] to continue..."
