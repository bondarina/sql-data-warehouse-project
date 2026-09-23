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


