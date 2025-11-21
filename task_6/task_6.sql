SELECT
EXTRACT(YEAR FROM COALESCE(
 STR_TO_DATE(InvoiceDate, '%d-%m-%Y %H:%i'),
 STR_TO_DATE(InvoiceDate, '%d-%m-%Y') 
 )
 )AS year_extracted,
EXTRACT(MONTH FROM COALESCE(
 STR_TO_DATE(InvoiceDate, '%d-%m-%Y %H:%i'),
 STR_TO_DATE(InvoiceDate, '%d-%m-%Y') 
 )
 ) AS month_extracted,
SUM(UnitPrice) AS total_revenue,
COUNT(DISTINCT CustomerID) AS order_volume
FROM ecommerce_project.sales
GROUP BY
year_extracted,month_extracted
ORDER BY year_extracted, month_extracted;

#1.EXTRACT MONTH FROM INVOICE DATE
-- SELECT InvoiceDate, STR_TO_DATE(InvoiceDate, '%d-%m-%Y %H:%i') AS pardes_date 
-- FROM sales;

SELECT InvoiceDate, 
EXTRACT(MONTH FROM COALESCE(
 STR_TO_DATE(InvoiceDate, '%d-%m-%Y %H:%i'),
 STR_TO_DATE(InvoiceDate, '%d-%m-%Y') 
 )
 )AS month_extracted
FROM sales;

#2.GROUP BY MONTH/YEAR
SELECT 
EXTRACT(YEAR FROM COALESCE (
 STR_TO_DATE(InvoiceDate, '%d-%m-%Y %H:%i'),
 STR_TO_DATE(InvoiceDate, '%d-%m-%Y') 
 ) 
 )AS year_extracted,
EXTRACT(MONTH FROM COALESCE(
 STR_TO_DATE(InvoiceDate, '%d-%m-%Y %H:%i'),
 STR_TO_DATE(InvoiceDate, '%d-%m-%Y') 
 )
 )AS month_extracted
FROM sales
GROUP BY year_extracted,month_extracted;

#3.COUNT DISTINCT COUSTOMER ID
SELECT 
COUNT(DISTINCT CustomerID) AS Unique_CustomerID
FROM sales;

#4.Order BY Sorting 
SELECT EXTRACT(MONTH FROM COALESCE(
STR_TO_DATE(InvoiceDate, '%d-%m-%Y %H:%i'),
STR_TO_DATE(InvoiceDate, '%d-%m-%Y')
))
AS month_extracted
FROM sales
ORDER BY month_extracted;

#5. LIMIT RESULTS FOR SPECIFIC TIME PERIODS
SELECT*FROM sales
WHERE EXTRACT(MONTH FROM COALESCE(
STR_TO_DATE(InvoiceDate, '%d-%m-%Y %H:%i'),
STR_TO_DATE(InvoiceDate, '%d-%m-%Y'))
)=12;





