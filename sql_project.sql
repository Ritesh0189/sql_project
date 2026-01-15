

-----SQL DATA PROJE
CREATE DATABSE SQL_PROJECT1


---- CREATE TAble
SELECT * FROM public.retail_sales;
ORDER BY transactions_id ASC LIMIT 100

----count records
select
    count(*)
	 from retail_sales;
-----check null values
	 select * from retail_sales
where 
   transactions_id is null
   or
   sale_date is null
   or
   sale_time is null
   or
   customer_id is null
   or
   gender is null
   or
   age is null
   or 
   category is null
   or
   quantiy is null
   or
   price_per_unit is null
   or
   cogs is null
   or 
   total_sale is null;

   ---

delete from retail_sales
where 
   transactions_id is null
   or
   sale_date is null
   or
   sale_time is null
   or
   customer_id is null
   or
   gender is null
   or
   age is null
   or 
   category is null
   or
   quantiy is null
   or
   price_per_unit is null
   or
   cogs is null
   or 
   total_sale is null;


   
   ----DAta Exploration 

   --how many sales we have
   select count(*) as total_sales from retail_sales

   ---- how many uniuque customer we have 
   select count (DISTINCT customer_id) as total_sale from retail_sales

   select distinct category from retail_sales

   ---data Analysis

-----1)specific date sale
   select * from retail_sales where sale_date ='2022-11-05';
-----2)all transaction when category is Clothing
   select * from retail_sales where category ='Clothing'
   and  to_char(sale_date, 'yyyy-mm')='2022-11'
   and quantiy >=4
-----3) total sales for each category
   select category,
   sum(total_sale) as net_sale,
   count (*) as total_orders
   from retail_sales
   group by 1
-----4) avg age of customer who purchase beauty
   select  round(avg(age),2) as avg_age from retail_sales where category ='Beauty'
-----5) total sale greter then 1000
   select   * from 
   retail_sales where total_sale >1000
-----6) total number of transaction id for category and gender
   select 
         category,
		 gender,
		 count (*) total_trans
 from retail_sales
 group by
 			category,
			 gender
 order by 1


 -----7)write sql query to calculate the average sale for each month
select 
  		year,
		  month,
		  avg_sale
from 
(
select
		extract(year from sale_date) as year,
		extract (month from sale_date) as month,
		avg(total_sale) as avg_sale,
		rank() over(partition by extract(year from sale_date) order by avg(total_sale)desc)as rank
	from retail_sales
	group by 1,2
	) as t1
	where rank =1
		
	select * from retail_sales;	 

-------8) unique customer sales
	
  select 
        customer_id,
		sum(total_sale) as total_sales
  from retail_sales
  group by 1
  order by 2 desc
  limit 5

  
------9) number of customer who purchase unique category

select 
		category,
		count(distinct customer_id) as count_unique_cs
		from retail_sales
		group by category

-----10)order by shift
		
with hourly_sale
as(
select *,
	case
		when extract(hour from sale_time)< 12 then 'morning'
		when extract(hour from sale_time) between 12 and 17 then 'afternoon'
		else 'evening'
	end as shift
from retail_sales
)
select 
		shift,
		count (*) as total_orders
	from hourly_sale
	group by shift


		   
		   