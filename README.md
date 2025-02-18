# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_p1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_project_p1;

-- Create Table
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


```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql

select * from retail_sales limit 10;

select count(*) from retail_sales;

select gender, count(*) from retail_sales group by gender;

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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
Select * from retail_sales where sale_date='2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT 
  *
Select * from retail_Sales where category='Clothing' and quantiy >= 4 and to_char(sale_date,'YYYY-MM')='2022-11';
-- OR
Select * from retail_Sales where category='Clothing' and quantiy >= 4 and sale_date between '2022-11-01' and '2022-11-30';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
Select category, sum(total_sale) as total_sale, count(*) as total_orders 
from retail_sales group by category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
Select round(avg(age),2) as Average_age from retail_Sales where category='Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
Select * from retail_Sales where total_sale>1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
Select Category, gender, count(*) from retail_Sales
group by Category, gender;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select customer_id, sum(total_sale) as Total_Sale from retail_Sales 
group by customer_id order by total_Sale desc limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
Select category, count(distinct customer_id) Customer_count from retail_Sales group by category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Contact: Created by Ritika Garg (https://github.com/ritika2810-hash)

This project is part of my achievements to showcasing the SQL skills essential for data analyst roles. 
