WITH text AS (
  SELECT 'Payments can not happen before rentals' AS value
), expect AS (
  SELECT 0 AS value
), actual AS (
  SELECT
    COUNT(*) AS value
  FROM rental
  JOIN payment USING(rental_id)
  WHERE payment.payment_date < rental.rental_date
)
:evaluate_test
