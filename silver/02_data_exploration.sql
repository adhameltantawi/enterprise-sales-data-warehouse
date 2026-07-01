/*
=============================================================
Data Exploration & Profiling: Bronze Layer
=============================================================
Script Purpose:
    Explore and profile the bronze layer tables to understand
    data characteristics, identify quality issues, and inform
    silver layer transformation logic.

    Tables Explored:
        - bronze.crm_cust_info
        - bronze.crm_sales_details
        - bronze.crm_prd_info
        - bronze.erp_custaz12
        - bronze.erp_loc_a101
        - bronze.erp_px_cat_g1v2
=============================================================
*/

USE DataWarehouse;
GO

-- =========================================================
-- CRM Tables
-- =========================================================

SELECT TOP 1000 * FROM bronze.crm_cust_info;
SELECT TOP 1000 * FROM bronze.crm_sales_details;
SELECT TOP 1000 * FROM bronze.crm_prd_info;

-- =========================================================
-- ERP Tables
-- =========================================================

SELECT TOP 1000 * FROM bronze.erp_custaz12;
SELECT TOP 1000 * FROM bronze.erp_loc_a101;
SELECT TOP 1000 * FROM bronze.erp_px_cat_g1v2;