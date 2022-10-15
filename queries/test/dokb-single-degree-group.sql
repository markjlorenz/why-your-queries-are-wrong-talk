\set query /queries/degrees-of-kevin-bloom.sql
:setup_test
WITH text AS (
  SELECT 'Each actor can only be in a single "degree" group' AS value
), expect AS (
  SELECT
    COUNT(actor_id) AS value
  FROM "/queries/degrees-of-kevin-bloom.sql"
), actual AS (
  SELECT
    COUNT(DISTINCT actor_id) AS value
  FROM "/queries/degrees-of-kevin-bloom.sql"
)
:evaluate_test
:cleanup_test
