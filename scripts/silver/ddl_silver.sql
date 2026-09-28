

    DROP TABLE IF EXISTS silver.crm_cust_info;


CREATE TABLE silver.crm_cust_info (
    cst_id              INT,
    cst_key             VARCHAR(50),
    cst_firstname       VARCHAR(50),
    cst_lastname        VARCHAR(50),
    cst_marital_status  VARCHAR(50),
    cst_gndr            VARCHAR(50),
    cst_create_date     timestamp,
    dwh_create_date timestamp default current_timestamp
);



    DROP TABLE IF EXISTS silver.crm_prd_info;


create table silver.crm_prd_info (
prd_id int,
cat_id varchar(50),
prd_key varchar(50),
prd_key varchar(50),
prd_nm varchar(50),
prd_cost int,
prd_line varchar(50),
prd_start_dt date,
prd_end_dt date,
dwh_create_date timestamp default current_timestamp
)


    drop table if exists silver.crm_sales_details;

create table silver.crm_sales_details(
sls_ord_num varchar(50),
sls_prd_key varchar(50),
sls_cust_id int,
sls_order_dt date,
sls_ship_dt date,
sls_due_dt date,
sls_sales int,
sls_quantity int,
sls_price int,
dwh_create_date timestamp default current_timestamp
);


    DROP TABLE IF EXISTS silver.erp_loc_a101;


CREATE TABLE silver.erp_loc_a101 (
    cid    VARCHAR(50),
    cntry  VARCHAR(50),
    dwh_create_date timestamp default current_timestamp
);



    DROP TABLE IF EXISTS silver.erp_cust_az12;


CREATE TABLE silver.erp_cust_az12 (
    cid    VARCHAR(50),
    bdate  timestamp,
    gen    VARCHAR(50),
    dwh_create_date timestamp default current_timestamp
);


    DROP TABLE IF EXISTS silver.erp_px_cat_g1v2;


CREATE TABLE silver.erp_px_cat_g1v2 (
    id           VARCHAR(50),
    cat          VARCHAR(50),
    subcat       VARCHAR(50),
    maintenance  VARCHAR(50),
    dwh_create_date timestamp default current_timestamp
);
