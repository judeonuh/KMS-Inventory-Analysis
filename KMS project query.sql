
-- Table Overview
SELECT * FROM KMS_tb;

-- DATA CLEANING

-- Checking for Null values
SELECT * FROM KMS_tb
WHERE 
	Row_ID IS NULL OR	
	Order_ID IS NULL OR
	Order_Date IS NULL OR
	Order_Priority IS NULL OR
	Order_Quantity	IS NULL OR
	Sales IS NULL OR
	Discount IS NULL OR
	Ship_Mode	IS NULL OR
	Profit IS NULL OR
	Unit_Price	IS NULL OR
	Shipping_Cost IS NULL OR
	Customer_Name	IS NULL OR
	Province IS NULL OR
	Region IS NULL OR
	Customer_Segment	IS NULL OR
	Product_Category	IS NULL OR
	Product_Sub_Category IS NULL OR
	Product_Name IS NULL OR
	Product_Container	IS NULL OR
	Product_Base_Margin IS NULL OR
	Ship_Date IS NULL;


-- Replace nulls in Profit, Unit_Price and Product_Base_Margin columns
UPDATE KMS_tb
SET Profit = ISNULL(Profit, 0),
	Unit_Price = ISNULL(Unit_Price, 0),
	Product_Base_Margin = ISNULL(Product_Base_Margin, 0)
WHERE
	Profit IS NULL OR
	Unit_Price IS NULL OR
	Product_Base_Margin IS NULL;


-- Find duplicates
SELECT
	Row_ID,
	Order_ID,
	Order_Date,
	Order_Priority,
	Order_Quantity,
	Sales,
	Discount,
	Ship_Mode,
	Profit,
	Unit_Price,
	Shipping_Cost,
	Customer_Name,
	Province,
	Region,
	Customer_Segment,
	Product_Category,
	Product_Sub_Category,
	Product_Name,
	Product_Container,
	Product_Base_Margin,
	Ship_Date,
	COUNT (*)
FROM KMS_tb
GROUP BY Row_ID, Order_ID, Order_Date, Order_Priority, Order_Quantity, Sales,
	Discount, Ship_Mode, Profit, Unit_Price, Shipping_Cost, Customer_Name, Province,
	Region,	Customer_Segment, Product_Category, Product_Sub_Category, Product_Name,
	Product_Container, Product_Base_Margin, Ship_Date
HAVING COUNT(*) > 1;

-- 1. Which product category had the highest sales?
SELECT 
	Product_Category, 
	SUM(Sales) AS TotalSales
FROM KMS_tb
GROUP BY Product_Category
ORDER BY TotalSales DESC;


-- 2. What are the Top 3 and Bottom 3 regions in terms of sales?
-- Top 3
SELECT 
	Region, 
	SUM(Sales) AS RegionSales
FROM KMS_tb
GROUP BY Region
ORDER BY RegionSales DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

-- Bottom 3
SELECT 
	Region, 
	SUM(Sales) AS RegionSales
FROM KMS_tb
GROUP BY Region
ORDER BY RegionSales ASC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;


-- 3. What were the total sales of appliances in Ontario?
SELECT
	SUM(Sales) AS TotalSales
FROM KMS_tb
WHERE Region = 'Ontario';


-- 4. Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers
SELECT 
	TOP 10 Customer_Name,
	SUM(Sales) AS TotalSales
FROM KMS_tb
GROUP BY Customer_Name
ORDER BY TotalSales ASC;


-- 5. KMS incurred the most shipping cost using which shipping method?
SELECT
	Ship_Mode,
	SUM(Shipping_Cost) AS ShippingCost
FROM KMS_tb
GROUP BY Ship_Mode
ORDER BY ShippingCost DESC;


-- 6. Who are the most valuable customers, and what products or services do they typically purchase?
-- Most Valuable Customers
SELECT
	TOP 10 Customer_Name, 
	SUM(Sales) AS TotalSpent
FROM KMS_tb
GROUP BY Customer_Name
ORDER BY TotalSpent DESC;

-- Customers' typical purchase
SELECT
	TOP 10 Customer_Name,
	Product_Category,
	SUM(Sales) AS TotalSpent
FROM KMS_tb
GROUP BY Customer_Name, Product_Category
ORDER BY TotalSpent DESC;


-- 7. Which small business customer had the highest sales?
SELECT 
	TOP 1 Customer_Name, 
	SUM(Sales) AS TotalSales
FROM KMS_tb
WHERE Customer_Segment = 'Small Business'
GROUP BY Customer_Name
ORDER BY TotalSales DESC;


-- 8. Which Corporate Customer placed the most number of orders in 2009 – 2012?
SELECT 
	TOP 1 Customer_Name,
	COUNT(Order_ID) AS TotalOrders
FROM KMS_tb
WHERE Customer_Segment = 'Corporate'
	AND YEAR(Order_Date) BETWEEN 2009 AND 2012
GROUP BY Customer_Name
ORDER BY TotalOrders DESC;


-- 9. Which consumer customer was the most profi table one?
SELECT 
	TOP 1 Customer_Name,
	SUM(Profit) AS TotalProfit
FROM KMS_tb
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name
ORDER BY TotalProfit DESC;


-- 10. Which customer returned items, and what segment do they belong to?
SELECT 
	DISTINCT k.Customer_Name,
	k.Customer_Segment,
	COUNT(o.Order_ID) AS Total_Returned
FROM KMS_tb AS k
Inner Join Orders_tb AS o
	ON k.Order_ID = o.Order_ID
WHERE o.Status = 'Returned'
GROUP BY k.Customer_Name, k.Customer_Segment
ORDER BY Total_Returned DESC;


/*
11. If the delivery truck is the most economical but the slowest shipping method and Express Air is the fastest but the most expensive one, 
do you think the company appropriately spent shipping costs based on the Order Priority? Explain your answer
*/
SELECT
	Order_Priority,
	Ship_Mode,
	SUM(Shipping_Cost) AS Total_Shipping_Cost,
	COUNT(Order_ID) AS Total_Orders,
	SUM(Order_Quantity) AS Total_Qty
FROM KMS_tb
GROUP BY Order_Priority, Ship_Mode
ORDER BY Total_Shipping_Cost DESC, Total_Orders DESC, Total_Qty DESC;
