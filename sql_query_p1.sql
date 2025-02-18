-- create table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
transactions_id	INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id	INT,
gender VARCHAR(10),
age	INT,
category VARCHAR(15),	
quantiy	INT,
price_per_unit FLOAT,	
cogs FLOAT,
total_sale FLOAT
);


select * from retail_sales;
limit 10;

select count(*) from retail_sales;

select gender, count(*) from retail_sales
group by gender;

select * from retail_sales where
transactions_id	is null or
sale_date is null or
sale_time is null or
customer_id	is null or
gender is null or
--age	is null or
category is null or
quantiy	is null or
price_per_unit is null or	
cogs is null or
total_sale is null;

Delete from retail_sales where
transactions_id	is null or
sale_date is null or
sale_time is null or
customer_id	is null or
gender is null or
--age	is null or
category is null or
quantiy	is null or
price_per_unit is null or	
cogs is null or
total_sale is null;

--Data Exploration
-- How many sales we have?
select count(*) as total_Sales from retail_sales;

--How many unique customers we have?
select count(distinct customer_id) as total_customers from retail_Sales;

--How many unique category we have?
select count(distinct category) as total_customers from retail_Sales;


-- Data Analysis & Business key problems and answers
-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
Select * from retail_sales where sale_date='2022-11-05';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more than 4 in the month of Nov-2022:
Select * from retail_Sales where category='Clothing' and quantiy >= 4 and to_char(sale_date,'YYYY-MM')='2022-11';
-- OR
Select * from retail_Sales where category='Clothing' and quantiy >= 4 and sale_date between '2022-11-01' and '2022-11-30';
select sale_date, to_char(sale_date,'DD-MM') from retail_sales;

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.:
Select category, sum(total_sale) as total_sale, count(*) as total_orders 
from retail_sales 
group by category;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
Select round(avg(age),2) as Average_age from retail_Sales where category='Beauty';

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
Select * from retail_Sales where total_sale>1000;

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
Select Category, gender, count(*) from retail_Sales
group by Category, gender;

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

Select Year, Month, Average_sale from (
Select to_char(sale_date, 'YYYY') as Year, to_char(sale_date, 'MM') as Month,  avg(total_sale) as Average_Sale,
RANK() OVER(PARTITION BY to_char(sale_date, 'YYYY') ORDER BY avg(total_sale) DESC) as rank
from retail_Sales
group by to_char(sale_date, 'YYYY'), to_char(sale_date, 'MM')) as
tb where tb.rank=1;

-- OR

Select Year, Month, Average_sale from (
Select extract(Year from sale_date) as Year, extract(Month from sale_date) as Month,  avg(total_sale) as Average_Sale,
RANK() OVER(PARTITION BY extract(Year from sale_date) ORDER BY avg(total_sale) DESC) as rank
from retail_Sales
group by extract(Year from sale_date), extract(Month from sale_date)) as
tb where tb.rank=1;

-- 8. Write a SQL query to find the top 5 customers based on the highest total sales:
select customer_id, sum(total_sale) as Total_Sale from retail_Sales 
group by customer_id order by total_Sale desc limit 5;

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.:
Select category, count(distinct customer_id) Customer_count from retail_Sales group by category;

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

select shift, count(transactions_id) from(
Select *, CASE
when EXTRACT(HOUR from sale_time) < 12 then 'Morning'
WHEN EXTRACT(HOUR from sale_time) between 12 and 17 THEN 'Afternoon'
ELSE 'Evening' END AS Shift
from retail_Sales)
group by shift;

--OR

With shift_hour
AS(
Select *, CASE
when EXTRACT(HOUR from sale_time) < 12 then 'Morning'
WHEN EXTRACT(HOUR from sale_time) between 12 and 17 THEN 'Afternoon'
ELSE 'Evening' END AS Shift
from retail_Sales)

Select shift, count(transactions_id) from shift_hour group by shift;

-- End of project
