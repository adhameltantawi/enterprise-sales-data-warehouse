SELECT *
FROM bronze.crm_cust_info
WHERE cst_id = 29466
/*
cst_id      cst_key     cst_firstname  cst_lastname  cst_marital_status  cst_gndr    cst_create_date
----------  ----------  -------------  ------------  ------------------  ----------  ---------------
29466       AW00029466  NULL           NULL          NULL                NULL        2026-01-25     
29466       AW00029466  Lance          Jimenez       M                   NULL        2026-01-26     
29466       AW00029466  Lance          Jimenez       M                   M           2026-01-27     
*/

-- NOTICE: The above query shows that there are 3 records for cst_id = 29466, with the latest record having the most complete information.
-- So, I will use ROW_NUMBER() to keep only the latest record for each cst_id based on cst_create_date. 


SELECT *
FROM (
SELECT 
*,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info)t WHERE flag_last = 1