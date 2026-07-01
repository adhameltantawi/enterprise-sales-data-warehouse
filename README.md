<div align="center">

# 🏗️ Enterprise Sales Data Warehouse

**An end-to-end data warehouse solution that consolidates CRM and ERP source systems into an analytics-ready platform using SQL Server, Medallion Architecture, and Star Schema modeling.**

[![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)](https://www.microsoft.com/en-us/sql-server)
[![Architecture](https://img.shields.io/badge/Medallion-Architecture-4B8BBE?style=for-the-badge)]()
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)]()

</div>

---

## 📋 Table of Contents

- [Project Overview](#-project-overview)
- [Architecture](#-architecture)
- [Data Sources](#-data-sources)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Pipeline Execution](#-pipeline-execution)
- [Data Model](#-data-model)
- [License](#-license)

---

## 🎯 Project Overview

This project implements a **modern data warehouse** using **Microsoft SQL Server** following industry-standard practices. It consolidates heterogeneous sales data from **CRM** and **ERP** systems into a unified, analytics-ready data model designed for reporting and business intelligence.

### Key Objectives

| Objective | Description |
|---|---|
| **Data Integration** | Merge CRM and ERP source systems into a single consolidated model |
| **Data Quality** | Cleanse, standardize, and resolve data quality issues during transformation |
| **Scalable Architecture** | Implement the Medallion (Bronze → Silver → Gold) layered pattern |
| **Analytics-Ready** | Deliver a Star Schema optimized for BI tools and analytical queries |

---

## 🏛️ Architecture

The warehouse follows the **Medallion Architecture** pattern, progressively refining data through three layers:

```
┌─────────────────────────────────────────────────────────────────┐
│                      DATA SOURCES                               │
│    ┌──────────────┐              ┌──────────────┐               │
│    │   CRM System │              │  ERP System  │               │
│    │  (3 CSVs)    │              │  (3 CSVs)    │               │
│    └──────┬───────┘              └──────┬───────┘               │
│           │                             │                       │
│           └──────────┬──────────────────┘                       │
│                      ▼                                          │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │  🥉 BRONZE LAYER — Raw Ingestion                         │  │
│  │  Exact replica of source data, no transformations         │  │
│  │  Tables: crm_cust_info, crm_prd_info, crm_sales_details  │  │
│  │          erp_custaz12, erp_loc_a101, erp_px_cat_g1v2      │  │
│  └──────────────────────┬────────────────────────────────────┘  │
│                         ▼                                       │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │  🥈 SILVER LAYER — Cleansed & Standardized               │  │
│  │  Data quality fixes, type casting, deduplication          │  │
│  │  + dwh_create_date audit column on every table            │  │
│  └──────────────────────┬────────────────────────────────────┘  │
│                         ▼                                       │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │  🥇 GOLD LAYER — Business-Ready (Star Schema)            │  │
│  │  Dimension & Fact tables optimized for analytics          │  │
│  └───────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

### Layer Details

| Layer | Schema | Purpose | Key Operations |
|---|---|---|---|
| **Bronze** | `bronze` | Raw ingestion | `BULK INSERT` from CSV, truncate-and-load pattern |
| **Silver** | `silver` | Cleansed data | Data quality fixes, standardization, deduplication, audit columns |
| **Gold** | `gold` | Analytics-ready | Star Schema with dimension and fact tables |

---

## 📦 Data Sources

### CRM System (`source_crm/`)

| File | Description | Key Columns | Records |
|---|---|---|---|
| `cust_info.csv` | Customer master data | `cst_id`, `cst_key`, `cst_firstname`, `cst_lastname`, `cst_gndr` | ~18,500 |
| `prd_info.csv` | Product catalog | `prd_id`, `prd_key`, `prd_nm`, `prd_cost`, `prd_line` | ~400 |
| `sales_details.csv` | Sales transactions | `sls_ord_num`, `sls_prd_key`, `sls_cust_id`, `sls_sales` | ~60,000 |

### ERP System (`source_erp/`)

| File | Description | Key Columns |
|---|---|---|
| `CUST_AZ12.csv` | Customer demographics | `cid`, `bdate`, `gen` |
| `LOC_A101.csv` | Customer locations | `cid`, `cntry` |
| `PX_CAT_G1V2.csv` | Product categories | `id`, `cat`, `subcat`, `maintenance` |

---

## 📁 Project Structure

```
enterprise-sales-data-warehouse/
│
├── datasets/                      # Source data files
│   ├── source_crm/                # CRM system exports
│   │   ├── cust_info.csv
│   │   ├── prd_info.csv
│   │   └── sales_details.csv
│   └── source_erp/                # ERP system exports
│       ├── CUST_AZ12.csv
│       ├── LOC_A101.csv
│       └── PX_CAT_G1V2.csv
│
├── scripts/                       # ETL pipeline scripts
│   ├── init_database.sql          # Database & schema creation
│   ├── bronze/                    # Bronze layer scripts
│   │   ├── 01_create_tables.sql   # DDL for bronze tables
│   │   └── 02_load_bronze.sql     # Stored procedure for CSV ingestion
│   └── silver/                    # Silver layer scripts
│       ├── 01_create_tables.sql   # DDL for silver tables
│       ├── 02_data_exploration.sql # Exploration & profiling queries
│       └── 03_quality_checks.sql  # Null & duplicate validation checks
│
├── tests/                         # Test scripts & validation
├── docs/                          # Additional documentation
└── README.md                      # This file
```

---

## 🚀 Getting Started

### Prerequisites

- **Microsoft SQL Server** 2019+ (or Azure SQL)
- **SQL Server Management Studio (SSMS)** or any compatible SQL client
- Sufficient permissions for `CREATE DATABASE`, `BULK INSERT`, and schema operations

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/adhameltantawi/enterprise-sales-data-warehouse.git
   cd enterprise-sales-data-warehouse
   ```

2. **Initialize the database**

   Run the initialization script to create the database and schemas:

   ```sql
   -- Creates DataWarehouse database with bronze, silver, and gold schemas
   -- ⚠️  WARNING: This will DROP an existing DataWarehouse database
   :r scripts/init_database.sql
   ```

3. **Update file paths**

   In `scripts/bronze/02_load_bronze.sql`, update the `BULK INSERT` file paths to match your local dataset directory.

---

## ⚙️ Pipeline Execution

Execute the pipeline layer by layer in the following order:

### Step 1 → Bronze Layer

```sql
-- 1a. Create bronze tables
:r scripts/bronze/01_create_tables.sql

-- 1b. Load data from CSV files into bronze tables
:r scripts/bronze/02_load_bronze.sql

-- This creates and executes the stored procedure: bronze.load_bronze
```

### Step 2 → Silver Layer

```sql
-- 2a. Create silver tables (adds dwh_create_date audit column)
:r scripts/silver/01_create_tables.sql

-- 2b. Explore and profile the data
:r scripts/silver/02_data_exploration.sql

-- 2c. Run null & duplicate validation checks
:r scripts/silver/03_quality_checks.sql
```

### Step 3 → Gold Layer

> 🔜 *Gold layer implementation (Star Schema with dimension and fact tables) is planned for a future release.*

---

## 📊 Data Model

### Bronze Schema

Raw source data is landed as-is with no transformations. Tables mirror the source CSVs exactly.

### Silver Schema

Silver tables extend the bronze schema with:
- **`dwh_create_date`** — Audit timestamp (`DATETIME2 DEFAULT GETDATE()`) tracking when each record was loaded
- Data cleansing and standardization transformations

### Gold Schema (Planned)

The gold layer will implement a **Star Schema** with:
- **Dimension tables** — `dim_customer`, `dim_product`, `dim_date`, etc.
- **Fact table** — `fact_sales` containing measures like sales amount, quantity, and price

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---

<div align="center">


*If you found this project useful, please consider giving it a ⭐*

</div>
