-- 06_window_functions.sql: Window Functions
WITH CategorySales AS (
    SELECT k.nama_kategori, pr.nama_produk, SUM(rp.jumlah) AS total_terjual,
           DENSE_RANK() OVER (PARTITION BY k.kategori_id ORDER BY SUM(rp.jumlah) DESC) AS ranking
    FROM rincian_pesanan rp
    JOIN variasi_produk vp ON rp.variasi_id = vp.variasi_id
    JOIN produk pr ON vp.produk_id = pr.produk_id
    JOIN subkategori sk ON pr.subkategori_id = sk.subkategori_id
    JOIN kategori k ON sk.kategori_id = k.kategori_id
    GROUP BY pr.produk_id
)
SELECT * FROM CategorySales WHERE ranking <= 2 LIMIT 6;

WITH MonthlyRevenue AS (
    SELECT STRFTIME('%Y-%m', tanggal_pesanan) AS periode, SUM(total_bayar) AS omzet
    FROM pesanan WHERE status_pesanan = 'Selesai' GROUP BY periode
)
SELECT periode, omzet, LAG(omzet, 1) OVER (ORDER BY periode) AS omzet_bulan_lalu,
       ROUND((CAST(omzet - LAG(omzet, 1) OVER (ORDER BY periode) AS REAL) / LAG(omzet, 1) OVER (ORDER BY periode)) * 100, 1) AS mom_growth_percent
FROM MonthlyRevenue;