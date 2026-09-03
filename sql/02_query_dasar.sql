-- ============================================================
-- 02_query_dasar.sql: Query Dasar, Filtering, Aliasing & Sorting
-- Belajar Data — SQL E-Commerce Indonesia (by Velora)
-- ============================================================

-- 1. Anatomi & Urutan Query: SELECT Dasar
SELECT produk_id, nama_produk, kategori_id, berat_gram
FROM produk
LIMIT 5;

-- 2. Penggunaan Kata Kunci AS (Column Alias, Kalkulasi & Table Alias)
SELECT 
    p.produk_id,
    p.nama_produk              AS nama_barang,
    p.berat_gram,
    p.berat_gram / 1000.0       AS berat_kg,
    p.berat_gram / 1000.0       AS "Berat Paket (Kg)"
FROM produk AS p
LIMIT 5;

-- 3. WHERE: Filter Pesanan Selesai dengan Nilai Tinggi
SELECT nomor_invoice, tanggal_pesanan, total_bayar, status_pesanan
FROM pesanan
WHERE status_pesanan = 'Selesai' 
  AND total_bayar >= 500000
ORDER BY total_bayar DESC 
LIMIT 5;

-- 4. DISTINCT: Menghapus Duplikasi Wilayah Pengiriman
SELECT DISTINCT kota, provinsi 
FROM alamat_pelanggan 
ORDER BY provinsi ASC, kota ASC;

-- 5. BETWEEN & IN: Filter Berdasarkan Rentang & Daftar Nilai
SELECT nomor_invoice, tanggal_pesanan, total_bayar, status_pesanan
FROM pesanan
WHERE status_pesanan IN ('Selesai', 'Diproses')
  AND total_bayar BETWEEN 200000 AND 1000000
ORDER BY tanggal_pesanan DESC
LIMIT 5;

-- 6. LIKE & Wildcard: Pencarian Produk
SELECT nama_produk, deskripsi 
FROM produk
WHERE nama_produk LIKE '%Samsung%' 
   OR nama_produk LIKE '%Wireless%'
LIMIT 5;