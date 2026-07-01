-- Check For Nulls or Duplicates in primary key
-- Expectation: No Result

SELECT
    cst_id,
    COUNT(*) AS cnt
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Output: 
/*
[cst_id] [cnt]
29449	   2
29473	   2
29433	   2
NULL	   3
29483	   2
29466	   3
*/


