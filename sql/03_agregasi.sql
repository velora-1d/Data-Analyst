-- ============================================================
-- 03_agregasi.sql: Fungsi Agregasi & Metrik Bisnis E-Commerce
-- Fundamental Coding — SQL & Software Engineering (by Velora)
-- ============================================================

-- ============================================================
-- QUERY: 1. Ringkasan Metrik Finansial Global (COUNT, SUM, AVG, MIN, MAX)
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan fungsi agregasi (COUNT, SUM, AVG, MIN, MAX) untuk menghitung statistik data numerik dari kumpulan baris
-- • FROM     : Menentukan tabel mana yang menjadi sumber data
-- • WHERE    : Menyaring baris data berdasarkan kriteria tertentu sebelum fungsi agregasi dihitung
--
-- DIPAKAI KAPAN:
-- Ketika ingin mengetahui nilai ringkasan ringkas dari seluruh tabel, seperti jumlah total baris, total akumulasi nilai angka, rata-rata, nilai terkecil, dan nilai terbesar.
--
-- KASUS:
-- Menghitung total transaksi selesai, akumulasi total omzet, rata-rata nominal belanja, serta nilai belanja terendah dan tertinggi pada data pesanan.
-- ============================================================
SELECT 
    COUNT(*)                   AS total_transaksi, 
    SUM(total_bayar)           AS total_omzet,
    ROUND(AVG(total_bayar), 0) AS rata_rata_aov,
    MIN(total_bayar)           AS belanja_terendah, 
    MAX(total_bayar)           AS belanja_tertinggi
FROM pesanan 
WHERE status_pesanan = 'Selesai';

-- ============================================================
-- QUERY: 2. GROUP BY Tunggal: Rekap Omzet per Metode Pembayaran
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom dimensi yang ditampilkan beserta fungsi agregasi (COUNT, SUM) untuk setiap kelompok
-- • FROM     : Menentukan tabel utama yang menjadi sumber data
-- • JOIN     : Menggabungkan baris dari dua tabel berdasarkan relasi kunci primer dan asing
-- • WHERE    : Menyaring baris data sebelum data dikelompokkan atau dihitung
-- • GROUP BY : Mengelompokkan baris-baris data yang memiliki nilai yang sama menjadi satu kelompok baris
-- • ORDER BY : Mengurutkan baris data hasil kalkulasi dari nilai terbesar ke terkecil (DESC)
--
-- DIPAKAI KAPAN:
-- Ketika data perlu dirangkum berdasarkan satu kategori atau atribut spesifik untuk membandingkan performa antar kategori.
--
-- KASUS:
-- Menghitung jumlah pesanan selesai dan total perputaran omzet untuk setiap nama metode pembayaran yang digunakan pelanggan.
-- ============================================================
SELECT 
    mp.nama_metode,
    COUNT(p.pesanan_id) AS total_pesanan,
    SUM(p.total_bayar)  AS total_omzet
FROM pesanan p
JOIN metode_pembayaran mp ON p.metode_id = mp.metode_id
WHERE p.status_pesanan = 'Selesai'
GROUP BY mp.nama_metode
ORDER BY total_omzet DESC;

-- ============================================================
-- QUERY: 3. GROUP BY Multi-Kolom: Rekap Omzet per Status Pesanan dan Tipe Pembayaran
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom-kolom dimensi pengelompokan dan hasil agregasi kuantitas serta total nilai
-- • FROM     : Menentukan tabel utama sumber data
-- • JOIN     : Menggabungkan tabel pesanan dengan tabel metode pembayaran berdasarkan kolom relasi
-- • GROUP BY : Mengelompokkan baris-baris data yang memiliki kombinasi nilai yang sama pada beberapa kolom sekaligus
-- • ORDER BY : Mengurutkan hasil query bertingkat berdasarkan status pesanan secara alfabetis lalu nominal belanja secara menurun
--
-- DIPAKAI KAPAN:
-- Ketika analisis membutuhkan pemecahan data ke dalam matriks multidimensi (kombinasi dua atau lebih kategori).
--
-- KASUS:
-- Melihat persebaran jumlah transaksi dan total perputaran uang berdasarkan kombinasi status pesanan dan tipe instrumen pembayaran.
-- ============================================================
SELECT 
    p.status_pesanan,
    mp.tipe             AS tipe_pembayaran,
    COUNT(p.pesanan_id) AS jumlah_transaksi,
    SUM(p.total_bayar)  AS total_nominal
FROM pesanan p
JOIN metode_pembayaran mp ON p.metode_id = mp.metode_id
GROUP BY p.status_pesanan, mp.tipe
ORDER BY p.status_pesanan ASC, total_nominal DESC;

-- ============================================================
-- QUERY: 4. GROUP BY Waktu / STRFTIME: Tren Omzet dan Transaksi Bulanan Toko
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan ekspresi konversi format waktu (STRFTIME) dan fungsi kalkulasi ringkasan data (COUNT, SUM, AVG)
-- • FROM     : Menentukan tabel mana yang menjadi sumber data
-- • WHERE    : Menyaring baris data agar hanya memperhitungkan transaksi dengan status tertentu sebelum dikelompokkan
-- • GROUP BY : Mengelompokkan baris-baris data berdasarkan hasil evaluasi fungsi waktu (tahun dan bulan)
-- • ORDER BY : Mengurutkan baris data secara kronologis waktu dari periode terlama ke terbaru (ASC)
--
-- DIPAKAI KAPAN:
-- Ketika ingin menganalisis tren performa metrik dari waktu ke waktu (analisis deret waktu / time series harian, bulanan, atau tahunan).
--
-- KASUS:
-- Menghitung jumlah pesanan bulanan, total omzet per bulan, dan rata-rata nilai transaksi per bulan berdasarkan tanggal pesanan.
-- ============================================================
SELECT 
    STRFTIME('%Y-%m', tanggal_pesanan) AS periode_bulan,
    COUNT(pesanan_id)                  AS total_pesanan,
    SUM(total_bayar)                   AS total_omzet,
    ROUND(AVG(total_bayar), 0)         AS aov_bulanan
FROM pesanan
WHERE status_pesanan = 'Selesai'
GROUP BY STRFTIME('%Y-%m', tanggal_pesanan)
ORDER BY periode_bulan ASC;

-- ============================================================
-- QUERY: 5. GROUP BY dengan HAVING: Menyaring Kota dengan Transaksi Tinggi (>= 15 Pesanan)
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom dimensi lokasi serta hasil agregasi jumlah transaksi dan total belanja
-- • FROM     : Menentukan tabel transaksi utama yang menjadi sumber data
-- • JOIN     : Menggabungkan baris dari dua tabel berdasarkan relasi ID alamat
-- • WHERE    : Menyaring baris data individual sebelum baris-baris tersebut dikelompokkan
-- • GROUP BY : Mengelompokkan baris-baris data yang memiliki nilai kota yang sama menjadi satu kelompok baris
-- • HAVING   : Menyaring baris kelompok hasil pengelompokan berdasarkan kondisi nilai agregat (hanya kelompok dengan COUNT >= 15)
-- • ORDER BY : Mengurutkan baris data yang lolos saringan HAVING dari omzet terbesar ke terkecil
--
-- DIPAKAI KAPAN:
-- Ketika ingin memfilter data setelah proses agregasi selesai dihitung, karena klausa WHERE tidak dapat digunakan untuk memfilter fungsi agregasi.
--
-- KASUS:
-- Mengelompokkan data berdasarkan kota tujuan pengiriman dan hanya menampilkan kota yang memiliki akumulasi minimal 15 pesanan selesai.
-- ============================================================
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
-- QUERY: 6. GROUP BY dengan Kalkulasi Metrik: AOV dan Basket Size per Kategori Produk
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom nama kategori dan rumus kalkulasi pembagian antar fungsi agregasi (SUM / COUNT DISTINCT)
-- • FROM     : Menentukan tabel awal relasi data
-- • JOIN     : Menggabungkan baris data secara bertingkat melalui 6 tabel yang saling berelasi
-- • WHERE    : Menyaring baris data transaksi berdasarkan status sebelum dikelompokkan
-- • GROUP BY : Mengelompokkan baris-baris data berdasarkan identitas unik dan nama kategori produk
-- • ORDER BY : Mengurutkan baris kelompok hasil kalkulasi berdasarkan total omzet tertinggi
--
-- DIPAKAI KAPAN:
-- Ketika perlu menghasilkan metrik rasio turunan dari gabungan beberapa tabel dan fungsi agregat yang berbeda.
--
-- KASUS:
-- Menghitung total unit produk terjual, total omzet, rata-rata jumlah item per pesanan (basket size), dan nilai rata-rata belanja per kategori produk.
-- ============================================================
SELECT 
    k.nama_kategori,
    COUNT(DISTINCT p.pesanan_id)                                           AS total_transaksi,
    SUM(rp.jumlah)                                                         AS total_unit_terjual,
    SUM(rp.subtotal)                                                       AS total_omzet,
    ROUND(CAST(SUM(rp.jumlah) AS REAL) / COUNT(DISTINCT p.pesanan_id), 2)   AS rata_rata_basket_size,
    ROUND(CAST(SUM(rp.subtotal) AS REAL) / COUNT(DISTINCT p.pesanan_id), 0) AS aov_kategori
FROM kategori k
JOIN subkategori sk     ON k.kategori_id = sk.kategori_id
JOIN produk pr          ON sk.subkategori_id = pr.subkategori_id
JOIN variasi_produk vp  ON pr.produk_id = vp.produk_id
JOIN rincian_pesanan rp ON vp.variasi_id = rp.variasi_id
JOIN pesanan p          ON rp.pesanan_id = p.pesanan_id
WHERE p.status_pesanan = 'Selesai'
GROUP BY k.kategori_id, k.nama_kategori
ORDER BY total_omzet DESC;

-- ============================================================
-- QUERY: 7. GROUP BY dengan CASE WHEN: Menghitung Tingkat Keberhasilan (Success Rate) Transaksi per Channel
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom klasifikasi serta agregasi bersyarat menggunakan ekspresi CASE di dalam fungsi SUM untuk menghasilkan rasio persentase
-- • FROM     : Menentukan tabel utama pesanan sebagai sumber data
-- • JOIN     : Menggabungkan tabel pesanan dengan tabel referensi metode pembayaran
-- • GROUP BY : Mengelompokkan baris-baris data yang memiliki tipe channel pembayaran yang sama
-- • ORDER BY : Mengurutkan kelompok hasil agregasi berdasarkan total transaksi terbanyak
--
-- DIPAKAI KAPAN:
-- Ketika ingin menghitung jumlah baris yang memenuhi kondisi tertentu ke dalam kolom terpisah secara horizontal dalam satu kali query (pivoting / conditional aggregation).
--
-- KASUS:
-- Menghitung total transaksi, transaksi berhasil, transaksi batal, serta persentase rasio keberhasilan untuk setiap saluran pembayaran.
-- ============================================================
SELECT 
    mp.tipe                                                                                             AS channel_pembayaran,
    COUNT(p.pesanan_id)                                                                                 AS total_transaksi,
    SUM(CASE WHEN p.status_pesanan = 'Selesai' THEN 1 ELSE 0 END)                                       AS transaksi_berhasil,
    SUM(CASE WHEN p.status_pesanan = 'Dibatalkan' THEN 1 ELSE 0 END)                                     AS transaksi_batal,
    PRINTF('%.2f%%', (CAST(SUM(CASE WHEN p.status_pesanan = 'Selesai' THEN 1 ELSE 0 END) AS REAL) / COUNT(p.pesanan_id)) * 100) AS success_rate
FROM pesanan p
JOIN metode_pembayaran mp ON p.metode_id = mp.metode_id
GROUP BY mp.tipe
ORDER BY total_transaksi DESC;
