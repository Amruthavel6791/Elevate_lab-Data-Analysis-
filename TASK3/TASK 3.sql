SELECT * FROM ecommerce_project.sales;
#1.BASIC QUERYING AND FILTERING(select,WHERE,ORDER BY,GROUP BY)
SELECT* FROM ecommerce_project.sales
limit 10;
#2.
SELECT*FROM ecommerce_project.sales
WHERE country= 'Australia';
#3
SELECT DISTINCT
Description, UnitPrice 
from ecommerce_project.sales 
ORDER BY UnitPrice desc
LIMIT 5;
#4
SELECT Country,
COUNT(INVOICENO) AS
Total_Sales_records FROM
ecommerce_project.sales
GROUP BY Country;
#------------------------------------------------------------------------------------------------------------------------------
#2. AGGREGATE FUNCTION( SUM, AVG )
SELECT SUM(Quantity*UnitPrice) AS Total_Revenue
FROM
ecommerce_project.sales;
#2
SELECT AVG(QUANTITY) AS
Average_Quantity_sold FROM
ecommerce_project.sales;
#3
SELECT 'customer ID',
SUM(Quantity*UnitPrice) AS
customer_Revenue FROM
ecommerce_project.sales
GROUP BY 'customer ID' ORDER BY
customer_Revenue desc;
#----------------------------------------------------------------------------------------------------------------------
#3. SUBQUERIES
SELECT * FROM
ecommerce_project.sales
WHERE UnitPrice>(SELECT AVG(UNITPRICE) FROM ecommerce_project.sales);
#----------------------------------------------------------------------------------------------------------------------------
DROP TABLE customer_demographics;
CREATE TABLE ecommerce_project.customer_demographics (
    `Customer ID` INT NOT NULL PRIMARY KEY,
    Name VARCHAR(100),
    Age INT
);
#-- Step B: Insert the unique Customer IDs from your sales data
INSERT IGNORE INTO ecommerce_project.customer_demographics (`Customer ID`)
SELECT DISTINCT `CustomerID`
FROM ecommerce_project.sales
WHERE `CustomerID` IS NOT NULL;

#-- Step C (Optional): Add some placeholder names/ages for the first few rows
UPDATE ecommerce_project.customer_demographics
SET Name = 'Alice Johnson', Age = 35
WHERE `Customer ID` = 17850;

UPDATE ecommerce_project.customer_demographics
SET Name = 'Bob Williams', Age = 42
WHERE `Customer ID` = 13047;
SELECT*FROM ecommerce_project.customer_demographics;
#----------------------------------------------------------------------------------------------------------------------------------
#4. JOINS ( INNER, LEFT , RIGHT)
SELECT s.*, c.Name, c.Age 
FROM ecommerce_project.sales 
s INNER JOIN
customer_demographics c ON
s.`CustomerID` = c.`Customer ID`;
#
SELECT s.INVOICENO, s.Description, c.Name 
FROM ecommerce_project.sales s 
LEFT JOIN
customer_demographics c ON 
s.`CustomerID` = c.`Customer ID`;
#
SELECT s.INVOICENO, s.Description, c.Name 
FROM ecommerce_project.sales s 
RIGHT JOIN
customer_demographics c ON 
s.`CustomerID` = c.`Customer ID`;
#----------------------------------------------------------------------------------------------------------------------------------
#5.CREATE VIEW FOR ANALYSIS
CREATE VIEW UK_Sales_Value AS 
SELECT INVOICENO, Description, Quantity, UnitPrice, (Quantity*UnitPrice) As
Line_Item_Value 
FROM ecommerce_project.sales
WHERE Country = 'United Kingdom';

SELECT * FROM UK_Sales_Value
WHERE Line_Item_Value > 100;
#---------------------------------------------------------------------------------------------------------------------------
#6. OPTIMIZE QUERIES WITH INDEX
CREATE INDEX idx_customer_id ON
ecommerce_project.sales(`CustomerID`);

SHOW INDEX FROM ecommerce_project.sales;