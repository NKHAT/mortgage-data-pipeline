CREATE OR REPLACE TABLE `cdl_mortgage.temp_legacy_los_clean` AS
SELECT 
  CAST(loan_id AS STRING) AS loan_id,
  ssn,
  CAST(loan_amount AS INT64) AS loan_amount,
  CAST(interest_rate AS FLOAT64) AS interest_rate,
  status AS loan_status,
  SAFE_CAST(created_date AS TIMESTAMP) AS created_at
FROM `rdl_mortgage.legacy_los_raw`
WHERE loan_id IS NOT NULL;
