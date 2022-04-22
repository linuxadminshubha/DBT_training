-- Raw Query for creating Customer dimension

select 
customers.c_custkey,
customers.c_name,
customers.c_address,
nations.n_nationkey,
nations.n_name,
regions.r_regionkey,
regions.r_name,
customers.c_phone,
customers.c_acctbal,
customers.c_mktsegment
from sourcedb.mk_mall.customers inner join sourcedb.mk_mall.nations
	on customers.c_nationkey = nations.n_nationkey
	inner join sourcedb.mk_mall.regions
        on nations.n_regionkey = regions.r_regionkey
        limit 500 ;

        
-- Provide friendly column names
select
        c_custkey as customers_id,
        c_nationkey as nations_id,
        c_name as name,
        c_address as address,
        c_phone as phone_number,
        c_acctbal as account_balance,
        c_mktsegment as market_segment,
        c_comment as comment
from sourcedb.mk_mall.customers ;

select
        n_nationkey as nation_id,
        n_regionkey as region_id,
        n_name as name,
        n_comment as comment
from sourcedb.mk_mall.nations;

select
	r_regionkey as region_id,
	r_name as name,
	r_comment as comment
from sourcedb.mk_mall.regions;

-- Use CTEs for easy reading and debugging
with customer as (
select
        c_custkey as customer_id,
        c_nationkey as nation_id,
        c_name as name,
        c_address as address,
        c_phone as phone_number,
        c_acctbal as account_balance,
        c_mktsegment as market_segment,
        c_comment as comment
from sourcedb.mk_mall.customers
),

nation as (
select
        n_nationkey as nation_id,
        n_regionkey as region_id,
        n_name as name,
        n_comment as comment
from sourcedb.mk_mall.nations
),

region as (
select
	r_regionkey as region_id,
	r_name as name,
	r_comment as comment
from sourcedb.mk_mall.regions
),
final as (
select
        customer.customer_id,
        customer.name,
        customer.address,
        nation.nation_id as nation_id,
        nation.name as nation,
        region.region_id as region_id,
        region.name as region,
        customer.phone_number,
        customer.account_balance,
        customer.market_segment 
        from customer
        inner join nation
            on customer.nation_id = nation.nation_id
        inner join region
            on nation.region_id = region.region_id

)
select * from final

    