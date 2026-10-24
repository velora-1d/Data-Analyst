-- ============================================================
-- PANDUAN LENGKAP QUERY SQL E-COMMERCE INDONESIA (MODUL 1 - 7)
-- Fundamental Coding — SQL & Software Engineering (by Velora)
-- Buka file database: database/ecommerce.db di DB Browser for SQLite / SQLite CLI
-- ============================================================

-- ============================================================
-- MODUL 1: TIPE DATA, STRING, CAST & INTEGRITAS DATA
-- ============================================================

-- ============================================================
-- QUERY: 1.1 PRAGMA table_info (Inspeksi Metadata Skema Tabel)
--
-- FUNGSI QUERY:
-- • PRAGMA       : Menjalankan perintah khusus mesin SQLite untuk memeriksa konfigurasi, skema, atau metadata database
-- • table_info() : Fungsi SQLite untuk membaca struktur definisi kolom, tipe data, status nullable, nilai default, dan primary key dari sebuah tabel
--
-- DIPAKAI KAPAN:
-- Digunakan pada tahap awal eksplorasi skema database untuk memastikan struktur kolom dan tipe data sebelum menyusun query atau integrasi data
--
-- KASUS:
-- Memeriksa tipe data, nullability, dan primary key pada kolom tabel pelanggan agar penulisan query berikutnya sesuai dengan skema
-- ============================================================
PRAGMA table_info(pelanggan);

-- ============================================================
-- QUERY: 1.2 Manipulasi Teks & Fungsi String (UPPER, LOWER, LENGTH, SUBSTR, ||, typeof)
--
-- FUNGSI QUERY:
-- • SELECT : Menentukan kolom atau ekspresi hasil manipulasi string yang ingin diambil dan ditampilkan
-- • UPPER  : Mengonversi seluruh karakter huruf dalam teks menjadi huruf kapital
-- • LOWER  : Mengonversi seluruh karakter huruf dalam teks menjadi huruf kecil
-- • LENGTH : Menghitung total jumlah karakter dalam suatu teks
-- • SUBSTR : Mengambil atau memotong sebagian karakter teks dari posisi indeks dan panjang tertentu
-- • ||     : Operator konkatenasi untuk menggabungkan dua atau lebih nilai teks menjadi satu rangkaian teks
-- • typeof : Mengembalikan nama tipe data fisik (storage class) dari suatu nilai atau kolom
-- • AS     : Memberikan nama alias sementara pada kolom hasil ekspresi
-- • FROM   : Menentukan tabel mana yang menjadi sumber data
-- • LIMIT  : Membatasi jumlah baris data yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Digunakan saat standardisasi format teks, pembersihan data string, penyamaran data sensitif (data masking), atau validasi tipe data kolom
--
-- KASUS:
-- Menampilkan nama pelanggan dalam huruf besar, email dalam huruf kecil, menghitung panjang karakter nama, serta menyamarkan nomor telepon demi privasi pengguna
-- ============================================================
SELECT 
    pelanggan_id,
    nama_lengkap,
    UPPER(nama_lengkap)                  AS nama_uppercase,
    LOWER(email)                         AS email_clean,
    LENGTH(nama_lengkap)                 AS panjang_karakter,
    SUBSTR(no_hp, 1, 4) || '-xxxx-xxxx' AS no_hp_masking,
    typeof(nama_lengkap)                 AS tipe_data
FROM pelanggan 
LIMIT 5;

-- ============================================================
-- QUERY: 1.3 Operasi Aritmetika Integer (Pengurangan & Aliasing)
--
-- FUNGSI QUERY:
-- • SELECT : Menentukan kolom dan ekspresi perhitungan matematika yang ingin diambil dan ditampilkan
-- • -      : Operator pengurangan aritmetika untuk menghitung selisih numerik antar nilai kolom
-- • AS     : Memberikan nama alias sementara pada kolom hasil kalkulasi
-- • FROM   : Menentukan tabel mana yang menjadi sumber data
-- • LIMIT  : Membatasi jumlah baris data yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Digunakan saat melakukan kalkulasi matematika langsung antar kolom numerik bertipe integer dalam sebuah baris data
--
-- KASUS:
-- Menghitung selisih nominal laba kotor (profit) dari harga jual dikurangi harga modal untuk tiap variasi produk
-- ============================================================
SELECT 
    sku, 
    harga_modal, 
    harga_jual, 
    harga_jual - harga_modal AS profit_nominal
FROM variasi_produk 
LIMIT 5;

-- ============================================================
-- QUERY: 1.4 Konversi Tipe Data & Format Pecahan (CAST & PRINTF)
--
-- FUNGSI QUERY:
-- • SELECT : Menentukan kolom dan ekspresi konversi tipe data yang ingin diambil dan ditampilkan
-- • CAST   : Mengonversi suatu nilai atau ekspresi dari satu tipe data ke tipe data lain
-- • -      : Operator pengurangan aritmetika untuk menghitung selisih numerik
-- • /      : Operator pembagian aritmetika untuk menghitung rasio antar dua nilai numerik
-- • *      : Operator perkalian aritmetika untuk mengalikan nilai numerik dengan faktor pengali
-- • PRINTF : Memformat angka atau teks ke pola tampilan tertentu, seperti penentuan digit desimal dan simbol persentase
-- • AS     : Memberikan nama alias sementara pada kolom hasil kalkulasi
-- • FROM   : Menentukan tabel mana yang menjadi sumber data
-- • LIMIT  : Membatasi jumlah baris data yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Digunakan pada pembagian bilangan bulat yang memerlukan hasil pecahan presisi tanpa pemotongan desimal, serta memformat tampilan rasio atau persentase
--
-- KASUS:
-- Menghitung persentase margin keuntungan per variasi produk dengan mengonversi selisih laba ke tipe data REAL agar pembagian menghasilkan desimal presisi
-- ============================================================
SELECT 
    sku,
    harga_modal,
    harga_jual,
    (harga_jual - harga_modal) AS profit_rp,
    PRINTF('%.2f%%', (CAST(harga_jual - harga_modal AS REAL) / harga_jual) * 100) AS profit_margin_percent
FROM variasi_produk
LIMIT 5;

-- ============================================================
-- QUERY: 1.5 Ekstraksi & Format Waktu (STRFTIME)
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom dan hasil pemformatan waktu yang ingin diambil dan ditampilkan
-- • STRFTIME : Mengekstrak dan memformat nilai tanggal/waktu (datetime) menjadi representasi string berdasarkan kode format penanggalan
-- • AS       : Memberikan nama alias sementara pada kolom hasil ekstraksi
-- • FROM     : Menentukan tabel mana yang menjadi sumber data
-- • LIMIT    : Membatasi jumlah baris data yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Digunakan saat perlu memecah, memformat, atau mengelompokkan data berdasarkan komponen waktu tertentu seperti tahun, bulan, hari, jam, atau menit
--
-- KASUS:
-- Mengekstrak komponen periode tahun-bulan (YYYY-MM) dan jam-menit (HH:MM) dari tanggal pesanan untuk analisis tren transaksi
-- ============================================================
SELECT 
    nomor_invoice, 
    tanggal_pesanan,
    STRFTIME('%Y-%m', tanggal_pesanan) AS tahun_bulan,
    STRFTIME('%H:%M', tanggal_pesanan) AS jam_menit
FROM pesanan 
LIMIT 5;

-- ============================================================
-- QUERY: 1.6 Penanganan Nilai NULL (CASE WHEN, IS NULL, COALESCE, IFNULL, NULLIF, ROUND)
--
-- FUNGSI QUERY:
-- • SELECT    : Menentukan kolom dan ekspresi logika penanganan nilai kosong yang ingin ditampilkan
-- • CASE WHEN : Mengevaluasi kondisi logika secara bersyarat dan mengembalikan nilai tertentu jika kondisi bernilai benar
-- • IS NULL   : Memeriksa apakah nilai suatu kolom kosong atau tidak terdefinisi (NULL)
-- • ELSE      : Menentukan nilai keluaran alternatif jika tidak ada kondisi yang terpenuhi pada ekspresi bersyarat
-- • END       : Menutup blok ekspresi logika bersyarat
-- • COALESCE  : Mengembalikan nilai non-NULL pertama dari daftar argumen yang diberikan
-- • IFNULL    : Fungsi khusus SQLite untuk mengganti nilai NULL dengan nilai pengganti default
-- • NULLIF    : Mengembalikan nilai NULL jika dua argumen bernilai sama untuk mencegah kesalahan pembagian dengan nol (division by zero)
-- • ROUND     : Membulatkan nilai angka desimal ke jumlah digit tertentu di belakang koma
-- • AS        : Memberikan nama alias sementara pada kolom hasil evaluasi logika
-- • FROM      : Menentukan tabel mana yang menjadi sumber data
-- • LIMIT     : Membatasi jumlah baris data yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Digunakan saat membersihkan data yang mengandung nilai kosong (NULL), mencegah error pembagian nol pada ekspresi matematika, serta mengkategorikan data secara bersyarat
--
-- KASUS:
-- Mengidentifikasi apakah pesanan menggunakan voucher atau tidak, mengganti nilai voucher yang kosong dengan angka 0, serta menghitung rasio rupiah per gram secara aman
-- ============================================================
SELECT 
    nomor_invoice, 
    total_bayar, 
    voucher_id,
    CASE 
        WHEN voucher_id IS NULL THEN 'Tanpa Voucher'
        ELSE 'Pakai Voucher'
    END AS status_diskon,
    COALESCE(voucher_id, 0) AS voucher_id_coalesce, 
    IFNULL(voucher_id, 0)   AS voucher_id_ifnull,
    ROUND(total_bayar / NULLIF(total_berat_gram, 0), 2) AS rupiah_per_gram
FROM pesanan 
LIMIT 5;

-- ============================================================
-- QUERY: 1.7 Deteksi Data Duplikat (GROUP BY, COUNT, HAVING)
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom yang dikelompokkan dan fungsi agregasi yang ingin diambil dan ditampilkan
-- • COUNT    : Menghitung total jumlah kemunculan baris data dalam satu kelompok
-- • AS       : Memberikan nama alias sementara pada kolom hasil perhitungan agregasi
-- • FROM     : Menentukan tabel mana yang menjadi sumber data
-- • GROUP BY : Mengelompokkan baris data yang bernilai sama menjadi satu kelompok baris
-- • HAVING   : Menyaring baris kelompok hasil agregasi berdasarkan kondisi logika tertentu setelah pengelompokan selesai
-- • >        : Operator pembanding lebih besar dari
--
-- DIPAKAI KAPAN:
-- Digunakan saat melakukan audit integritas data, validasi keunikan nilai kolom, atau menemukan data yang terduplikasi di dalam tabel
--
-- KASUS:
-- Mencari alamat email pelanggan yang terdaftar lebih dari satu kali untuk mendeteksi potensi duplikasi akun
-- ============================================================
SELECT 
    email,
    COUNT(*) AS total_kemunculan
FROM pelanggan
GROUP BY email
HAVING COUNT(*) > 1;

-- ============================================================
-- QUERY: 1.8 DDL — DROP TABLE, CREATE TABLE, ALTER TABLE
--
-- FUNGSI QUERY:
-- • DROP TABLE IF EXISTS : Menghapus objek tabel dari skema database secara permanen apabila tabel tersebut sudah ada
-- • CREATE TABLE         : Membuat struktur tabel baru di dalam database beserta spesifikasi kolom, tipe data, dan aturan batasan integritas (constraints)
-- • INTEGER PRIMARY KEY AUTOINCREMENT : Menetapkan kolom sebagai identitas unik utama yang nilainya bertambah secara otomatis untuk setiap baris baru
-- • VARCHAR / TEXT       : Menentukan kolom untuk menyimpan data teks atau rangkaian karakter
-- • REAL                 : Menentukan kolom untuk menyimpan angka pecahan desimal (floating point)
-- • NOT NULL             : Batasan integritas yang mewajibkan kolom selalu memiliki nilai (tidak boleh bernilai NULL)
-- • UNIQUE               : Batasan integritas yang memastikan seluruh nilai pada kolom tersebut tidak boleh ada yang sama (bebas duplikat)
-- • CHECK                : Batasan integritas yang memvalidasi bahwa nilai yang dimasukkan harus memenuhi ekspresi kondisi logika tertentu
-- • DEFAULT              : Menetapkan nilai bawaan otomatis pada kolom jika saat penyisipan data nilai tersebut tidak ditentukan
-- • ALTER TABLE          : Memodifikasi skema struktur tabel yang sudah ada di database
-- • ADD COLUMN           : Menambahkan kolom baru ke dalam struktur tabel yang sudah ada tanpa menghapus data di dalamnya
--
-- DIPAKAI KAPAN:
-- Digunakan saat merancang skema database baru, membuat tabel untuk modul fitur baru, atau mengubah struktur tabel yang sudah ada pada database
--
-- KASUS:
-- Membuat tabel master kategori promo baru dengan aturan integritas ketat (primary key, unique, check, default), lalu menambahkan kolom tanggal audit pembuatan
-- ============================================================
DROP TABLE IF EXISTS kategori_promo;

CREATE TABLE kategori_promo (
    kategori_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    nama_kategori VARCHAR(50) NOT NULL UNIQUE,
    diskon_pct    REAL DEFAULT 0.0,
    status_aktif  INTEGER CHECK (status_aktif IN (0, 1)) DEFAULT 1,
    catatan       TEXT
);

ALTER TABLE kategori_promo ADD COLUMN tanggal_dibuat DATETIME DEFAULT CURRENT_TIMESTAMP;

-- ============================================================
-- QUERY: 1.9 DML — INSERT INTO, UPDATE, DELETE FROM
--
-- FUNGSI QUERY:
-- • INSERT INTO : Menambahkan atau menyisipkan satu atau beberapa baris data baru ke dalam tabel yang ditentukan
-- • VALUES      : Menentukan nilai-nilai spesifik yang akan diisikan ke masing-masing kolom pada baris baru
-- • UPDATE      : Mengubah atau memperbarui nilai data pada baris yang sudah ada di dalam tabel
-- • SET         : Menentukan kolom mana saja yang akan diubah beserta nilai baru yang akan diterapkan
-- • WHERE       : Menyaring baris data spesifik mana yang akan dipengaruhi oleh operasi pembaruan (UPDATE) atau penghapusan (DELETE)
-- • =           : Operator pembanding kesetaraan nilai
-- • DELETE FROM : Menghapus baris data dari tabel berdasarkan kriteria penyaringan
--
-- DIPAKAI KAPAN:
-- Digunakan untuk operasi manipulasi data sehari-hari (tambah data baru, perbarui data lama, atau hapus data usang) dalam siklus operasional aplikasi
--
-- KASUS:
-- Menyisipkan dua data promosi baru, memperbarui besaran diskon promo flash sale, dan menghapus promo yang statusnya sudah tidak aktif
-- ============================================================
INSERT INTO kategori_promo (nama_kategori, diskon_pct, status_aktif)
VALUES 
    ('Flash Sale Payday', 25.5, 1),
    ('Diskon Ongkir Super', 10.0, 1);

UPDATE kategori_promo
SET diskon_pct = 30.0, catatan = 'Promo Khusus Tanggal Kembar'
WHERE nama_kategori = 'Flash Sale Payday';

DELETE FROM kategori_promo
WHERE status_aktif = 0;


-- ============================================================
-- MODUL 2: QUERY DASAR, FILTERING & SORTING
-- ============================================================

-- ============================================================
-- QUERY: 2.1 SELECT Kolom Spesifik (SELECT, FROM, LIMIT)
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
-- QUERY: 2.2 Aliasing & Kalkulasi Aritmetika (SELECT, AS, /, FROM, LIMIT)
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
-- QUERY: 2.3 Filter Bersyarat & Pengurutan (SELECT, FROM, WHERE, AND, ORDER BY, LIMIT)
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
-- QUERY: 2.4 Eliminasi Duplikasi Nilai (SELECT DISTINCT, FROM, ORDER BY)
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
-- QUERY: 2.5 Filter Himpunan & Rentang Nilai (SELECT, FROM, WHERE, IN, BETWEEN, AND, ORDER BY, LIMIT)
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
-- QUERY: 2.6 Pencarian Pola String (SELECT, FROM, WHERE, LIKE, OR, LIMIT)
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
-- QUERY: 2.7 GROUP BY Dasar (Pengelompokan Baris & Agregasi)
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


-- ============================================================
-- MODUL 3: FUNGSI AGREGASI & KLAUSA GROUP BY LENGKAP
-- ============================================================

-- ============================================================
-- QUERY: 3.1 Ringkasan Metrik Finansial Global (COUNT, SUM, AVG, MIN, MAX)
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
-- QUERY: 3.2 GROUP BY Tunggal: Rekap Omzet per Metode Pembayaran
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
-- QUERY: 3.3 GROUP BY Multi-Kolom: Rekap Omzet per Status Pesanan dan Tipe Pembayaran
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
-- QUERY: 3.4 GROUP BY Waktu / STRFTIME: Tren Omzet dan Transaksi Bulanan Toko
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
-- QUERY: 3.5 GROUP BY dengan HAVING: Menyaring Kota dengan Transaksi Tinggi (>= 15 Pesanan)
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
-- QUERY: 3.6 GROUP BY dengan Kalkulasi Metrik: AOV dan Basket Size per Kategori Produk
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
-- QUERY: 3.7 GROUP BY dengan CASE WHEN: Menghitung Tingkat Keberhasilan (Success Rate) Transaksi per Channel
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


-- ============================================================
-- MODUL 4: JOIN & RELASI MULTI-TABEL
-- ============================================================

-- ============================================================
-- QUERY: 4.1 INNER JOIN Multi-Tabel: Katalog Produk Lengkap (5 Tabel)
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom-kolom atribut spesifik yang ingin ditampilkan dari beberapa tabel yang berelasi
-- • FROM     : Menentukan tabel dasar yang menjadi titik awal penggabungan data
-- • JOIN     : Menggabungkan baris dari dua atau lebih tabel hanya jika terdapat nilai yang cocok pada kolom kondisi penghubung (ON)
-- • LIMIT    : Membatasi jumlah baris data yang dikembalikan pada hasil query
--
-- DIPAKAI KAPAN:
-- Ketika data yang dibutuhkan tersebar di beberapa tabel yang saling terhubung dan hanya baris yang memiliki pasangan data valid di seluruh tabel yang ingin ditampilkan.
--
-- KASUS:
-- Menggabungkan data katalog produk dengan tabel merek, subkategori, kategori induk, dan supplier untuk menampilkan informasi produk yang lengkap.
-- ============================================================
SELECT 
    pr.nama_produk, 
    m.nama_merek, 
    k.nama_kategori, 
    sk.nama_subkategori,
    s.nama_supplier
FROM produk pr
JOIN merek m        ON pr.merek_id = m.merek_id
JOIN subkategori sk ON pr.subkategori_id = sk.subkategori_id
JOIN kategori k     ON sk.kategori_id = k.kategori_id
JOIN supplier s     ON pr.supplier_id = s.supplier_id 
LIMIT 5;

-- ============================================================
-- QUERY: 4.2 LEFT JOIN Anti-Join: Pelanggan yang Belum Pernah Belanja (Zero Order / Inactive Leads)
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan atribut data identitas pelanggan yang ingin ditampilkan
-- • FROM     : Menentukan tabel kiri sebagai tabel acuan utama yang seluruh baris datanya tetap dipertahankan
-- • LEFT JOIN: Menggabungkan semua baris dari tabel kiri dengan baris yang cocok dari tabel kanan; jika tidak ada pasangan yang cocok, kolom tabel kanan akan berisi nilai NULL
-- • WHERE    : Menyaring baris hasil gabungan dengan kondisi nilai kolom tabel kanan IS NULL (teknik anti-join untuk menemukan data yang tidak berelasi)
-- • LIMIT    : Membatasi jumlah baris data yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Ketika ingin menemukan rekaman data pada suatu tabel yang sama sekali tidak memiliki riwayat atau catatan relasi di tabel lainnya.
--
-- KASUS:
-- Mencari daftar data pelanggan yang sudah terdaftar di sistem namun belum pernah membuat transaksi pesanan sama sekali.
-- ============================================================
SELECT 
    pl.pelanggan_id, 
    pl.nama_lengkap, 
    pl.email, 
    pl.tanggal_daftar
FROM pelanggan pl
LEFT JOIN pesanan p ON pl.pelanggan_id = p.pelanggan_id
WHERE p.pesanan_id IS NULL 
LIMIT 5;

-- ============================================================
-- QUERY: 4.3 Rantai Multi-Tabel Transaksi Belanja Utuh (6 Tabel)
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom atribut faktur, pembeli, produk, varian fisik, kuantitas, subtotal, dan nama kurir dengan penamaan alias
-- • FROM     : Menentukan tabel transaksi utama yang menjadi pusat relasi
-- • JOIN     : Menggabungkan baris-baris data dari 6 tabel berbeda secara berantai berdasarkan kesamaan nilai foreign key
-- • LIMIT    : Membatasi jumlah baris data transaksi yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Ketika ingin merekonstruksi satu entitas proses yang kompleks (seperti rincian faktur transaksi belanja) yang atributnya dinormalisasi ke berbagai tabel master.
--
-- KASUS:
-- Menampilkan rincian transaksi belanja lengkap beserta identitas pembeli, nama produk, varian warna, kuantitas barang, subtotal belanja, dan jasa ekspedisi pengiriman.
-- ============================================================
SELECT 
    p.nomor_invoice, 
    pl.nama_lengkap AS nama_pembeli, 
    pr.nama_produk, 
    vp.warna, 
    rp.jumlah       AS qty, 
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
-- QUERY: 4.4 Aggregate JOIN: Valuasi Nilai dan Volume Stok per Hub Gudang
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom lokasi gudang, penghitungan jumlah variasi unik (COUNT DISTINCT), total kuantitas stok (SUM), serta total estimasi nilai rupiah
-- • FROM     : Menentukan tabel gudang sebagai sumber data awal
-- • JOIN     : Menggabungkan tabel gudang dengan tabel perantara stok dan tabel variasi produk untuk mendapatkan harga modal
-- • GROUP BY : Mengelompokkan baris-baris data transaksi stok berdasarkan identitas unik gudang
-- • ORDER BY : Mengurutkan kelompok baris data hasil kalkulasi dari nilai total aset terbesar ke terkecil (DESC)
--
-- DIPAKAI KAPAN:
-- Ketika perlu menggabungkan beberapa tabel relasi sekaligus melakukan kalkulasi agregasi matematika pada kelompok entitas tertentu.
--
-- KASUS:
-- Menghitung total variasi produk tersimpan, total unit barang fisik, dan total estimasi valuasi nilai modal stok di masing-masing fasilitas gudang.
-- ============================================================
SELECT 
    g.nama_gudang,
    g.kota,
    COUNT(DISTINCT sg.variasi_id)        AS total_variasi_tersimpan,
    SUM(sg.jumlah_stok)                  AS total_unit_fisik,
    SUM(sg.jumlah_stok * vp.harga_modal) AS estimasi_nilai_aset_gudang
FROM gudang g
JOIN stok_gudang sg    ON g.gudang_id = sg.gudang_id
JOIN variasi_produk vp ON sg.variasi_id = vp.variasi_id
GROUP BY g.gudang_id
ORDER BY estimasi_nilai_aset_gudang DESC;


-- ============================================================
-- MODUL 5: SUBQUERY & COMMON TABLE EXPRESSIONS (CTE)
-- ============================================================

-- ============================================================
-- QUERY: 5.1 Scalar Subquery: Transaksi Bernilai di Atas Rata-rata Toko
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom nomor invoice dan total nominal bayar yang ingin ditampilkan
-- • FROM     : Menentukan tabel mana yang menjadi sumber data utama
-- • WHERE    : Menyaring baris data transaksi berdasarkan status dan membandingkan nilai kolom dengan hasil dari subquery skalar
-- • SUBQUERY : Menghitung satu nilai tunggal rata-rata (AVG) di dalam tanda kurung untuk digunakan sebagai batas pembanding dinamis
-- • LIMIT    : Membatasi jumlah baris data yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Ketika kriteria penyaringan data bergantung pada hasil kalkulasi agregasi yang nilainya tidak statis (dinamis dihitung dari data itu sendiri).
--
-- KASUS:
-- Mencari transaksi pesanan yang memiliki nilai total bayar lebih besar daripada nilai rata-rata keseluruhan pesanan selesai.
-- ============================================================
SELECT 
    nomor_invoice, 
    total_bayar
FROM pesanan
WHERE status_pesanan = 'Selesai' 
  AND total_bayar > (
      SELECT AVG(total_bayar) 
      FROM pesanan 
      WHERE status_pesanan = 'Selesai'
  )
LIMIT 5;

-- ============================================================
-- QUERY: 5.2 Correlated Subquery / EXISTS: Identifikasi Pembeli Kategori Unggulan
--
-- FUNGSI QUERY:
-- • SELECT             : Menentukan kolom atribut pelanggan yang ingin ditampilkan
-- • FROM               : Menentukan tabel luar (outer table) yang akan dievaluasi per barisnya
-- • WHERE              : Menyaring baris data berdasarkan kondisi logis keberadaan data
-- • EXISTS             : Operator logika yang mengembalikan nilai TRUE jika subquery menghasilkan minimal 1 baris data (berhenti mencari segera setelah data ditemukan)
-- • CORRELATED SUBQUERY: Subquery di dalam tanda kurung yang nilainya bergantung pada kolom dari baris tabel luar (pl.pelanggan_id) pada iterasi saat itu
-- • LIMIT              : Membatasi jumlah baris data yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Ketika ingin memfilter data pada tabel master berdasarkan keberadaan catatan transaksi spesifik di tabel anak tanpa menimbulkan penggandaan baris data akibat operasi JOIN.
--
-- KASUS:
-- Menemukan daftar pelanggan yang tercatat pernah membeli produk yang berada di bawah kategori 'Elektronik & Gadget'.
-- ============================================================
SELECT 
    pl.pelanggan_id,
    pl.nama_lengkap,
    pl.email
FROM pelanggan pl
WHERE EXISTS (
    SELECT 1 
    FROM pesanan p
    JOIN rincian_pesanan rp ON p.pesanan_id = rp.pesanan_id
    JOIN variasi_produk vp  ON rp.variasi_id = vp.variasi_id
    JOIN produk pr          ON vp.produk_id = pr.produk_id
    JOIN subkategori sk     ON pr.subkategori_id = sk.subkategori_id
    JOIN kategori k         ON sk.kategori_id = k.kategori_id
    WHERE p.pelanggan_id = pl.pelanggan_id
      AND k.nama_kategori = 'Elektronik & Gadget'
)
LIMIT 5;

-- ============================================================
-- QUERY: 5.3 CTE (Common Table Expression): Segmentasi Spending Tier & Loyalitas Pelanggan
--
-- FUNGSI QUERY:
-- • WITH/CTE : Membuat tabel sementara virtual (CustomerSpending) yang didefinisikan sebelum query utama dijalankan
-- • SELECT   : Mengambil data dari CTE dan menjalankan ekspresi pengkondisian CASE WHEN untuk menetapkan tier klasifikasi
-- • FROM     : Menentukan tabel sementara hasil bentukan CTE sebagai sumber data utama
-- • ORDER BY : Mengurutkan baris data berdasarkan nilai akumulasi belanja dari terbesar ke terkecil
-- • LIMIT    : Membatasi jumlah baris data yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Ketika alur analisis membutuhkan proses komputasi bertahap (agregasi awal terlebih dahulu, lalu hasil agregat tersebut diklasifikasikan dengan kondisi logika berikutnya) agar query rapi dan mudah dibaca.
--
-- KASUS:
-- Menghitung total order dan akumulasi belanja setiap pelanggan pada CTE, lalu menetapkan tingkat keanggotaan (Platinum VIP, Gold Member, Silver Member) berdasarkan batas nominal belanja.
-- ============================================================
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
-- QUERY: 5.4 Multi-CTE: Kontribusi Omzet Kategori terhadap Grand Total Penjualan Toko
--
-- FUNGSI QUERY:
-- • WITH/CTE   : Membuat beberapa tabel sementara sekaligus (TotalRevenue dan CategoryRevenue) yang dipisahkan dengan tanda koma
-- • SELECT     : Mengambil kolom nama kategori, omzet kelompok, grand total toko, dan menghitung persentase rasio kontribusi
-- • FROM       : Menentukan tabel sementara CategoryRevenue sebagai tabel utama
-- • CROSS JOIN : Menggabungkan setiap baris data dari tabel CategoryRevenue dengan baris tunggal nilai grand total dari tabel TotalRevenue
-- • ORDER BY   : Mengurutkan hasil analisis berdasarkan nilai omzet per kategori dari terbesar ke terkecil
--
-- DIPAKAI KAPAN:
-- Ketika perlu menghitung rasio perbandingan antara nilai agregat subkelompok dengan nilai total keseluruhan populasi data dalam satu kali eksekusi query.
--
-- KASUS:
-- Menghitung total omzet per kategori produk dan membandingkannya terhadap grand total omzet seluruh toko untuk mengetahui persentase kontribusi pendapatan tiap kategori.
-- ============================================================
WITH TotalRevenue AS (
    SELECT SUM(total_bayar) AS grand_total_omzet
    FROM pesanan
    WHERE status_pesanan = 'Selesai'
),
CategoryRevenue AS (
    SELECT 
        k.nama_kategori,
        SUM(rp.subtotal) AS omzet_kategori
    FROM kategori k
    JOIN subkategori sk     ON k.kategori_id = sk.kategori_id
    JOIN produk pr          ON sk.subkategori_id = pr.subkategori_id
    JOIN variasi_produk vp  ON pr.produk_id = vp.produk_id
    JOIN rincian_pesanan rp ON vp.variasi_id = rp.variasi_id
    JOIN pesanan p          ON rp.pesanan_id = p.pesanan_id
    WHERE p.status_pesanan = 'Selesai'
    GROUP BY k.kategori_id, k.nama_kategori
)
SELECT 
    cr.nama_kategori,
    cr.omzet_kategori,
    tr.grand_total_omzet,
    PRINTF('%.2f%%', (CAST(cr.omzet_kategori AS REAL) / tr.grand_total_omzet) * 100) AS kontribusi_persen
FROM CategoryRevenue cr
CROSS JOIN TotalRevenue tr
ORDER BY cr.omzet_kategori DESC;


-- ============================================================
-- MODUL 6: WINDOW FUNCTIONS & ANALISIS TREN LANJUTAN
-- ============================================================

-- ============================================================
-- QUERY: 6.1 DENSE_RANK: Peringkat Top Produk Terlaris di Tiap Kategori
--
-- FUNGSI QUERY:
-- • WITH/CTE          : Membuat tabel sementara (CategorySales) yang menampung agregasi penjualan dan hasil ranking jendela sebelum difilter
-- • DENSE_RANK() OVER : Fungsi window untuk memberikan peringkat berurutan tanpa jeda angka jika terdapat nilai yang kembar (contoh: 1, 2, 2, 3)
-- • PARTITION BY      : Membagi baris data kalkulasi window menjadi kelompok independen berdasarkan kolom kategori
-- • ORDER BY (di OVER): Menentukan urutan pemeringkatan di dalam partisi dari volume penjualan terbanyak ke tersedikit
-- • SELECT            : Mengambil atribut nama kategori, produk, total penjualan, dan nomor peringkat dari CTE
-- • FROM              : Menentukan tabel sementara CategorySales sebagai sumber data
-- • WHERE             : Menyaring baris data hasil kalkulasi window function agar hanya memunculkan peringkat 2 teratas (ranking <= 2)
-- • LIMIT             : Membatasi jumlah baris data yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Ketika ingin membuat pemeringkatan (ranking) data yang direset otomatis di setiap kelompok kategori tanpa menghilangkan detail baris individu.
--
-- KASUS:
-- Menentukan 2 produk dengan akumulasi kuantitas penjualan terlaris di setiap kategori produk e-commerce.
-- ============================================================
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
SELECT 
    nama_kategori,
    nama_produk,
    total_terjual,
    ranking
FROM CategorySales 
WHERE ranking <= 2 
LIMIT 6;

-- ============================================================
-- QUERY: 6.2 LAG: Analisis Pertumbuhan Pendapatan Bulanan (Month-over-Month / MoM Growth)
--
-- FUNGSI QUERY:
-- • WITH/CTE    : Membuat tabel sementara (MonthlyRevenue) untuk mengagregasikan total omzet per periode bulan
-- • LAG() OVER  : Fungsi window untuk mengambil nilai dari baris data sebelumnya pada partisi/urutan yang sama tanpa memerlukan self-join
-- • SELECT      : Menampilkan periode, nilai omzet saat ini, nilai omzet baris sebelumnya, serta kalkulasi laju pertumbuhan persentase
-- • FROM        : Menentukan tabel sementara MonthlyRevenue sebagai sumber data
-- • ORDER BY    : Diatur di dalam klausa OVER() untuk menjamin pembacaan baris data berjalan kronologis sesuai urutan periode waktu
--
-- DIPAKAI KAPAN:
-- Ketika ingin membandingkan nilai pada baris saat ini dengan nilai pada baris sebelumnya dalam deret data berurutan (analisis pertumbuhan periode ke periode).
--
-- KASUS:
-- Membandingkan perolehan omzet bulan berjalan terhadap omzet bulan sebelumnya untuk mengukur persentase pertumbuhan bulanan (MoM Growth).
-- ============================================================
WITH MonthlyRevenue AS (
    SELECT 
        STRFTIME('%Y-%m', tanggal_pesanan) AS periode, 
        SUM(total_bayar)                   AS omzet
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
-- QUERY: 6.3 SUM() OVER: Akumulasi Omzet Berjalan (Running Total / YTD Revenue)
--
-- FUNGSI QUERY:
-- • WITH/CTE     : Membuat tabel sementara (MonthlySales) yang menampung rekap omzet per bulan transaksi
-- • SUM() OVER   : Fungsi agregasi yang dijalankan sebagai window function untuk menghitung nilai akumulasi kumulatif berjalan dari baris awal hingga baris saat ini
-- • OVER (ORDER BY): Mengontrol arah urutan pertambahan nilai kalkulasi akumulasi berdasarkan urutan kronologis kolom periode
-- • SELECT       : Menampilkan periode bulan, omzet bulanan, dan kolom baru hasil perhitungan akumulasi berjalan
-- • FROM         : Menentukan tabel sementara MonthlySales sebagai sumber data
--
-- DIPAKAI KAPAN:
-- Ketika ingin memantau akumulasi data berjalan dari waktu ke waktu secara berkelanjutan tanpa perlu mengelompokkan ulang seluruh baris data.
--
-- KASUS:
-- Menghitung akumulasi nilai pendapatan omzet toko secara kumulatif dari bulan pertama hingga bulan berjalan (running total revenue).
-- ============================================================
WITH MonthlySales AS (
    SELECT 
        STRFTIME('%Y-%m', tanggal_pesanan) AS periode,
        SUM(total_bayar)                   AS omzet_bulanan
    FROM pesanan
    WHERE status_pesanan = 'Selesai'
    GROUP BY periode
)
SELECT 
    periode,
    omzet_bulanan,
    SUM(omzet_bulanan) OVER (ORDER BY periode ASC) AS kumulatif_omzet_berjalan
FROM MonthlySales;


-- ============================================================
-- MODUL 7: CAPSTONE ANALISIS BISNIS NYATA
-- ============================================================

-- ============================================================
-- QUERY: 7.1 Analisis Laba Bersih Finansial Toko (Net Profit & Profit Margin Percent)
--
-- FUNGSI QUERY:
-- • SELECT   : Menghitung fungsi agregasi kuantitatif (SUM omzet kotor, total potongan diskon, total HPP modal), kalkulasi operasi aritmetika laba bersih, dan rasio persentase margin laba
-- • FROM     : Menentukan tabel transaksi utama (pesanan) sebagai titik awal data
-- • JOIN     : Menggabungkan baris dari tabel pesanan, rincian pesanan, dan variasi produk untuk mencocokkan jumlah barang yang dibeli dengan harga modal masing-masing produk
-- • WHERE    : Menyaring baris data transaksi sebelum dihitung agar hanya menyertakan transaksi yang berstatus 'Selesai'
--
-- DIPAKAI KAPAN:
-- Ketika ingin menghitung profitabilitas nyata dari seluruh transaksi dengan mengurangkan biaya modal barang (HPP) dan potongan promosi dari total omzet.
--
-- KASUS:
-- Menghitung total omzet kotor, total subsidi diskon, total harga pokok penjualan (HPP), laba bersih riil, dan persentase margin keuntungan bersih pada seluruh pesanan yang sukses.
-- ============================================================
SELECT 
    SUM(rp.subtotal)                AS omzet_kotor, 
    SUM(p.potongan_diskon)          AS total_diskon,
    SUM(rp.jumlah * vp.harga_modal) AS total_hpp_modal,
    SUM(rp.subtotal) - SUM(p.potongan_diskon) - SUM(rp.jumlah * vp.harga_modal) AS laba_bersih,
    ROUND((CAST(SUM(rp.subtotal) - SUM(p.potongan_diskon) - SUM(rp.jumlah * vp.harga_modal) AS REAL) / SUM(rp.subtotal)) * 100, 2) AS profit_margin_percent
FROM pesanan p
JOIN rincian_pesanan rp ON p.pesanan_id = rp.pesanan_id
JOIN variasi_produk vp  ON rp.variasi_id = vp.variasi_id
WHERE p.status_pesanan = 'Selesai';

-- ============================================================
-- QUERY: 7.2 Evaluasi Efektivitas Campaign Voucher Promo (Promo Burn Rate & ROI)
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan fungsi substitusi nilai NULL (COALESCE), fungsi agregasi frekuensi penggunaan (COUNT), total omzet (SUM), total biaya potongan diskon (SUM), dan rasio persentase biaya promo terhadap omzet
-- • FROM     : Menentukan tabel pesanan sebagai tabel transaksi utama
-- • LEFT JOIN: Menggabungkan tabel pesanan dengan tabel referensi voucher promo sehingga pesanan yang tidak menggunakan voucher (NULL) tetap terhitung
-- • WHERE    : Menyaring transaksi agar hanya mencakup pesanan dengan status 'Selesai' sebelum proses pengelompokan
-- • GROUP BY : Mengelompokkan baris data transaksi berdasarkan ID voucher promo
-- • ORDER BY : Mengurutkan kelompok hasil analisis berdasarkan frekuensi jumlah pemakaian terbanyak (DESC)
--
-- DIPAKAI KAPAN:
-- Ketika mengevaluasi kinerja masing-masing kode promosi atau voucher diskon terhadap kontribusi omzet penjualan dan biaya beban diskon yang dikeluarkan.
--
-- KASUS:
-- Menganalisis frekuensi penggunaan voucher promo, total omzet yang dihasilkan, total biaya diskon yang diberikan, dan persentase rasio biaya promo per kode voucher (termasuk pesanan tanpa voucher).
-- ============================================================
SELECT 
    COALESCE(vp.kode_voucher, 'TANPA VOUCHER') AS kode_voucher,
    COALESCE(vp.tipe_diskon, '-')              AS tipe_diskon,
    COUNT(p.pesanan_id)                        AS jumlah_pemakaian,
    SUM(p.total_bayar)                         AS total_omzet_tercipta,
    SUM(p.potongan_diskon)                     AS total_subsidi_diskon,
    ROUND(CAST(SUM(p.potongan_diskon) AS REAL) / NULLIF(SUM(p.total_bayar), 0) * 100, 2) AS rasio_biaya_promo_pct
FROM pesanan p
LEFT JOIN voucher_promo vp ON p.voucher_id = vp.voucher_id
WHERE p.status_pesanan = 'Selesai'
GROUP BY vp.voucher_id
ORDER BY jumlah_pemakaian DESC;

-- ============================================================
-- QUERY: 7.3 Evaluasi Kinerja Logistik & Distribusi Beban Ongkos Kirim Kurir
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan atribut kurir (nama ekspedisi, layanan, tarif per kg) serta kalkulasi agregat volume paket (COUNT), total ongkos kirim (SUM), dan rata-rata berat kiriman dalam satuan kilogram (AVG)
-- • FROM     : Menentukan tabel transaksi pesanan sebagai sumber data utama
-- • JOIN     : Menggabungkan baris dari tabel pesanan dengan tabel master kurir ekspedisi berdasarkan kecocokan ID kurir
-- • WHERE    : Menyaring baris data transaksi transaksi yang berstatus 'Selesai'
-- • GROUP BY : Mengelompokkan baris-baris data pesanan berdasarkan ID kurir ekspedisi
-- • ORDER BY : Mengurutkan kelompok kurir berdasarkan total volume paket terkirim terbanyak (DESC)
--
-- DIPAKAI KAPAN:
-- Ketika ingin membandingkan performa volume pengiriman barang, perputaran biaya logistik, dan profil beban kiriman antar mitra jasa pengiriman barang.
--
-- KASUS:
-- Menghitung total paket yang berhasil dikirim, akumulasi perputaran ongkos kirim, dan rata-rata berat kiriman paket per mitra ekspedisi kurir.
-- ============================================================
SELECT 
    ke.nama_kurir,
    ke.layanan,
    ke.tarif_per_kg,
    COUNT(p.pesanan_id)                       AS total_paket_terkirim,
    SUM(p.ongkos_kirim)                       AS total_ongkir,
    ROUND(AVG(p.total_berat_gram) / 1000.0, 2) AS rata_rata_berat_kg
FROM pesanan p
JOIN kurir_ekspedisi ke ON p.kurir_id = ke.kurir_id
WHERE p.status_pesanan = 'Selesai'
GROUP BY ke.kurir_id
ORDER BY total_paket_terkirim DESC;
