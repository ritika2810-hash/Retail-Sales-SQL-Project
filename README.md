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
DROP TABLE IF EXISTS RETAIL_SALES;

CREATE TABLE RETAIL_SALES(
TRANSACTIONS_ID	INT PRIMARY KEY,
SALE_DATE DATE,
SALE_TIME TIME,
CUSTOMER_ID	INT,
GENDER VARCHAR(10),
AGE	INT,
CATEGORY VARCHAR(15),	
QUANTIY	INT,
PRICE_PER_UNIT FLOAT,	
COGS FLOAT,
TOTAL_SALE FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT * FROM RETAIL_SALES LIMIT 10;

SELECT count(*) FROM RETAIL_SALES;

SELECT GENDER, COUNT(*) FROM RETAIL_SALES GROUP BY GENDER;

SELECT * FROM RETAIL_SALES WHERE
TRANSACTIONS_ID	IS NULL OR
SALE_DATE IS NULL OR
SALE_TIME IS NULL OR
CUSTOMER_ID	IS NULL OR
GENDER IS NULL OR
--AGE	IS NULL OR
CATEGORY IS NULL OR
QUANTIY	IS NULL OR
PRICE_PER_UNIT IS NULL OR	
COGS IS NULL OR
TOTAL_SALE IS NULL;

DELETE FROM RETAIL_SALES WHERE
TRANSACTIONS_ID	IS NULL OR
SALE_DATE IS NULL OR
SALE_TIME IS NULL OR
CUSTOMER_ID	IS NULL OR
GENDER IS NULL OR
--AGE	IS NULL OR
CATEGORY IS NULL OR
QUANTIY	IS NULL OR
PRICE_PER_UNIT IS NULL OR	
COGS IS NULL OR
TOTAL_SALE IS NULL;

--Data Exploration
-- How many sales we have?
SELECT COUNT(*) AS TOTAL_SALES FROM RETAIL_SALES;

--How many unique customers we have?
SELECT COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_CUSTOMERS FROM RETAIL_SALES;

--How many unique category we have?
SELECT COUNT(DISTINCT CATEGORY) AS TOTAL_CUSTOMERS FROM RETAIL_SALES;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

**1. Write a query to find total revenue generated?**
```sql
SELECT SUM(TOTAL_SALE) AS TOTAL_REVENUE FROM RETAIL_SALES;
```

**2. Write a SQL query to retrieve all columns for sales made on '2022-11-05:**
```sql
SELECT * FROM RETAIL_SALES WHERE SALE_DATE='2022-11-05';
```

**3. How many total transactions have been recorded?**
```sql
SELECT COUNT(*) AS TOTAL_TRANSACTIONS FROM RETAIL_SALES;
```

**4. List all unique product categories.**
```sql
SELECT DISTINCT CATEGORY FROM RETAIL_SALES;
```

**5. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:**
```sql
SELECT * FROM RETAIL_SALES WHERE CATEGORY='CLOTHING' AND QUANTIY >= 4 AND TO_CHAR(SALE_DATE,'YYYY-MM')='2022-11';
-- OR
SELECT * FROM RETAIL_SALES WHERE CATEGORY='CLOTHING' AND QUANTIY >= 4 AND SALE_DATE BETWEEN '2022-11-01' AND '2022-11-30';
--SELECT SALE_DATE, TO_CHAR(SALE_DATE,'DD-MM') FROM RETAIL_SALES;
```

**6. Write a SQL query to calculate the total sales (total_sale) for each category.:**
```sql
SELECT CATEGORY, SUM(TOTAL_SALE) AS TOTAL_SALE, COUNT(*) AS TOTAL_ORDERS 
FROM RETAIL_SALES 
GROUP BY CATEGORY;
ECT DISTINCT CATEGORY FROM RETAIL_SALES;
```

**7. How many units of each product category were sold and show top most category first?**
```sql
SELECT CATEGORY, SUM(QUANTIY) AS TOTAL_UNITS FROM RETAIL_SALES GROUP BY CATEGORY DESC LIMIT 1;
```

**8. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:**
```sql
SELECT ROUND(AVG(AGE),2) AS AVERAGE_AGE FROM RETAIL_SALES WHERE CATEGORY='BEAUTY';
```

**9. Write a SQL query to find all transactions where the total_sale is greater than 1000.:**
```sql
SELECT * FROM RETAIL_SALES WHERE TOTAL_SALE>1000;
```

**10. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:**
```sql
SELECT CATEGORY, GENDER, COUNT(*) FROM RETAIL_SALES
GROUP BY CATEGORY, GENDER;
```

**11. Which product categories generated the most revenue?**
```sql
SELECT CATEGORY, SUM(TOTAL_SALE) AS TOTAL_REVENUE FROM RETAIL_SALES GROUP BY CATEGORY
ORDER BY SUM(TOTAL_SALE) DESC LIMIT 1;
```

**12. Which customer has spent the most money?**
```sql
SELECT CUSTOMER_ID, SUM(TOTAL_SALE) AS TOTAL_AMOUNT_SPENT FROM RETAIL_SALES
GROUP BY CUSTOMER_ID ORDER BY SUM(TOTAL_SALE) DESC LIMIT 1;
```

**13. What is the average amount each customer spends?**
```sql
SELECT CUSTOMER_ID, CAST(AVG(TOTAL_SALE) AS INT) AS AVERGAE_AMOUNT_SPENT FROM RETAIL_SALES
GROUP BY CUSTOMER_ID;
```

**14. On which day did the highest revenue occur?**
```sql
SELECT SALE_DATE, SUM(TOTAL_SALE) AS TOTAL_REVENUE FROM RETAIL_SALES
GROUP BY SALE_DATE ORDER BY SUM(TOTAL_SALE) DESC LIMIT 1;
```

**15. Find transactions made by customers aged between 25 and 35.**
```sql
SELECT * FROM RETAIL_SALES WHERE AGE BETWEEN 25 AND 35;
```

**16. Show cumulative sales revenue per month.**
```sql
SELECT TO_CHAR(SALE_DATE, 'YYYY-MM') AS YEAR_MONTH, SUM(TOTAL_SALE) AS TOTAL_SALE FROM RETAIL_SALES
GROUP BY TO_CHAR(SALE_DATE, 'YYYY-MM');

-- OR

WITH MONTHLYSALES AS (
    SELECT TO_CHAR(SALE_DATE, 'YYYY-MM') AS SALE_MONTH, SUM(TOTAL_SALE) AS MONTHLY_SALES
    FROM RETAIL_SALES
    GROUP BY SALE_MONTH 
)
SELECT SALE_MONTH, MONTHLY_SALES, 
       SUM(MONTHLY_SALES) OVER (ORDER BY SALE_MONTH) AS TOTAL_SALES_TILL_CURRENT_MONTH
FROM MONTHLYSALES;
```

**17. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:**
```sql
SELECT YEAR, MONTH, AVERAGE_SALE FROM (
SELECT TO_CHAR(SALE_DATE, 'YYYY') AS YEAR, TO_CHAR(SALE_DATE, 'MM') AS MONTH,  AVG(TOTAL_SALE) AS AVERAGE_SALE,
RANK() OVER(PARTITION BY TO_CHAR(SALE_DATE, 'YYYY') ORDER BY AVG(TOTAL_SALE) DESC) AS RANK
FROM RETAIL_SALES
GROUP BY TO_CHAR(SALE_DATE, 'YYYY'), TO_CHAR(SALE_DATE, 'MM')) AS
TB WHERE TB.RANK=1;

-- OR

SELECT YEAR, MONTH, AVERAGE_SALE FROM (
SELECT EXTRACT(YEAR FROM SALE_DATE) AS YEAR, EXTRACT(MONTH FROM SALE_DATE) AS MONTH,  AVG(TOTAL_SALE) AS AVERAGE_SALE,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM SALE_DATE) ORDER BY AVG(TOTAL_SALE) DESC) AS RANK
FROM RETAIL_SALES
GROUP BY EXTRACT(YEAR FROM SALE_DATE), EXTRACT(MONTH FROM SALE_DATE)) AS
TB WHERE TB.RANK=1;
```

**18. Write a SQL query to find the top 5 customers based on the highest total sales:**
```sql
SELECT CUSTOMER_ID, SUM(TOTAL_SALE) AS TOTAL_SALE FROM RETAIL_SALES 
GROUP BY CUSTOMER_ID ORDER BY TOTAL_SALE DESC LIMIT 5;
```

**19. Find customers who made purchases more than once.**
```sql
SELECT CUSTOMER_ID, COUNT(TRANSACTIONS_ID) AS PURCHASE_COUNT FROM RETAIL_SALES GROUP BY CUSTOMER_ID
HAVING COUNT(TRANSACTIONS_ID)>1;
```

**20. Write a SQL query to find the number of unique customers who purchased items from each category.:**
```sql
SELECT CATEGORY, COUNT(DISTINCT CUSTOMER_ID) CUSTOMER_COUNT FROM RETAIL_SALES GROUP BY CATEGORY;
```

**21. Find the hour of the day with the highest sales transactions.**
```sql
WITH HIGHEST_SALE_HOUR 
AS(
SELECT SALE_DATE, TO_CHAR(SALE_TIME, 'HH') AS HOUR, SUM(TOTAL_SALE) AS TOTAL_SALE_AT_HOUR, 
RANK() OVER(PARTITION BY SALE_DATE ORDER BY SUM(TOTAL_SALE) DESC) AS RANK 
FROM RETAIL_SALES
GROUP BY SALE_DATE, TO_CHAR(SALE_TIME, 'HH') 
ORDER BY SALE_DATE
) 

SELECT SALE_DATE, HOUR, TOTAL_SALE_AT_HOUR FROM HIGHEST_SALE_HOUR
WHERE RANK=1;
```

**22. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):**
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

**23. Group customers into different age segments and analyze their total sales.**
```sql
SELECT AGE, COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_UNIQUE_CUSTOMERS, SUM(TOTAL_SALE) AS TOTAL_SALE
FROM RETAIL_SALES GROUP BY AGE;

-- OR

SELECT 
    CASE 
        WHEN AGE < 18 THEN 'UNDER 18'
        WHEN AGE BETWEEN 18 AND 24 THEN '18-24'
        WHEN AGE BETWEEN 25 AND 34 THEN '25-34'
        WHEN AGE BETWEEN 35 AND 44 THEN '35-44'
        WHEN AGE BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS AGE_GROUP,
    COUNT(DISTINCT CUSTOMER_ID) AS UNIQUE_CUSTOMERS,
    SUM(TOTAL_SALE) AS TOTAL_REVENUE
FROM RETAIL_SALES
GROUP BY AGE_GROUP
ORDER BY AGE_GROUP;
```

**24. Find customers who have spent more than the average total sales amount.**
```sql
WITH AVG_SALE_AMT 
AS(
SELECT AVG(TOTAL_sALE) AS AVG_SALE FROM RETAIL_SALES
)
SELECT CUSTOMER_ID, SUM(TOTAL_SALE) AS TOTAL_SALE FROM RETAIL_SALES 
GROUP BY CUSTOMER_ID
HAVING SUM(TOTAL_SALE) > (SELECT * FROM AVG_SALE_AMT)
ORDER BY CUSTOMER_ID;

**25. Calculate sales growth rate month over month.**
WITH FIND_PREV_MONTH_SALE 
AS(
SELECT TO_CHAR(SALE_DATE, 'YYYY-MM') AS YEAR_MONTH, SUM(TOTAL_SALE) AS TOTAL_SALE,
LAG(SUM(TOTAL_SALE), 1) OVER(ORDER BY TO_CHAR(SALE_DATE, 'YYYY-MM')) AS PREV_MONTH_SALE
FROM RETAIL_SALES GROUP BY TO_CHAR(SALE_DATE, 'YYYY-MM')
ORDER BY YEAR_MONTH)

SELECT YEAR_MONTH, TOTAL_SALE, ROUND(cast(((ABS(TOTAL_SALE-PREV_MONTH_SALE)/PREV_MONTH_SALE)*100) AS NUMERIC), 2) AS SALE_GROWTH
FROM FIND_PREV_MONTH_SALE;
```

**26. Find products where the price per unit changed over time.**
```sql
WITH PREV_PRICE_FOR_ITEM
AS(
SELECT SALE_DATE, SALE_TIME, CATEGORY, PRICE_PER_UNIT, LAG(PRICE_PER_UNIT) OVER(
PARTITION BY SALE_DATE, CATEGORY ORDER BY SALE_TIME) AS PREVIOUS_PRICE
FROM RETAIL_SALES
ORDER BY SALE_DATE, CATEGORY)

SELECT SALE_DATE, SALE_TIME, CATEGORY, PRICE_PER_UNIT, COALESCE(PREVIOUS_PRICE, 0),
CASE
	WHEN PRICE_PER_UNIT > PREVIOUS_PRICE THEN 'PRICE INCREASED'
	WHEN PRICE_PER_UNIT < PREVIOUS_PRICE THEN 'PRICE DECREASED'
	ELSE 'NO CHANGE IN PRICE' 
END AS PRICE_TREND
FROM PREV_PRICE_FOR_ITEM;
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
