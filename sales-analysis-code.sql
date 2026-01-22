-- =====================================================
-- Question 1
-- Bulan dengan Total Sales Berhasil Tertinggi
-- =====================================================
SELECT
	strftime('%Y-%m',sales_date) as Month,
	SUM(total_sales) AS Total_Sales
FROM orders
WHERE status = 'Success'
GROUP BY Month
ORDER BY Total_Sales DESC

-- =====================================================
-- Question 2
-- Rasio Transaksi Failed per Bulan
-- =====================================================
SELECT 
	strftime('%Y-%m',sales_date) as Month,
	COUNT(
		CASE WHEN status = 'Failed' THEN 1  END)*1.0/COUNT (order_id) AS Failed_Ratio
FROM orders
GROUP BY Month
ORDER BY Failed_Ratio DESC


-- =====================================================
-- Question 3
-- Efesiensi Channel Berdasarkan Diskon
-- =====================================================
SELECT
    channel,
    SUM(discount) AS Total_Discount
FROM orders
WHERE status = 'Success'
GROUP BY channel
ORDER BY Total_Discount ASC


-- =====================================================
-- Question 4
-- Customer dengan Rata-rata Rating Terendah
-- =====================================================
SELECT
    customer_name,
    AVG(rating) AS AVG_Rating
FROM orders
GROUP BY customer_name
ORDER BY AVG_Rating ASC;



-- =====================================================
-- Question 5
--  Analisis Waktu Promosi Minyak Goreng
-- =====================================================
SELECT
    CASE
        WHEN strftime('%d', sales_date) = strftime('%m', sales_date)
             THEN 'Double Date'
        WHEN strftime('%d', sales_date) = '25'
             THEN 'Payday'
    END AS Tipe_Promosi,
    SUM(total_sales) AS TotalSales
FROM orders
WHERE
    status = 'Success'
    AND product_name = 'Minyak Goreng'
    AND (
        strftime('%d', sales_date) = strftime('%m', sales_date)
        OR strftime('%d', sales_date) = '25'
    )
GROUP BY Tipe_Promosi
ORDER BY Total_Sales DESC;

