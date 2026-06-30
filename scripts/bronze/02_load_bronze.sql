BULK INSERT bronze.crm_cust_info
FROM 'E:\data\braa\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO

-- Quality check
-- select * from bronze.crm_cust_info;

BULK INSERT bronze.crm_sales_details
FROM 'E:\data\braa\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
WITH 
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO

