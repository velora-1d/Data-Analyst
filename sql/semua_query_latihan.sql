-- ============================================================
-- PANDUAN LENGKAP QUERY SQL E-COMMERCE INDONESIA (MODUL 1 - 7)
-- Buka file database: database/ecommerce.db di DB Browser for SQLite
-- ============================================================

-- ============================================================
-- MODUL 1: TIPE DATA & INSPEKSI SKEMA
-- ============================================================

-- 1.1 Cek Tipe Data Kolom di Tabel Pelanggan
PRAGMA table_info(pelanggan);

-- 1.2 Format String Teks: Nama Huruf Besar & Sensor No HP
SELECT 
    nama_lengkap,
    UPPER(nama_lengkap) AS nama_kapital,
    SUBSTR(no_hp, 1, 4) || '****' || SUBSTR(no_hp, -3) AS no_hp_sensor
FROM pelanggan
LIMIT 5;

-- 1.3 Perhitungan Finansial & Persentase Margin Laba (CAST & ROUND)
SELECT 
    sku,
    harga_modal,
    harga_jual,
    harga_jual - harga_modal AS profit_nominal,
    ROUND((CAST(harga_jual - harga_modal AS REAL) / harga_jual) * 100, 1) AS margin_persen
FROM variasi_produk
LIMIT 5;

-- 1.4 Ekstraksi Waktu DATETIME Pesanan
SELECT 
    nomor_invoice,
    tanggal_pesanan,
    STRFTIME('%Y-%m', tanggal_pesanan) AS tahun_bulan,
    STRFTIME('%H:%M', tanggal_pesanan) AS jam_menit
FROM pesanan
LIMIT 5;

-- 1.5 Penanganan Missing Value (COALESCE untuk Diskon)
SELECT 
    nomor_invoice,
    COALESCE(voucher_id, 0) AS voucher_id_aman,
    potongan_diskon,
    total_bayar
FROM pesanan
LIMIT 5;


-- ============================================================
-- MODUL 2: QUERY DASAR & FILTERING
-- ============================================================

-- 2.1 Filter Pesanan Selesai dengan Nilai Belanja Tertentu
SELECT 
    nomor_invoice,
    tanggal_pesanan,
    total_bayar,
    status_pesanan
FROM pesanan
WHERE status_pesanan = 'Selesai'
  AND total_bayar >= 500000
ORDER BY total_bayar DESC
LIMIT 5;

-- 2.2 Daftar Kota Unik Pelanggan
SELECT DISTINCT kota, provinsi
FROM alamat_pelanggan
ORDER BY provinsi ASC, kota ASC;

-- 2.3 Pencarian Produk dengan Wildcard (LIKE)
SELECT 
    nama_produk,
    deskripsi
FROM produk
WHERE nama_produk LIKE '%Samsung%'
   OR nama_produk LIKE '%Wireless%';


-- ============================================================
-- MODUL 3: FUNGSI AGREGASI & METRIK BISNIS
-- ============================================================

-- 3.1 Ringkasan Omzet Global & Rata-rata Belanja (AOV)
SELECT 
    COUNT(*) AS total_transaksi,
    SUM(total_bayar) AS total_omzet,
    ROUND(AVG(total_bayar), 0) AS rata_rata_aov,
    MIN(total_bayar) AS belanja_terendah,
    MAX(total_bayar) AS belanja_tertinggi
FROM pesanan
WHERE status_pesanan = 'Selesai';

-- 3.2 Total Transaksi & Omzet per Metode Pembayaran (GROUP BY)
SELECT 
    mp.nama_metode,
    mp.tipe,
    COUNT(p.pesanan_id) AS total_pesanan,
    SUM(p.total_bayar)  AS total_omzet
FROM pesanan p
JOIN metode_pembayaran mp ON p.metode_id = mp.metode_id
WHERE p.status_pesanan = 'Selesai'
GROUP BY mp.metode_id
ORDER BY total_omzet DESC;

-- 3.3 Kota dengan Transaksi Tinggi (HAVING)
SELECT 
    ap.kota,
    COUNT(p.pesanan_id) AS jumlah_pesanan,
    SUM(p.total_bayar)  AS total_omzet_kota
FROM pesanan p
JOIN alamat_pelanggan ap ON p.alamat_kirim_id = ap.alamat_id
WHERE p.status_pesanan = 'Selesai'
GROUP BY ap.kota
HAVING jumlah_pesanan >= 15
ORDER BY total_omzet_kota DESC;


-- ============================================================
-- MODUL 4: JOIN & RELASI MULTI-TABEL
-- ============================================================

-- 4.1 INNER JOIN: Katalog Produk Lengkap (4 Tabel)
SELECT 
    pr.nama_produk,
    m.nama_merek,
    k.nama_kategori,
    s.nama_supplier
FROM produk pr
JOIN merek m        ON pr.merek_id = m.merek_id
JOIN subkategori sk ON pr.subkategori_id = sk.subkategori_id
JOIN kategori k     ON sk.kategori_id = k.kategori_id
JOIN supplier s     ON pr.supplier_id = s.supplier_id
LIMIT 5;

-- 4.2 LEFT JOIN Anti-Join: Pelanggan yang Belum Pernah Belanja (Churn Detection)
SELECT 
    pl.pelanggan_id,
    pl.nama_lengkap,
    pl.email,
    pl.tanggal_daftar
FROM pelanggan pl
LEFT JOIN pesanan p ON pl.pelanggan_id = p.pelanggan_id
WHERE p.pesanan_id IS NULL
LIMIT 5;

-- 4.3 Rantai 6 Tabel Transaksi Belanja Utuh
SELECT 
    p.nomor_invoice,
    pl.nama_lengkap AS nama_pembeli,
    pr.nama_produk,
    vp.warna,
    rp.jumlah AS qty,
    rp.subtotal,
    ke.nama_kurir
FROM pesanan p
JOIN pelanggan pl        ON p.pelanggan_id = pl.pelanggan_id
JOIN rincian_pesanan rp  ON p.pesanan_id = rp.pesanan_id
JOIN variasi_produk vp   ON rp.variasi_id = vp.variasi_id
JOIN produk pr           ON vp.produk_id = pr.produk_id
JOIN kurir_ekspedisi ke  ON p.kurir_id = ke.kurir_id
LIMIT 5;


-- ============================================================
-- MODUL 5: SUBQUERY & CTE (WITH ... AS)
-- ============================================================

-- 5.1 Scalar Subquery: Transaksi di Atas Rata-rata Toko
SELECT 
    nomor_invoice,
    total_bayar
FROM pesanan
WHERE status_pesanan = 'Selesai'
  AND total_bayar > (SELECT AVG(total_bayar) FROM pesanan WHERE status_pesanan = 'Selesai')
LIMIT 5;

-- 5.2 CTE Segmentasi Spending Tier Pelanggan
WITH CustomerSpending AS (
    SELECT 
        pl.nama_lengkap,
        COUNT(p.pesanan_id) AS total_orders,
        SUM(p.total_bayar)  AS total_spent
    FROM pelanggan pl
    JOIN pesanan p ON pl.pelanggan_id = p.pelanggan_id
    WHERE p.status_pesanan = 'Selesai'
    GROUP BY pl.pelanggan_id
)
SELECT 
    nama_lengkap,
    total_orders,
    total_spent,
    CASE 
        WHEN total_spent >= 3000000 THEN 'Platinum VIP'
        WHEN total_spent >= 1500000 THEN 'Gold Member'
        ELSE 'Silver Member'
    END AS tier
FROM CustomerSpending
ORDER BY total_spent DESC
LIMIT 5;


-- ============================================================
-- MODUL 6: WINDOW FUNCTIONS & ANALISIS TREN
-- ============================================================

-- 6.1 DENSE_RANK: Top 2 Produk Terlaris di Tiap Kategori
WITH CategorySales AS (
    SELECT 
        k.nama_kategori,
        pr.nama_produk,
        SUM(rp.jumlah) AS total_terjual,
        DENSE_RANK() OVER (PARTITION BY k.kategori_id ORDER BY SUM(rp.jumlah) DESC) AS ranking
    FROM rincian_pesanan rp
    JOIN variasi_produk vp ON rp.variasi_id = vp.variasi_id
    JOIN produk pr         ON vp.produk_id = pr.produk_id
    JOIN subkategori sk    ON pr.subkategori_id = sk.subkategori_id
    JOIN kategori k        ON sk.kategori_id = k.kategori_id
    GROUP BY pr.produk_id
)
SELECT * FROM CategorySales WHERE ranking <= 2 LIMIT 6;

-- 6.2 LAG: Analisis Pertumbuhan Omzet Bulanan (MoM Growth)
WITH MonthlyRevenue AS (
    SELECT 
        STRFTIME('%Y-%m', tanggal_pesanan) AS periode,
        SUM(total_bayar) AS omzet
    FROM pesanan
    WHERE status_pesanan = 'Selesai'
    GROUP BY periode
)
SELECT 
    periode,
    omzet,
    LAG(omzet, 1) OVER (ORDER BY periode) AS omzet_bulan_lalu,
    ROUND((CAST(omzet - LAG(omzet, 1) OVER (ORDER BY periode) AS REAL) / LAG(omzet, 1) OVER (ORDER BY periode)) * 100, 1) AS mom_growth_percent
FROM MonthlyRevenue;


-- ============================================================
-- MODUL 7: CAPSTONE BISNIS (NET PROFIT & ROI PROMO)
-- ============================================================

-- 7.1 Laba Bersih Finansial Toko
SELECT 
    SUM(rp.subtotal) AS omzet_kotor,
    SUM(p.potongan_diskon) AS total_diskon,
    SUM(rp.jumlah * vp.harga_modal) AS total_hpp_modal,
    SUM(rp.subtotal) - SUM(p.potongan_diskon) - SUM(rp.jumlah * vp.harga_modal) AS laba_bersih,
    ROUND((CAST(SUM(rp.subtotal) - SUM(p.potongan_diskon) - SUM(rp.jumlah * vp.harga_modal) AS REAL) / SUM(rp.subtotal)) * 100, 2) AS profit_margin_percent
FROM pesanan p
JOIN rincian_pesanan rp ON p.pesanan_id = rp.pesanan_id
JOIN variasi_produk vp  ON rp.variasi_id = vp.variasi_id
WHERE p.status_pesanan = 'Selesai';
