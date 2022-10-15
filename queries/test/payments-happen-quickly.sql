WITH text AS (
  SELECT 'Most renters make their last payment within 60 days' AS value
), expect AS (
  SELECT 60 AS value
), payment_periods AS (
  SELECT
    rental.rental_id,
    payment.payment_id,
    payment.payment_date - rental.rental_date AS payment_period
  FROM rental
  JOIN payment USING(rental_id)
), actual AS (
  SELECT
    EXTRACT(day FROM AVG(payment_period)) AS value
  FROM payment_periods
)
:evaluate_test
