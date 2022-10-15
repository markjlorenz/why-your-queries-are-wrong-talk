-- How much payment has the company recieved for
-- rentals in the last week?
--
SELECT
  SUM(payment.amount)::money
FROM rental
JOIN payment USING(rental_id)
WHERE rental.rental_date > :'today'::date - 7
;
