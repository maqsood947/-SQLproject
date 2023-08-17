SELECT * FROM project.`online retail`;
/* What is the distribution of order values across all customers in the dataset?*/
SELECT CustomerID, SUM(Quantity * UnitPrice) AS TotalOrderValue
FROM project.`online retail`
GROUP BY CustomerID
ORDER BY TotalOrderValue DESC;
/*·        How many unique products has each customer purchased?*/
SELECT CustomerID, COUNT(DISTINCT StockCode) AS UniqueProducts
FROM project.`online retail`
GROUP BY CustomerID;
/*  Which customers have only made a single purchase from the company?*/
SELECT CustomerID
FROM project.`online retail`
GROUP BY CustomerID
HAVING COUNT(DISTINCT InvoiceNo) = 1;
/* Which products are most commonly purchased together by customers in the dataset?*/
SELECT A.StockCode AS ProductA, B.StockCode AS ProductB, COUNT(*) AS PurchaseCount
FROM project.`online retail` A
JOIN project.`online retail` B ON A.InvoiceNo = B.InvoiceNo AND A.StockCode < B.StockCode
GROUP BY ProductA, ProductB
ORDER BY PurchaseCount DESC
LIMIT 10;
/*  ADVANCE QUERIES ?*/
/*  Customer Segmentation by Purchase Frequency ?*/
SELECT CustomerID,
    CASE
        WHEN COUNT(DISTINCT InvoiceNo) > 50 THEN 'High Frequency'
        WHEN COUNT(DISTINCT InvoiceNo) > 10 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS PurchaseFrequencySegment
FROM project.`online retail`
GROUP BY CustomerID;
/*  Average Order Value by Country ?*/
SELECT Country, AVG(Quantity * UnitPrice) AS AvgOrderValue
FROM project.`online retail`
GROUP BY Country;
/* Customer Churn Analysis ?*/
SELECT CustomerID
FROM  project.`online retail`
WHERE InvoiceDate < DATE_SUB(NOW(), INTERVAL 6 MONTH)
GROUP BY CustomerID;
/* Product Affinity Analysis*/

SELECT A.Description AS ProductA, B.Description AS ProductB, COUNT(*) AS Occurrences
FROM project.`online retail` A
JOIN project.`online retail` B ON A.InvoiceNo = B.InvoiceNo AND A.StockCode < B.StockCode
GROUP BY A.Description, B.Description
HAVING Occurrences > 10
ORDER BY Occurrences DESC;

/* Time-based Analysis*/
SELECT YEAR(InvoiceDate) AS Year, MONTH(InvoiceDate) AS Month, SUM(Quantity * UnitPrice) AS TotalSales
FROM project.`online retail`
GROUP BY Year, Month;

