-- ============================================================
-- 01_tipe_data.sql: Tipe Data SQL, Manipulasi Text, CAST, DDL & DML
-- Fundamental Coding — SQL & Software Engineering (by Velora)
-- ============================================================

-- ============================================================
-- QUERY: PRAGMA table_info (Inspeksi Metadata Skema Tabel)
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
-- QUERY: Manipulasi Teks & Fungsi String (UPPER, LOWER, LENGTH, SUBSTR, ||, typeof)
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
-- QUERY: Operasi Aritmetika Integer (Pengurangan & Aliasing)
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
-- QUERY: Konversi Tipe Data & Format Pecahan (CAST & PRINTF)
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
-- QUERY: Ekstraksi & Format Waktu (STRFTIME)
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
-- QUERY: Penanganan Nilai NULL (CASE WHEN, IS NULL, COALESCE, IFNULL, NULLIF, ROUND)
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
    -- Klasifikasi dengan IS NULL
    CASE 
        WHEN voucher_id IS NULL THEN 'Tanpa Voucher'
        ELSE 'Pakai Voucher'
    END AS status_diskon,
    -- Imputasi nilai NULL dengan COALESCE dan IFNULL
    COALESCE(voucher_id, 0) AS voucher_id_coalesce, 
    IFNULL(voucher_id, 0)   AS voucher_id_ifnull,
    -- Cegah error pembagian nol dengan NULLIF
    ROUND(total_bayar / NULLIF(total_berat_gram, 0), 2) AS rupiah_per_gram
FROM pesanan 
LIMIT 5;

-- ============================================================
-- QUERY: Deteksi Data Duplikat (GROUP BY, COUNT, HAVING)
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
-- QUERY: DDL — DROP TABLE, CREATE TABLE, ALTER TABLE
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

-- Menambah kolom timestamp audit trail
ALTER TABLE kategori_promo ADD COLUMN tanggal_dibuat DATETIME DEFAULT CURRENT_TIMESTAMP;

-- ============================================================
-- QUERY: DML — INSERT INTO, UPDATE, DELETE FROM
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
-- INSERT: Menambah data promo baru
INSERT INTO kategori_promo (nama_kategori, diskon_pct, status_aktif)
VALUES 
    ('Flash Sale Payday', 25.5, 1),
    ('Diskon Ongkir Super', 10.0, 1);

-- UPDATE: Memperbarui besaran diskon promo
UPDATE kategori_promo
SET diskon_pct = 30.0, catatan = 'Promo Khusus Tanggal Kembar'
WHERE nama_kategori = 'Flash Sale Payday';

-- DELETE: Menghapus data promo yang sudah tidak aktif
DELETE FROM kategori_promo
WHERE status_aktif = 0;
