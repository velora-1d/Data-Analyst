-- 02_query_dasar.sql: Query Dasar & Filter
SELECT nomor_invoice, tanggal_pesanan, total_bayar, status_pesanan
FROM pesanan
WHERE status_pesanan = 'Selesai' AND total_bayar >= 500000
ORDER BY total_bayar DESC LIMIT 5;

SELECT DISTINCT kota, provinsi FROM alamat_pelanggan ORDER BY provinsi ASC, kota ASC;

SELECT nama_produk, deskripsi FROM produk
WHERE nama_produk LIKE '%Samsung%' OR nama_produk LIKE '%Wireless%';