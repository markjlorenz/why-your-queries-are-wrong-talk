\set query /queries/sales-by-store-by-month.sql
:setup_test
WITH text AS (
  SELECT 'Store #3 has the right number of sales' AS value
), expect AS (
  SELECT
    SUM(payment.amount) AS value
  FROM store
  JOIN staff USING(store_id)
  JOIN payment USING(staff_id)
  WHERE store_id = 3
    AND DATE_PART('month', payment_date) = 3
), precheck_not_blank AS (
  INSERT INTO :"prechecks" (value)
  SELECT COALESCE(SUM(value) > 0, FALSE)
  FROM expect
), actual AS (
  SELECT
    total_payment AS value
  FROM "/queries/sales-by-store-by-month.sql"
  WHERE store_id = 3
    AND payment_month = 3
)
:evaluate_test
:cleanup_test
