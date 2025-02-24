-- 1) Download and install the northwind database - northwind.sql - from here (https://github.com/pthom/northwind_psql)
-- install the database from:
-- Mac terminal: 
-- >> navigate to your download folder
-- >> type: createdb northwind -U postgres
-- >> type: psql northwind < northwind.sql
-- Windows:
-- >> We'll have to figure it out :) 

-- Once installed, run the query below (in psql or pgadmin4)

SELECT p.product_id, o.order_id, p.unit_price, od.quantity
FROM orders as o
JOIN order_details as od ON o.order_id = od.order_id
JOIN products as p ON p.product_id = od.product_id;

-- 2) Look at the query results, and modify the above query to get the order totals for each order.
-- IMPORTANT: Note that each order is broken up into multiple rows, so you'll need to group by order_id
-- ALSO IMPORTANT: You have to do some math here. How do you get the order total? You'll have to 
-- multiply the unit_price column by the quanity column, then SUM over each order_id

SELECT 
	SUM(p.unit_price*od.quantity) AS "total order cost"
	,o.order_id

FROM orders as o
	JOIN order_details as od 
		ON o.order_id = od.order_id
	JOIN products as p 
		ON p.product_id = od.product_id

GROUP BY
	o.order_id

ORDER BY
	o.order_id;



-- ANDREW
SELECT SUM(p.unit_price*od.quantity)
FROM orders as o
JOIN order_details as od ON o.order_id = od.order_id
JOIN products as p ON p.product_id = od.product_id
GROUP BY o.order_id;

-- 3) Use the above query as a CTE, and use AVG, stddev_samp, and COUNT, to get the mean, standard deviation
-- of the orders, and how many orders there are total.

WITH total_orders as (SELECT 
						SUM(p.unit_price*od.quantity) AS "total order cost"
						,o.order_id

					FROM orders as o
						JOIN order_details as od 
							ON o.order_id = od.order_id
						JOIN products as p 
							ON p.product_id = od.product_id

					GROUP BY
						o.order_id

					ORDER BY
						o.order_id)

SELECT
	AVG("total order cost")
	,STDDEV_SAMP("total order cost")
	,COUNT("total order cost")

FROM
	total_orders;






-- ANDREW
WITH order_totals as (
SELECT SUM(p.unit_price*od.quantity) as total
FROM orders as o
JOIN order_details as od ON o.order_id = od.order_id
JOIN products as p ON p.product_id = od.product_id
GROUP BY o.order_id)
SELECT AVG(total), stddev_samp(total), COUNT(total)
FROM order_totals;

-- 4) The CEO of your company announced the other week that the company's long run average sales per order is 
-- $1850! Do you believe him? Assuming the data in this database is only a subset of all the sales
-- (and that this database is a good representation of all of the other sales databases for the company)
-- Set up a hypothesis test based on suspicion that he's exaggerating. IE. we're going to try to give compelling evidence
-- that the sales are less than $1850.
-- You want to bring this up to your boss ONLY if you really sure, like 95% sure.

-- Use the results of the last query to do this in excel.
-- What's the null hypothesis?
-- What's the alternative hypothesis?
-- What's the significance level?
-- Is this a one or two tail test?
-- What's the standard error for our sample?
-- What's the cutoff threshold for your decision?
-- What's your p value?
-- WHat's your conclusion?
