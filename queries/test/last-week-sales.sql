WITH text AS (
  SELECT 'Rentals can only have one payment' AS value
), expect AS (
  SELECT 1 AS value
), actual AS (
  SELECT
    COUNT(rental_id) AS value
  FROM payment
  GROUP BY rental_id
  ORDER BY COUNT(rental_id) DESC
  LIMIT 1
)
:evaluate_test
