TRUNCATE TABLE bronze.crm_cust_info;

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


TRUNCATE TABLE bronze.crm_sales_details;
BULK INSERT bronze.crm_sales_details
FROM 'E:\data\braa\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
WITH 
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO

TRUNCATE TABLE bronze.crm_prd_info;
BULK INSERT bronze.crm_prd_info
FROM 'E:\data\braa\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
WITH    
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO

TRUNCATE TABLE bronze.erp_custaz12;
BULK INSERT bronze.erp_custaz12
FROM 'E:\data\braa\sql-data-warehouse-project-main\datasets\source_crm\erp_custaz12'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO

