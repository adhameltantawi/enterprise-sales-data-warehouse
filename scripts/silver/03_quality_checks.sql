-- Check For Nulls or Duplicates in primary key
-- Expectation: No Result

SELECT
    cst_id,
    COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1
