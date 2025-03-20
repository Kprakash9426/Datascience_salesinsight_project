 /*  1. Sales Summary by Category--You can calculate total sales for each product category to understand which category generates the most revenue.*/
select funiture_sales.Category,sum(Sales) as total_sales
from sales.funiture_sales 
group by funiture_sales.Category 
order by total_sales desc;

/*2. Top-Selling cities --You can identify the top-selling cities by looking at the total sales or quantity sold.*/
select City,sum(Sales) as total_sales 
from sales.funiture_sales
group by City
order by total_sales desc
Limit 10;
/*2. Top-selling profit --You can identify the top 10-profit cities by looking at the total sales or quantity sold.*/
select city,sum(Profit) as total_profit
from sales.funiture_sales
group by city
order by total_profit desc
Limit 10;
/*5. Geographical Analysis--By aggregating data by State or City, you can see where the highest sales or profits are coming from geographically.*/
select State,sum(Sales) as total_sales 
from sales.funiture_sales
group by State
order by total_sales desc
Limit 10;

select State,sum(Profit) as total_profit 
from sales.funiture_sales
group by State
order by total_profit desc
Limit 10;
/*Profit Analysis--You can analyze the profit for each product and identify which products are making the most and least profit.*/
select product_name,sum(Profit) as total_profit 
from sales.funiture_sales
group by product_name
order by total_profit desc
Limit 10;

select Customer_Name,sum(Profit) as total_profit 
from sales.funiture_sales
group by Customer_Name
order by total_profit desc
Limit 10;
/*4. Customer Segments and Sales--By grouping data by customer Segment (Consumer, Corporate, etc.), you can evaluate which segments bring in the most revenue.*/
select Segment,sum(Profit) as total_profit from sales.funiture_sales
group by Segment
order by total_profit desc;

select Segment,sum(Sales) as total_sales from sales.funiture_sales
group by Segment
order by total_sales desc;

/*6. Discount Impact on Sales--You can analyse how discounts are affecting the sales and profit. This can be done by looking at the correlation between Discount and Profit.*/

SELECT 
    (SUM((discount - avg_discount) * (profit - avg_profit)) / COUNT(*) ) /
    (STDDEV_POP(discount) * STDDEV_POP(profit)) AS correlation
FROM 
    sales.funiture_sales,
    (SELECT 
         AVG(discount) AS avg_discount, 
         AVG(profit) AS avg_profit
     FROM sales.funiture_sales) AS averages;

/* total sales volume with discount and without discount*/
select sum(case when Discount>0 then Quantity Else 0 end ) as sales_with_discount,
sum(case when Discount=0 then Quantity Else 0 end ) as sales_without_discount
from sales.funiture_sales;

/* impact on revenue: 1) revenue with out discount and revenue with discount*/
SELECT
    SUM(CASE 
            WHEN Discount > 0 THEN (Sales  - Discount) * Quantity
            ELSE Sales * Quantity
        END) AS total_revenue,
    SUM(CASE 
            WHEN Discount = 0 THEN Sales * Quantity
            ELSE 0
        END) AS total_revenue_without_discount
FROM sales.funiture_sales;

# Alter table name
ALTER TABLE sales.funiture_sales RENAME COLUMN `Customer Name` TO Customer_Name;
ALTER TABLE sales.funiture_sales RENAME COLUMN `ï»¿Row ID` TO Row_ID;



select * from sales.funiture_sales