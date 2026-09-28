-- >> Inserting silver.crm_cust_info
-- read more details here https://app.notion.com/p/Coding-data-cleansing-check-quality-of-bronze-then-transform-data-then-insert-that-data-into-sil-3dee3b304b7880a3944fd84b120aac2f?source=copy_link

insert into silver.crm_cust_info (
cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_marital_status,
cst_gndr,
cst_create_date
)
select
	cst_id,
	cst_key,
	trim(cst_firstname) as cst_firstname,
	trim(cst_lastname) as cst_lastname,
	case
		when upper(trim(cst_marital_status)) = 'S' then 'Single'
		when upper(trim(cst_marital_status)) = 'M' then 'Married'
	end cst_marital_status,
	case
		when upper(trim(cst_gndr)) = 'F' then 'Female'
		when upper(trim(cst_gndr)) = 'M' then 'Male'
		else 'n/a'
	end cst_gndr,
	cst_create_date
from
	(
	select
		*,
		row_number() over (partition by cst_id
	order by
		cst_create_date desc) as flag_last
	from
		bronze.crm_cust_info
)t where flag_last = 1;

insert
	into
	silver.crm_prd_info (
    prd_id,
    cat_id,
	prd_key, 
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt)
select
	prd_id,
	substring(prd_key, 7, length(prd_key)) as prd_key,
	replace(substring(prd_key, 1 , 5), '-', '_') as cat_id,
	prd_nm,
	coalesce(prd_cost, 0) as prd_cost,
	case
		upper(trim(prd_line))
	when 'R' then 'Road'
		when 'S' then 'other Sales'
		when 'M' then 'Mountain'
		when 'T' then 'Touring'
		else 'n/a'
	end as prd_line,
	cast(prd_start_dt as date),
	cast (lead(prd_start_dt) over(partition by prd_key order by prd_start_dt) - interval '1 day' as date) as prd_end_dt
from
	bronze.crm_prd_info;



