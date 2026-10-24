-- ============================================================
-- 02_query_dasar.sql: Query Dasar, Filtering, Aliasing & Sorting
-- Fundamental Coding — SQL & Software Engineering (by Velora)
-- ============================================================

-- ============================================================
-- QUERY: SELECT Kolom Spesifik (SELECT, FROM, LIMIT)
--
-- FUNGSI QUERY:
-- • SELECT : Menentukan kolom mana saja yang ingin diambil dan ditampilkan dari tabel
-- • FROM   : Menentukan tabel mana yang menjadi sumber data
-- • LIMIT  : Membatasi jumlah baris data yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Digunakan saat mengambil data dengan memilih atribut kolom yang relevan secara efisien tanpa harus menarik seluruh kolom tabel
--
-- KASUS:
-- Menampilkan katalog produk dengan hanya mengambil ID produk, nama produk, ID subkategori, dan berat barang
-- ============================================================
SELECT 
    produk_id, 
    nama_produk, 
    subkategori_id, 
    berat_gram
FROM produk
LIMIT 5;

-- ============================================================
-- QUERY: Aliasing & Kalkulasi Aritmetika (SELECT, AS, /, FROM, LIMIT)
--
-- FUNGSI QUERY:
-- • SELECT : Menentukan kolom dan ekspresi matematika yang ingin diambil dan ditampilkan
-- • AS     : Memberikan nama alias sementara pada kolom atau tabel agar lebih komunikatif dan ringkas
-- • /      : Operator pembagian aritmetika untuk membagi nilai suatu kolom dengan faktor pembagi
-- • FROM   : Menentukan tabel mana yang menjadi sumber data
-- • LIMIT  : Membatasi jumlah baris data yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Digunakan saat memberikan label output yang lebih jelas, menyederhanakan penulisan nama tabel panjang, serta melakukan konversi satuan nilai secara langsung
--
-- KASUS:
-- Menampilkan nama produk dengan alias nama_barang serta mengonversi berat produk dari satuan gram ke kilogram (dibagi 1000.0)
-- ============================================================
SELECT 
    p.produk_id,
    p.nama_produk              AS nama_barang,
    p.berat_gram,
    p.berat_gram / 1000.0      AS berat_kg,
    p.berat_gram / 1000.0      AS berat_paket_kg
FROM produk AS p
LIMIT 5;

-- ============================================================
-- QUERY: Filter Bersyarat & Pengurutan (SELECT, FROM, WHERE, AND, ORDER BY, LIMIT)
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom mana saja yang ingin diambil dan ditampilkan
-- • FROM     : Menentukan tabel mana yang menjadi sumber data
-- • WHERE    : Menyaring baris data berdasarkan kondisi kriteria tertentu
-- • =        : Operator pembanding kesetaraan nilai
-- • >=       : Operator pembanding lebih besar dari atau sama dengan
-- • AND      : Operator logika yang menggabungkan dua atau lebih kondisi, di mana seluruh kondisi harus bernilai benar
-- • ORDER BY : Mengurutkan baris data yang ditampilkan
-- • DESC     : Menentukan arah pengurutan data secara menurun (dari nilai terbesar ke terkecil)
-- • LIMIT    : Membatasi jumlah baris data yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Digunakan saat menyaring data berdasarkan kriteria nilai tertentu dan menyajikannya secara terurut dari nilai tertinggi ke terendah atau sebaliknya
--
-- KASUS:
-- Mencari transaksi pesanan yang berstatus 'Selesai' dengan total bayar minimal Rp 500.000, diurutkan dari nilai belanja terbesar
-- ============================================================
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

-- ============================================================
-- QUERY: Eliminasi Duplikasi Nilai (SELECT DISTINCT, FROM, ORDER BY)
--
-- FUNGSI QUERY:
-- • SELECT DISTINCT : Mengambil data dengan menghilangkan baris duplikat sehingga hanya menampilkan nilai unik
-- • FROM            : Menentukan tabel mana yang menjadi sumber data
-- • ORDER BY        : Mengurutkan baris data yang ditampilkan
-- • ASC             : Menentukan arah pengurutan data secara menaik (dari A ke Z atau nilai terkecil ke terbesar)
--
-- DIPAKAI KAPAN:
-- Digunakan untuk mengetahui daftar nilai unik tanpa perulangan data ganda pada satu atau kombinasi beberapa kolom
--
-- KASUS:
-- Menampilkan daftar unik kombinasi kota dan provinsi tujuan pengiriman secara berurutan alfabetis tanpa ada kota yang terulang
-- ============================================================
SELECT DISTINCT 
    kota, 
    provinsi 
FROM alamat_pelanggan 
ORDER BY provinsi ASC, kota ASC;

-- ============================================================
-- QUERY: Filter Himpunan & Rentang Nilai (SELECT, FROM, WHERE, IN, BETWEEN, AND, ORDER BY, LIMIT)
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom mana saja yang ingin diambil dan ditampilkan
-- • FROM     : Menentukan tabel mana yang menjadi sumber data
-- • WHERE    : Menyaring baris data berdasarkan kondisi tertentu
-- • IN       : Menyaring data yang nilainya cocok dengan salah satu anggota di dalam daftar himpunan nilai
-- • BETWEEN  : Menyaring data yang nilainya berada di dalam rentang batas bawah dan batas atas (inklusif)
-- • AND      : Menggabungkan beberapa kondisi penyaringan agar seluruh kriteria harus terpenuhi
-- • ORDER BY : Mengurutkan baris data yang ditampilkan
-- • DESC     : Menentukan arah pengurutan data secara menurun (dari data terbaru atau terbesar)
-- • LIMIT    : Membatasi jumlah baris data yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Digunakan untuk menyaring data yang berada dalam daftar pilihan diskrit tertentu atau berada dalam rentang angka/tanggal tertentu secara ringkas
--
-- KASUS:
-- Mencari transaksi pesanan yang statusnya berada dalam pilihan ('Selesai', 'Diproses') dan nominal total bayar antara Rp 200.000 hingga Rp 1.000.000, diurutkan dari transaksi terbaru
-- ============================================================
SELECT 
    nomor_invoice, 
    tanggal_pesanan, 
    total_bayar, 
    status_pesanan
FROM pesanan
WHERE status_pesanan IN ('Selesai', 'Diproses')
  AND total_bayar BETWEEN 200000 AND 1000000
ORDER BY tanggal_pesanan DESC
LIMIT 5;

-- ============================================================
-- QUERY: Pencarian Pola String (SELECT, FROM, WHERE, LIKE, OR, LIMIT)
--
-- FUNGSI QUERY:
-- • SELECT : Menentukan kolom mana saja yang ingin diambil dan ditampilkan
-- • FROM   : Menentukan tabel mana yang menjadi sumber data
-- • WHERE  : Menyaring baris data berdasarkan kondisi tertentu
-- • LIKE   : Mencocokkan nilai teks berdasarkan pola string tertentu menggunakan karakter pengganti (wildcard)
-- • %      : Karakter wildcard yang mewakili nol, satu, atau banyak karakter sembarang
-- • OR     : Operator logika yang menghasilkan benar jika salah satu dari beberapa kondisi terpenuhi
-- • LIMIT  : Membatasi jumlah baris data yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Digunakan untuk mencari data teks yang mengandung kata, awalan, atau akhiran tertentu tanpa harus cocok persis secara keseluruhan
--
-- KASUS:
-- Mencari produk yang pada nama produknya memuat kata 'Samsung' atau kata 'Wireless'
-- ============================================================
SELECT 
    nama_produk, 
    deskripsi 
FROM produk
WHERE nama_produk LIKE '%Samsung%' 
   OR nama_produk LIKE '%Wireless%'
LIMIT 5;

-- ============================================================
-- QUERY: GROUP BY Dasar (Pengelompokan Baris & Agregasi)
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom pengelompokan dan ekspresi fungsi agregasi yang ingin diambil dan ditampilkan
-- • COUNT    : Menghitung total jumlah baris data di dalam setiap kelompok baris
-- • AS       : Memberikan nama alias sementara pada kolom hasil perhitungan fungsi agregasi
-- • FROM     : Menentukan tabel mana yang menjadi sumber data
-- • GROUP BY : Mengelompokkan baris data yang bernilai sama menjadi satu kelompok baris
-- • ORDER BY : Mengurutkan baris data yang ditampilkan
-- • DESC     : Menentukan arah pengurutan data secara menurun (dari nilai agregasi terbesar ke terkecil)
--
-- DIPAKAI KAPAN:
-- Digunakan untuk meringkas sekumpulan baris data menjadi kelompok-kelompok baris berdasarkan kesamaan nilai kolom, lalu menghitung total frekuensi, kalkulasi nilai, atau ringkasan per kelompok
--
-- KASUS:
-- Mengelompokkan pesanan berdasarkan status pesanan dan menghitung total jumlah transaksi di masing-masing status, diurutkan dari volume transaksi terbanyak
-- ============================================================
SELECT 
    status_pesanan, 
    COUNT(*) AS total_pesanan
FROM pesanan
GROUP BY status_pesanan
ORDER BY total_pesanan DESC;
