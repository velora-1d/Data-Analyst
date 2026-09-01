-- ============================================================
-- DATABASE DUMP: E-COMMERCE INDONESIA ENTERPRISE
-- Tipe Data Standar Industri: VARCHAR, CHAR, BIGINT, DATETIME
-- ============================================================

PRAGMA foreign_keys = OFF;

-- 1. TABEL: KATEGORI
DROP TABLE IF EXISTS kategori;
CREATE TABLE kategori (
    kategori_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nama_kategori VARCHAR(100) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL
);

-- 2. TABEL: SUBKATEGORI
DROP TABLE IF EXISTS subkategori;
CREATE TABLE subkategori (
    subkategori_id INTEGER PRIMARY KEY AUTOINCREMENT,
    kategori_id INTEGER NOT NULL,
    nama_subkategori VARCHAR(100) NOT NULL,
    FOREIGN KEY (kategori_id) REFERENCES kategori(kategori_id)
);

-- 3. TABEL: MEREK
DROP TABLE IF EXISTS merek;
CREATE TABLE merek (
    merek_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nama_merek VARCHAR(100) NOT NULL,
    negara_asal VARCHAR(50) NOT NULL
);

-- 4. TABEL: SUPPLIER
DROP TABLE IF EXISTS supplier;
CREATE TABLE supplier (
    supplier_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nama_supplier VARCHAR(150) NOT NULL,
    kontak_person VARCHAR(100) NOT NULL,
    no_telepon VARCHAR(20) NOT NULL,
    kota VARCHAR(50) NOT NULL
);

-- 5. TABEL: GUDANG
DROP TABLE IF EXISTS gudang;
CREATE TABLE gudang (
    gudang_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nama_gudang VARCHAR(100) NOT NULL,
    kota VARCHAR(50) NOT NULL,
    kapasitas_unit INTEGER NOT NULL
);

-- 6. TABEL: KURIR EKSPEDISI
DROP TABLE IF EXISTS kurir_ekspedisi;
CREATE TABLE kurir_ekspedisi (
    kurir_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nama_kurir VARCHAR(100) NOT NULL,
    layanan VARCHAR(100) NOT NULL,
    tarif_per_kg INTEGER NOT NULL
);

-- 7. TABEL: METODE PEMBAYARAN
DROP TABLE IF EXISTS metode_pembayaran;
CREATE TABLE metode_pembayaran (
    metode_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nama_metode VARCHAR(100) NOT NULL,
    tipe VARCHAR(50) NOT NULL,
    biaya_admin INTEGER NOT NULL DEFAULT 0
);

-- 8. TABEL: VOUCHER PROMO
DROP TABLE IF EXISTS voucher_promo;
CREATE TABLE voucher_promo (
    voucher_id INTEGER PRIMARY KEY AUTOINCREMENT,
    kode_voucher VARCHAR(50) UNIQUE NOT NULL,
    tipe_diskon VARCHAR(20) NOT NULL,
    nilai_diskon INTEGER NOT NULL,
    minimal_belanja INTEGER NOT NULL,
    kuota_pemakaian INTEGER NOT NULL
);

-- 9. TABEL: PELANGGAN
DROP TABLE IF EXISTS pelanggan;
CREATE TABLE pelanggan (
    pelanggan_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nama_lengkap VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    no_hp VARCHAR(20) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    tanggal_lahir DATE NOT NULL,
    tanggal_daftar DATE NOT NULL
);

-- 10. TABEL: ALAMAT PELANGGAN
DROP TABLE IF EXISTS alamat_pelanggan;
CREATE TABLE alamat_pelanggan (
    alamat_id INTEGER PRIMARY KEY AUTOINCREMENT,
    pelanggan_id INTEGER NOT NULL,
    label_alamat VARCHAR(50) NOT NULL,
    alamat_jalan VARCHAR(255) NOT NULL,
    kota VARCHAR(50) NOT NULL,
    provinsi VARCHAR(50) NOT NULL,
    kode_pos CHAR(5) NOT NULL,
    is_utama INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (pelanggan_id) REFERENCES pelanggan(pelanggan_id)
);

-- 11. TABEL: PRODUK
DROP TABLE IF EXISTS produk;
CREATE TABLE produk (
    produk_id INTEGER PRIMARY KEY AUTOINCREMENT,
    subkategori_id INTEGER NOT NULL,
    merek_id INTEGER NOT NULL,
    supplier_id INTEGER NOT NULL,
    nama_produk VARCHAR(200) NOT NULL,
    deskripsi TEXT,
    berat_gram INTEGER NOT NULL,
    FOREIGN KEY (subkategori_id) REFERENCES subkategori(subkategori_id),
    FOREIGN KEY (merek_id) REFERENCES merek(merek_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);

-- 12. TABEL: VARIASI PRODUK (SKU)
DROP TABLE IF EXISTS variasi_produk;
CREATE TABLE variasi_produk (
    variasi_id INTEGER PRIMARY KEY AUTOINCREMENT,
    produk_id INTEGER NOT NULL,
    sku VARCHAR(50) UNIQUE NOT NULL,
    warna VARCHAR(50),
    ukuran VARCHAR(30),
    harga_modal INTEGER NOT NULL,
    harga_jual INTEGER NOT NULL,
    FOREIGN KEY (produk_id) REFERENCES produk(produk_id)
);

-- 13. TABEL: STOK GUDANG
DROP TABLE IF EXISTS stok_gudang;
CREATE TABLE stok_gudang (
    stok_id INTEGER PRIMARY KEY AUTOINCREMENT,
    gudang_id INTEGER NOT NULL,
    variasi_id INTEGER NOT NULL,
    jumlah_stok INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (gudang_id) REFERENCES gudang(gudang_id),
    FOREIGN KEY (variasi_id) REFERENCES variasi_produk(variasi_id)
);

-- 14. TABEL: PESANAN
DROP TABLE IF EXISTS pesanan;
CREATE TABLE pesanan (
    pesanan_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nomor_invoice VARCHAR(50) UNIQUE NOT NULL,
    pelanggan_id INTEGER NOT NULL,
    alamat_kirim_id INTEGER NOT NULL,
    kurir_id INTEGER NOT NULL,
    metode_id INTEGER NOT NULL,
    voucher_id INTEGER,
    tanggal_pesanan DATETIME NOT NULL,
    status_pesanan VARCHAR(30) NOT NULL,
    total_berat_gram INTEGER NOT NULL,
    ongkos_kirim INTEGER NOT NULL,
    potongan_diskon INTEGER NOT NULL DEFAULT 0,
    total_bayar INTEGER NOT NULL,
    FOREIGN KEY (pelanggan_id) REFERENCES pelanggan(pelanggan_id),
    FOREIGN KEY (alamat_kirim_id) REFERENCES alamat_pelanggan(alamat_id),
    FOREIGN KEY (kurir_id) REFERENCES kurir_ekspedisi(kurir_id),
    FOREIGN KEY (metode_id) REFERENCES metode_pembayaran(metode_id),
    FOREIGN KEY (voucher_id) REFERENCES voucher_promo(voucher_id)
);

-- 15. TABEL: RINCIAN PESANAN
DROP TABLE IF EXISTS rincian_pesanan;
CREATE TABLE rincian_pesanan (
    rincian_id INTEGER PRIMARY KEY AUTOINCREMENT,
    pesanan_id INTEGER NOT NULL,
    variasi_id INTEGER NOT NULL,
    jumlah INTEGER NOT NULL,
    harga_satuan INTEGER NOT NULL,
    subtotal INTEGER NOT NULL,
    FOREIGN KEY (pesanan_id) REFERENCES pesanan(pesanan_id),
    FOREIGN KEY (variasi_id) REFERENCES variasi_produk(variasi_id)
);

-- 16. TABEL: RIWAYAT PEMBAYARAN
DROP TABLE IF EXISTS riwayat_pembayaran;
CREATE TABLE riwayat_pembayaran (
    pembayaran_id INTEGER PRIMARY KEY AUTOINCREMENT,
    pesanan_id INTEGER NOT NULL,
    tanggal_bayar DATETIME NOT NULL,
    jumlah_dibayar INTEGER NOT NULL,
    nomor_referensi VARCHAR(100) NOT NULL,
    status_pembayaran VARCHAR(30) NOT NULL,
    FOREIGN KEY (pesanan_id) REFERENCES pesanan(pesanan_id)
);

-- 17. TABEL: STATUS PENGIRIMAN
DROP TABLE IF EXISTS status_pengiriman;
CREATE TABLE status_pengiriman (
    tracking_id INTEGER PRIMARY KEY AUTOINCREMENT,
    pesanan_id INTEGER NOT NULL,
    nomor_resi VARCHAR(50) NOT NULL,
    waktu_update DATETIME NOT NULL,
    status_lokasi VARCHAR(100) NOT NULL,
    keterangan VARCHAR(255) NOT NULL,
    FOREIGN KEY (pesanan_id) REFERENCES pesanan(pesanan_id)
);

-- 18. TABEL: ULASAN PRODUK
DROP TABLE IF EXISTS ulasan_produk;
CREATE TABLE ulasan_produk (
    ulasan_id INTEGER PRIMARY KEY AUTOINCREMENT,
    produk_id INTEGER NOT NULL,
    pelanggan_id INTEGER NOT NULL,
    pesanan_id INTEGER NOT NULL,
    rating INTEGER CHECK(rating BETWEEN 1 AND 5),
    komentar TEXT,
    tanggal_ulasan DATETIME NOT NULL,
    FOREIGN KEY (produk_id) REFERENCES produk(produk_id),
    FOREIGN KEY (pelanggan_id) REFERENCES pelanggan(pelanggan_id),
    FOREIGN KEY (pesanan_id) REFERENCES pesanan(pesanan_id)
);

-- 19. TABEL: KERANJANG BELANJA
DROP TABLE IF EXISTS keranjang_belanja;
CREATE TABLE keranjang_belanja (
    keranjang_id INTEGER PRIMARY KEY AUTOINCREMENT,
    pelanggan_id INTEGER NOT NULL,
    variasi_id INTEGER NOT NULL,
    jumlah INTEGER NOT NULL,
    tanggal_ditambahkan DATETIME NOT NULL,
    FOREIGN KEY (pelanggan_id) REFERENCES pelanggan(pelanggan_id),
    FOREIGN KEY (variasi_id) REFERENCES variasi_produk(variasi_id)
);

-- 20. TABEL: WISHLIST PRODUK
DROP TABLE IF EXISTS wishlist_produk;
CREATE TABLE wishlist_produk (
    wishlist_id INTEGER PRIMARY KEY AUTOINCREMENT,
    pelanggan_id INTEGER NOT NULL,
    produk_id INTEGER NOT NULL,
    tanggal_simpan DATETIME NOT NULL,
    FOREIGN KEY (pelanggan_id) REFERENCES pelanggan(pelanggan_id),
    FOREIGN KEY (produk_id) REFERENCES produk(produk_id)
);

PRAGMA foreign_keys = ON;
