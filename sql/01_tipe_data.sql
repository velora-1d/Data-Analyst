-- ============================================================
-- 01_tipe_data.sql: Tipe Data SQL, Manipulasi Text, CAST, DDL & DML
-- Belajar Data — SQL E-Commerce Indonesia (by Velora)
-- ============================================================

-- 1. Inspeksi Skema Tabel PRAGMA
PRAGMA table_info(pelanggan);

-- 2. Manipulasi Teks & Data Masking (Privasi Data PII)
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

-- 3. Kalkulasi Integer Finansial Rupiah
SELECT 
    sku, 
    harga_modal, 
    harga_jual, 
    harga_jual - harga_modal AS profit_nominal
FROM variasi_produk 
LIMIT 5;

-- 4. Tipe REAL & Type Casting (CAST)
SELECT 
    sku,
    harga_modal,
    harga_jual,
    (harga_jual - harga_modal) AS profit_rp,
    PRINTF('%.2f%%', (CAST(harga_jual - harga_modal AS REAL) / harga_jual) * 100) AS profit_margin_percent
FROM variasi_produk
LIMIT 5;

-- 5. Format Tanggal ISO-8601
SELECT 
    nomor_invoice, 
    tanggal_pesanan,
    STRFTIME('%Y-%m', tanggal_pesanan) AS tahun_bulan,
    STRFTIME('%H:%M', tanggal_pesanan) AS jam_menit
FROM pesanan 
LIMIT 5;

-- 6. Penanganan NULL & COALESCE
SELECT 
    nomor_invoice, 
    COALESCE(voucher_id, 0) AS voucher_id_aman, 
    potongan_diskon, 
    total_bayar
FROM pesanan 
LIMIT 5;

-- ============================================================
-- 7. DDL (Data Definition Language) — Desain Skema Tabel
-- ============================================================
-- Membuat tabel promo baru dengan Constraints
CREATE TABLE IF NOT EXISTS kategori_promo (
    kategori_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    nama_kategori VARCHAR(50) NOT NULL UNIQUE,
    diskon_pct    REAL DEFAULT 0.0,
    status_aktif  INTEGER CHECK (status_aktif IN (0, 1)) DEFAULT 1,
    catatan       TEXT
);

-- Menambah kolom baru
ALTER TABLE kategori_promo ADD COLUMN tanggal_dibuat DATETIME DEFAULT CURRENT_TIMESTAMP;

-- ============================================================
-- 8. DML (Data Manipulation Language) — Manipulasi Baris Data
-- ============================================================
-- INSERT: Menambah baris promo baru
INSERT INTO kategori_promo (nama_kategori, diskon_pct, status_aktif)
VALUES 
    ('Flash Sale Payday', 25.5, 1),
    ('Diskon Ongkir Super', 10.0, 1);

-- UPDATE: Memperbarui persen diskon
UPDATE kategori_promo
SET diskon_pct = 30.0, catatan = 'Promo Khusus Tanggal Kembar'
WHERE nama_kategori = 'Flash Sale Payday';

-- DELETE: Menghapus data promo non-aktif
DELETE FROM kategori_promo
WHERE status_aktif = 0;