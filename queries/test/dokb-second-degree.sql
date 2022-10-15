\set query /queries/degrees-of-kevin-bloom.sql
:setup_test
WITH text AS (
  SELECT 'The second degree actors are correct' AS value
), kevin_bloom AS (
  SELECT
     actor_id
  FROM actor
  WHERE first_name ILIKE 'KEVIN'
    AND last_name ILIKE 'BLOOM'
), kevin_bloom_films AS (
  SELECT
    film_actor.film_id
  FROM film_actor
  JOIN kevin_bloom USING(actor_id)
), first_degree_actors AS (
  SELECT DISTINCT ON (film_actor.actor_id)
    film_actor.film_id
    ,film_actor.actor_id
    ,actor.first_name
    ,actor.last_name
  FROM film_actor
  JOIN kevin_bloom_films USING(film_id)
  JOIN actor USING(actor_id)
  LEFT OUTER JOIN kevin_bloom USING(actor_id)-- need to remove Kevin himself.
  WHERE kevin_bloom.actor_id IS NULL
  ORDER BY film_actor.actor_id
), first_degree_films AS (
  SELECT
    film_actor.film_id
  FROM film_actor
  JOIN first_degree_actors USING(actor_id)
), second_degree_actors AS (
  SELECT DISTINCT ON (film_actor.actor_id)
    film_actor.film_id
    ,film_actor.actor_id
    ,actor.first_name
    ,actor.last_name
  FROM film_actor
  JOIN first_degree_films USING(film_id)
  JOIN actor USING(actor_id)
  LEFT OUTER JOIN kevin_bloom USING(actor_id)-- need to remove Kevin himself.
  LEFT OUTER JOIN first_degree_actors USING(actor_id)-- need to remove first-degree actors
  WHERE kevin_bloom.actor_id IS NULL
    AND first_degree_actors.actor_id IS NULL
  ORDER BY film_actor.actor_id
), expect AS (
  SELECT
    -- bunch up all the actor_ids for comparison
    ARRAY_AGG(actor_id::integer ORDER BY actor_id) AS value
  FROM second_degree_actors
), actual AS (
  SELECT
    ARRAY_AGG(actor_id::integer ORDER BY actor_id) AS value
  FROM "/queries/degrees-of-kevin-bloom.sql"
  WHERE degree = 2
)
:evaluate_test
:cleanup_test
