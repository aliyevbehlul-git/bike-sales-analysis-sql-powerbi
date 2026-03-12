-- =========================================
-- 1. Base dataset
-- =========================================
with bsds as (select 
o.order_id,
p.product_name,
b.brand_name,
extract(year from p.model_year) as model_year,
oi.quantity,
oi.list_price,
oi.discount,
(oi.quantity * oi.list_price)-(oi.quantity * oi.list_price*oi.discount) as profit,
o.order_date,
o.required_date,
o.shipped_date,
s.store_name
from orders o
left join stores s
on o.store_id=s.store_id
left join order_items oi
on o.order_id=oi.order_id
left join products p
on p.product_id=oi.product_id
left join brands b
on b.brand_id=p.brand_id
)

select * from bsds;
-- =========================================
-- 2. Top brands
-- =========================================
with bsds as (
select 
o.order_id,
p.product_name,
b.brand_name,
extract(year from p.model_year) as model_year,
oi.quantity,
oi.list_price,
oi.discount,
(oi.quantity * oi.list_price)-(oi.quantity * oi.list_price*oi.discount) as profit,
o.order_date,
o.required_date,
o.shipped_date,
s.store_name
from orders o
left join stores s
on o.store_id=s.store_id
left join order_items oi
on o.order_id=oi.order_id
left join products p
on p.product_id=oi.product_id
left join brands b
on b.brand_id=p.brand_id
)

select
brand_name,
round(sum(profit),2) as total_profit
from bsds
group by brand_name
order by total_profit desc
fetch first 5 rows only;
-- =========================================
-- 3. Profit per order
-- =========================================
with bsds as (select 
o.order_id,
p.product_name,
b.brand_name,
extract(year from p.model_year) as model_year,
oi.quantity,
oi.list_price,
oi.discount,
(oi.quantity * oi.list_price)-(oi.quantity * oi.list_price*oi.discount) as profit,
o.order_date,
o.required_date,
o.shipped_date,
s.store_name
from orders o
left join stores s
on o.store_id=s.store_id
left join order_items oi
on o.order_id=oi.order_id
left join products p
on p.product_id=oi.product_id
left join brands b
on b.brand_id=p.brand_id
)

select
round(sum(profit) / count(distinct order_id),2) as profit_per_order
from bsds;
-- =========================================
-- 4. Profit by model year
-- =========================================
with bsds as (select 
o.order_id,
p.product_name,
b.brand_name,
extract(year from p.model_year) as model_year,
oi.quantity,
oi.list_price,
oi.discount,
(oi.quantity * oi.list_price)-(oi.quantity * oi.list_price*oi.discount) as profit,
o.order_date,
o.required_date,
o.shipped_date,
s.store_name
from orders o
left join stores s
on o.store_id=s.store_id
left join order_items oi
on o.order_id=oi.order_id
left join products p
on p.product_id=oi.product_id
left join brands b
on b.brand_id=p.brand_id
)

select
model_year,
round(sum(profit),2) as total_profit
from bsds
group by model_year
order by total_profit desc
fetch first 5 rows only;
-- =========================================
-- 5. Top products
-- =========================================
with bsds as (select 
o.order_id,
p.product_name,
b.brand_name,
extract(year from p.model_year) as model_year,
oi.quantity,
oi.list_price,
oi.discount,
(oi.quantity * oi.list_price)-(oi.quantity * oi.list_price*oi.discount) as profit,
o.order_date,
o.required_date,
o.shipped_date,
s.store_name
from orders o
left join stores s
on o.store_id=s.store_id
left join order_items oi
on o.order_id=oi.order_id
left join products p
on p.product_id=oi.product_id
left join brands b
on b.brand_id=p.brand_id
)

select
product_name,
round(sum(profit),2) as total_profit
from bsds
group by product_name
order by total_profit desc
fetch first 5 rows only;
-- =========================================
-- 6. Profit by store
-- =========================================
with bsds as (select 
o.order_id,
p.product_name,
b.brand_name,
extract(year from p.model_year) as model_year,
oi.quantity,
oi.list_price,
oi.discount,
(oi.quantity * oi.list_price)-(oi.quantity * oi.list_price*oi.discount) as profit,
o.order_date,
o.required_date,
o.shipped_date,
s.store_name
from orders o
left join stores s
on o.store_id=s.store_id
left join order_items oi
on o.order_id=oi.order_id
left join products p
on p.product_id=oi.product_id
left join brands b
on b.brand_id=p.brand_id
)

select
store_name,
round(sum(profit),2) as total_profit
from bsds
group by store_name
order by total_profit desc
fetch first 5 rows only;
-- =========================================
-- 7. Orders by store
-- =========================================
with bsds as (select 
o.order_id,
p.product_name,
b.brand_name,
extract(year from p.model_year) as model_year,
oi.quantity,
oi.list_price,
oi.discount,
(oi.quantity * oi.list_price)-(oi.quantity * oi.list_price*oi.discount) as profit,
o.order_date,
o.required_date,
o.shipped_date,
s.store_name
from orders o
left join stores s
on o.store_id=s.store_id
left join order_items oi
on o.order_id=oi.order_id
left join products p
on p.product_id=oi.product_id
left join brands b
on b.brand_id=p.brand_id
)

select
store_name,
count(order_id) as total_orders
from bsds
group by store_name
order by total_orders desc;
-- =========================================
-- 8. Profit by state
-- =========================================
with bsds as (select 
o.order_id,
p.product_name,
b.brand_name,
extract(year from p.model_year) as model_year,
oi.quantity,
oi.list_price,
oi.discount,
(oi.quantity * oi.list_price)-(oi.quantity * oi.list_price*oi.discount) as profit,
o.order_date,
o.required_date,
o.shipped_date,
case
    when o.shipped_date is null then 'not delivered'
        when o.shipped_date < o.required_date then 'delivered early'
        when o.shipped_date > o.required_date then 'delivered late'
        else 'delivered in time'
    end as delivery,
s.store_name,
s.state,
decode(state,'CA','California',
             'NY','New_York',
             'TX','Texas') as states
from orders o
left join stores s
on o.store_id=s.store_id
left join order_items oi
on o.order_id=oi.order_id
left join products p
on p.product_id=oi.product_id
left join brands b
on b.brand_id=p.brand_id
)

select
states,
round(sum(profit),2) as total_profit
from bsds
group by states
order by total_profit desc;
-- =========================================
-- 9. Total profit
-- =========================================
with bsds as (select 
o.order_id,
p.product_name,
b.brand_name,
extract(year from p.model_year) as model_year,
oi.quantity,
oi.list_price,
oi.discount,
(oi.quantity * oi.list_price)-(oi.quantity * oi.list_price*oi.discount) as profit,
o.order_date,
o.required_date,
o.shipped_date,
s.store_name,
s.state
from orders o
left join stores s
on o.store_id=s.store_id
left join order_items oi
on o.order_id=oi.order_id
left join products p
on p.product_id=oi.product_id
left join brands b
on b.brand_id=p.brand_id
)

select sum(profit) as total_profit
from bsds;
-- =========================================
-- 10. Average profit
-- =========================================
with bsds as (select 
o.order_id,
p.product_name,
b.brand_name,
extract(year from p.model_year) as model_year,
oi.quantity,
oi.list_price,
oi.discount,
(oi.quantity * oi.list_price)-(oi.quantity * oi.list_price*oi.discount) as profit,
o.order_date,
o.required_date,
o.shipped_date,
s.store_name,
s.state
from orders o
left join stores s
on o.store_id=s.store_id
left join order_items oi
on o.order_id=oi.order_id
left join products p
on p.product_id=oi.product_id
left join brands b
on b.brand_id=p.brand_id
)

select round(avg(profit),2) as average_profit
from bsds;
-- =========================================
-- 11. Total orders
-- =========================================
with bsds as (select 
o.order_id,
p.product_name,
b.brand_name,
extract(year from p.model_year) as model_year,
oi.quantity,
oi.list_price,
oi.discount,
(oi.quantity * oi.list_price)-(oi.quantity * oi.list_price*oi.discount) as profit,
o.order_date,
o.required_date,
o.shipped_date,
s.store_name,
s.state
from orders o
left join stores s
on o.store_id=s.store_id
left join order_items oi
on o.order_id=oi.order_id
left join products p
on p.product_id=oi.product_id
left join brands b
on b.brand_id=p.brand_id
)

select count(*) as orders
from bsds;
-- =========================================
-- 12. Delivery analysis
-- =========================================
with bsds as (
select 
o.order_id,
p.product_name,
b.brand_name,
extract(year from p.model_year) as model_year,
oi.quantity,
oi.list_price,
oi.discount,
(oi.quantity * oi.list_price) * (1 - oi.discount) as profit,
o.order_date,
o.required_date,
o.shipped_date,
case
    when o.shipped_date is null then 'not delivered'
        when o.shipped_date < o.required_date then 'delivered early'
        when o.shipped_date > o.required_date then 'delivered late'
        else 'delivered in time'
    end as delivery
from orders o
left join order_items oi
    on o.order_id = oi.order_id
left join products p
    on p.product_id = oi.product_id
left join brands b
    on b.brand_id = p.brand_id
)

select delivery,
count(*)
from bsds
group by delivery
order by count(*) desc;

Add SQL analysis queries


