# 📊 Sales Performance & Transaction Analysis (SQL)

## 📌 Project Overview
Project ini bertujuan untuk melakukan analisis data transaksi penjualan menggunakan **SQL (SQLite)** guna memperoleh insight terkait performa penjualan, tingkat keberhasilan transaksi, efektivitas channel penjualan, kepuasan pelanggan, serta efektivitas waktu promosi.  
Analisis dilakukan dengan pendekatan eksploratif dan analitis untuk mendukung pengambilan keputusan berbasis data.

## 🧠 Business Background
Dataset yang digunakan berisi data transaksi penjualan yang mencakup informasi produk, pelanggan, channel penjualan, status transaksi, diskon, tanggal transaksi, dan total nilai penjualan. Melalui analisis ini, diharapkan dapat diketahui periode penjualan terbaik, potensi masalah transaksi, serta strategi promosi dan channel yang paling efektif.

## 📂 Dataset Overview
- **Jenis data**: Data transaksi penjualan  
- **Jumlah baris**: ± 2000
- **Jumlah kolom**: 15
- **Database**: SQLite  
- **Tools**:
  - DB Browser for SQLite  
  - SQL

## 🎯 Problem Statements
1. Bulan apa yang memiliki **total penjualan tertinggi dari transaksi yang berhasil**?
2. Bulan apa yang memiliki **rasio transaksi gagal (Failed) paling tinggi**?
3. Channel penjualan mana yang memiliki **total diskon paling kecil namun tetap menghasilkan transaksi berhasil**?
4. Customer mana yang memberikan **rata-rata rating terendah**?
5. Untuk produk **Minyak Goreng**, waktu promosi mana yang lebih efektif berdasarkan **total sales transaksi berhasil**:  
   **Double Date (tanggal kembar)** atau **Payday (tanggal 25)**?

## 🧪 SQL Analysis & Queries
### 🔹 1. Bulan dengan Total Sales Berhasil Tertinggi
```sql
SELECT
	strftime('%Y-%m',sales_date) as Month,
	SUM(total_sales) AS Total_Sales
FROM orders
WHERE status = 'Success'
GROUP BY Month
ORDER BY Total_Sales DESC
```
**Insight :**

Berdasarkan hasil analisis transaksi dengan status Success, **bulan April 2025** tercatat sebagai bulan dengan **total penjualan tertinggi**, yaitu sebesar Rp20.258.250. Hal ini menunjukkan bahwa performa penjualan pada bulan tersebut lebih optimal dibandingkan bulan lainnya, yang dapat disebabkan oleh faktor promosi, perilaku konsumen, atau momen tertentu.

### 🔹 2. Rasio Transaksi Failed per Bulan
```sql
SELECT 
	strftime('%Y-%m',sales_date) as Month,
	COUNT(
		CASE WHEN status = 'Failed' THEN 1  END)*1.0/COUNT (order_id) AS Failed_Ratio
FROM orders
GROUP BY Month
ORDER BY Failed_Ratio DESC
```
**Insight :**

Rasio failed tertinggi terjadi di bulan **Juli 2025** dengan proporsi sekitar **26,7%**. Tingginya rasio kegagalan ini mengindikasi adanya potensi masalah operasional atau sistem transaksi yang perlu mendapat perhatian lebih lanjut. 

### 🔹 3. Efesiensi Channel Berdasarkan Diskon
```sql
SELECT
    channel,
    SUM(discount) AS Total_Discount
FROM orders
WHERE status = 'Success'
GROUP BY channel
ORDER BY Total_Discount ASC
```
**Insight :**

Channel **Online – Toko Hijau** memiliki total diskon paling rendah, yaitu sebesar **14,55**, dibandingkan channel lainnya. Hal ini menunjukkan bahwa channel tersebut mampu menghasilkan transaksi berhasil dengan biaya diskon yang lebih efisien, sehingga berpotensi memberikan margin keuntungan yang lebih baik.

### 🔹 4. Customer dengan Rata-rata Rating Terendah
```sql
SELECT
    customer_name,
    AVG(rating) AS AVG_Rating
FROM orders
GROUP BY customer_name
ORDER BY AVG_Rating ASC;
```
**Insight :**
Customer **Jamil** memiliki rata-rata **rating terendah (±2,66)**, yang mengindikasikan tingkat kepuasan pelanggan yang rendah, sehingga perlu dilakukan evaluasi lebaih lanjut tehadap pengalaman transaksi atau kualitas layanan yang diterima.


### 🔹 5. Analisis Waktu Promosi Minyak Goreng
```sql
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
```
**Insight :**

Total penjualan Minyak Goreng **lebih tinggi pada periode Payday** dibandingkan Double Date, menunjukkan bahwa momen gajian lebih efektif untuk meningkatkan penjualan produk kebutuhan pokok.

## 📈 Key Insights Summary
1. **Penjualan bersifat musiman**, dengan perbedaan total sales yang cukup signifikan antar bulan.
2. **Bulan Juli memiliki rasio transaksi gagal tertinggi**, mengindikasikan potensi isu operasional atau sistem pada periode tersebut.
3. **Channel Online – Toko Hijau** mencatat total diskon paling rendah dengan transaksi berhasil, menunjukkan efisiensi promosi yang lebih baik.
4. **Tingkat kepuasan pelanggan bervariasi**, ditunjukkan oleh perbedaan rata-rata rating antar customer.
5. **Periode Payday menghasilkan total sales Minyak Goreng lebih tinggi dibandingkan Double Date**, sehingga lebih efektif untuk strategi promosi produk tersebut.

## 💡 Business Recommendations
1. **Manfaatkan pola musiman penjualan** untuk merencanakan stok dan kampanya marketing agar distribusi produk lebih optimal di sepanjang tahun.
2. **Lakukan evaluasi operasional pada bulan dengan transaksi gagal tertinggi (Juli)**, dengan fokus pada sistem pembayaran, stok, dan peroses pengiriman untuk menekan tingkat kegagalan transaksi.
3. **Prioritaskan channel yang lebih efisien**, seperti Online – Toko Hijau, sebagai channel utama dalam kampanye penjualan karena mampu menghasilkan transaksi berhasil dengan diskon yang lebih rendah.
4. **Tingkatkan kualitas layanan dan pengalaman pelanggan**, terutama pada segmen customer dengan rata-rata rating rendah, melalui perbaikan proses transaksi dan layanan purna jual.
5. **Optimalkan strategi promosi pada periode Payday**, khususnya untuk produk kebutuhan pokok seperti Minyak Goreng, karena terbukti menghasilkan total sales yang lebih tinggi dibandingkan periode Double Date.

## 📌 Informasi Project
- **Jenis Project:** Learning Project  
- **Kursus/Konteks:** KarirNext Data Analysis Bootcamp 
- **Tanggal Project:** Rabu, 21 Januari 2026 
- **Author:** Della Dwi Saputri  
