-- 05_subquery_cte.sql: Subquery & CTE
SELECT nomor_invoice, total_bayar
FROM pesanan
WHERE status_pesanan = 'Selesai' AND total_bayar > (SELECT AVG(total_bayar) FROM pesanan WHERE status_pesanan = 'Selesai')
LIMIT 5;

WITH CustomerSpending AS (
    SELECT pl.nama_lengkap, COUNT(p.pesanan_id) AS total_orders, SUM(p.total_bayar) AS total_spent
    FROM pelanggan pl
    JOIN pesanan p ON pl.pelanggan_id = p.pelanggan_id
    WHERE p.status_pesanan = 'Selesai'
    GROUP BY pl.pelanggan_id
)
SELECT nama_lengkap, total_orders, total_spent,
       CASE WHEN total_spent >= 3000000 THEN 'Platinum VIP' WHEN total_spent >= 1500000 THEN 'Gold Member' ELSE 'Silver Member' END AS tier
FROM CustomerSpending ORDER BY total_spent DESC LIMIT 5;