-- 03_agregasi.sql: Agregasi & Metrik Bisnis
SELECT COUNT(*) AS total_transaksi, SUM(total_bayar) AS total_omzet,
       ROUND(AVG(total_bayar), 0) AS rata_rata_aov,
       MIN(total_bayar) AS belanja_terendah, MAX(total_bayar) AS belanja_tertinggi
FROM pesanan WHERE status_pesanan = 'Selesai';

SELECT mp.nama_metode, mp.tipe, COUNT(p.pesanan_id) AS total_pesanan, SUM(p.total_bayar) AS total_omzet
FROM pesanan p
JOIN metode_pembayaran mp ON p.metode_id = mp.metode_id
WHERE p.status_pesanan = 'Selesai'
GROUP BY mp.metode_id ORDER BY total_omzet DESC;

SELECT ap.kota, COUNT(p.pesanan_id) AS jumlah_pesanan, SUM(p.total_bayar) AS total_omzet_kota
FROM pesanan p
JOIN alamat_pelanggan ap ON p.alamat_kirim_id = ap.alamat_id
WHERE p.status_pesanan = 'Selesai'
GROUP BY ap.kota HAVING jumlah_pesanan >= 15 ORDER BY total_omzet_kota DESC;