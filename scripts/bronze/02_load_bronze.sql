CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    BEGIN TRY
        PRINT '==========================================';
        PRINT 'Loading Bronze Layer';
        PRINT '==========================================';

        PRINT '------------------------------------------';
        PRINT 'Loading CRM Data';
        PRINT '------------------------------------------';

        PRINT '>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> Loading Data into Table: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'E:\data\enterprise-sales-data-warehouse\datasets\source_crm\cust_info.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        -- Quality check
        -- select * from bronze.crm_cust_info;

        PRINT '>> Truncating Table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> Loading Data into Table: bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'E:\data\enterprise-sales-data-warehouse\datasets\source_crm\sales_details.csv'
        WITH 
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        

        -- Quality check
        -- select * from bronze.crm_sales_details;


        PRINT '>> Truncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> Loading Data into Table: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'E:\data\enterprise-sales-data-warehouse\datasets\source_crm\prd_info.csv'
        WITH    
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        

        -- Quality check
        -- select * from bronze.crm_prd_info;

        PRINT '------------------------------------------';
        PRINT 'Loading ERP Data';
        PRINT '------------------------------------------';

        PRINT '>> Truncating Table: bronze.erp_custaz12';
        TRUNCATE TABLE bronze.erp_custaz12;

        PRINT '>> Loading Data into Table: bronze.erp_custaz12';
        BULK INSERT bronze.erp_custaz12
        FROM 'E:\data\enterprise-sales-data-warehouse\datasets\source_erp\CUST_AZ12.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        

        -- Quality check
        -- select * from bronze.erp_custaz12;


        PRINT '>> Truncating Table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>> Loading Data into Table: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'E:\data\enterprise-sales-data-warehouse\datasets\source_erp\LOC_A101.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        

        -- Quality check
        -- select * from bronze.erp_loc_a101;


        PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>> Loading Data into Table: bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'E:\data\enterprise-sales-data-warehouse\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        

        -- Quality check
        -- select * from bronze.erp_px_cat_g1v2;
    END TRY
    BEGIN CATCH
        PRINT '==========================================';
        PRINT 'Error occurred during loading Bronze Layer';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR(10));
        PRINT '==========================================';
    END CATCH
END;
GO

EXEC bronze.load_bronze;