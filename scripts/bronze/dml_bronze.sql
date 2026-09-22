/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `COPY...FROM...WITH()` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    CALL bronze.load_bronze;
===============================================================================
*/


-- >>> CREATE THE STORED PROCEDURE

create or replace
procedure bronze.load_bronze()
language plpgsql
as $$
declare
v_batch_start_time timestamptz;

v_start_time timestamptz;

v_duration numeric;

begin
	v_batch_start_time := clock_timestamp();

raise notice '===========================';

raise notice '>> Loading Bronze layer';

raise notice '===========================';

v_start_time := clock_timestamp();

raise notice '>> Truncating Table: bronze.crm_cust_info';

truncate
	table bronze.crm_cust_info;

raise notice '>> Inserting Data Into: bronze.crm_cust_info';

copy bronze.crm_cust_info
from
'/Users/darina/Documents/DWH training/sql-data-warehouse-project-main/datasets/source_crm/cust_info.csv'
  with(
  format csv,
  header true,
  delimiter ','
);

v_duration := extract(
epoch from (clock_timestamp() - v_start_time)
);

raise notice '>> Step duration % seconds',
v_duration;

raise notice '>> crm_cust_info loaded';

raise notice '===========================';

v_start_time := clock_timestamp();

raise notice '>> Truncating Table: bronze.crm_prd_info';

truncate
	table bronze.crm_prd_info;

raise notice '>> Inserting Data Into: bronze.crm_prd_info';

copy bronze.crm_prd_info
from
'/Users/darina/Documents/DWH training/sql-data-warehouse-project-main/datasets/source_crm/prd_info.csv'
with(
format csv,
header true,
delimiter ','
);

v_duration := extract(
epoch from (clock_timestamp() - v_start_time)
);

raise notice '>> Step duration % seconds',
v_duration;

raise notice '>> prd_info loaded';

raise notice '===========================';

v_start_time := clock_timestamp();

raise notice '>> Truncating Table: bronze.crm_sales_details';

truncate
	table bronze.crm_sales_details;

raise notice '>> Inserting Data Into: bronze.crm_sales_details';

copy bronze.crm_sales_details
from
'/Users/darina/Documents/DWH training/sql-data-warehouse-project-main/datasets/source_crm/sales_details.csv'
with(
format csv,
header true,
delimiter ','
);

v_duration := extract(
epoch from (clock_timestamp() - v_start_time)
);

raise notice '>> Step duration % seconds',
v_duration;

raise notice '>> sales_details loaded';

raise notice '===========================';

v_start_time := clock_timestamp();

raise notice '>> Truncating Table: bronze.erp_cust_az12';

truncate
	table bronze.erp_cust_az12;

raise notice '>> Inserting Data Into: bronze.erp_cust_az12';

copy bronze.erp_cust_az12
from
'/Users/darina/Documents/DWH training/sql-data-warehouse-project-main/datasets/source_erp/CUST_AZ12.csv'
with(
format csv,
header true,
delimiter ','
);

v_duration := extract(
epoch from (clock_timestamp() - v_start_time)
);

raise notice '>> Step duration % seconds',
v_duration;

raise notice '>> erp_cust_az12 loaded';

raise notice '===========================';

v_start_time := clock_timestamp();

raise notice '>> Truncating Table: bronze.erp_loc_a101';

truncate
	table bronze.erp_loc_a101;

raise notice '>> Inserting Data Into: bronze.erp_loc_a101';

copy bronze.erp_loc_a101
from
'/Users/darina/Documents/DWH training/sql-data-warehouse-project-main/datasets/source_erp/LOC_A101.csv'
with(
format csv,
header true,
delimiter ','
);

v_duration := extract(
epoch from (clock_timestamp() - v_start_time)
);

raise notice '>> Step duration % seconds',
v_duration;

raise notice '>> erp_loc_a101 loaded';

raise notice '===========================';

v_start_time := clock_timestamp();

raise notice '>> Truncating Table: bronze.erp_px_cat_g1v2';

truncate
	table bronze.erp_px_cat_g1v2;

raise notice '>> Inserting Data Into: bronze.erp_px_cat_g1v2';

copy bronze.erp_px_cat_g1v2
from
'/Users/darina/Documents/DWH training/sql-data-warehouse-project-main/datasets/source_erp/PX_CAT_G1V2.csv'
with(
format csv,
header true,
delimiter ','
);

v_duration := extract(
epoch from (clock_timestamp() - v_start_time)
);

raise notice '>> Step duration % seconds',
v_duration;

raise notice '>> erp_px_cat_g1v2 loaded';

raise notice '===========================';

v_duration := extract(
epoch from (clock_timestamp() - v_batch_start_time)
);

raise notice '>> Total duration % seconds',
v_duration;

exception
when others then
raise warning 'Loading failed. Code %, message %',
sqlstate,
sqlerrm;

raise;
end;

$$;


-- >>> EXECUTE THAT STORED PROCEDURE

call bronze.load_bronze();
