const { DatabaseSync } = require('node:sqlite');
const fs = require('node:fs');
const path = require('node:path');

const dbPath = path.resolve(__dirname, 'ecommerce.db');
const outputPath = path.resolve(__dirname, 'neon_seed.sql');

const db = new DatabaseSync(dbPath);

const tables = [
  {
    name: 'kategori',
    pk: 'kategori_id',
    ddl: `CREATE TABLE kategori (
    kategori_id SERIAL PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL
);`
  },
  {
    name: 'subkategori',
    pk: 'subkategori_id',
    ddl: `CREATE TABLE subkategori (
    subkategori_id SERIAL PRIMARY KEY,
    kategori_id INTEGER NOT NULL REFERENCES kategori(kategori_id),
    nama_subkategori VARCHAR(100) NOT NULL
);`
  },
  {
    name: 'merek',
    pk: 'merek_id',
    ddl: `CREATE TABLE merek (
    merek_id SERIAL PRIMARY KEY,
    nama_merek VARCHAR(100) NOT NULL,
    negara_asal VARCHAR(50) NOT NULL
);`
  },
  {
    name: 'supplier',
    pk: 'supplier_id',
    ddl: `CREATE TABLE supplier (
    supplier_id SERIAL PRIMARY KEY,
    nama_supplier VARCHAR(150) NOT NULL,
    kontak_person VARCHAR(100) NOT NULL,
    no_telepon VARCHAR(20) NOT NULL,
    kota VARCHAR(50) NOT NULL
);`
  },
  {
    name: 'gudang',
    pk: 'gudang_id',
    ddl: `CREATE TABLE gudang (
    gudang_id SERIAL PRIMARY KEY,
    nama_gudang VARCHAR(100) NOT NULL,
    kota VARCHAR(50) NOT NULL,
    kapasitas_unit INTEGER NOT NULL
);`
  },
  {
    name: 'kurir_ekspedisi',
    pk: 'kurir_id',
    ddl: `CREATE TABLE kurir_ekspedisi (
    kurir_id SERIAL PRIMARY KEY,
    nama_kurir VARCHAR(100) NOT NULL,
    layanan VARCHAR(100) NOT NULL,
    tarif_per_kg INTEGER NOT NULL
);`
  },
  {
    name: 'metode_pembayaran',
    pk: 'metode_id',
    ddl: `CREATE TABLE metode_pembayaran (
    metode_id SERIAL PRIMARY KEY,
    nama_metode VARCHAR(100) NOT NULL,
    tipe VARCHAR(50) NOT NULL,
    biaya_admin INTEGER NOT NULL DEFAULT 0
);`
  },
  {
    name: 'voucher_promo',
    pk: 'voucher_id',
    ddl: `CREATE TABLE voucher_promo (
    voucher_id SERIAL PRIMARY KEY,
    kode_voucher VARCHAR(50) UNIQUE NOT NULL,
    tipe_diskon VARCHAR(20) NOT NULL,
    nilai_diskon INTEGER NOT NULL,
    minimal_belanja INTEGER NOT NULL,
    kuota_pemakaian INTEGER NOT NULL
);`
  },
  {
    name: 'pelanggan',
    pk: 'pelanggan_id',
    ddl: `CREATE TABLE pelanggan (
    pelanggan_id SERIAL PRIMARY KEY,
    nama_lengkap VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    no_hp VARCHAR(20) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    tanggal_lahir DATE NOT NULL,
    tanggal_daftar DATE NOT NULL
);`
  },
  {
    name: 'alamat_pelanggan',
    pk: 'alamat_id',
    ddl: `CREATE TABLE alamat_pelanggan (
    alamat_id SERIAL PRIMARY KEY,
    pelanggan_id INTEGER NOT NULL REFERENCES pelanggan(pelanggan_id),
    label_alamat VARCHAR(50) NOT NULL,
    alamat_jalan VARCHAR(255) NOT NULL,
    kota VARCHAR(50) NOT NULL,
    provinsi VARCHAR(50) NOT NULL,
    kode_pos CHAR(5) NOT NULL,
    is_utama INTEGER NOT NULL DEFAULT 0
);`
  },
  {
    name: 'produk',
    pk: 'produk_id',
    ddl: `CREATE TABLE produk (
    produk_id SERIAL PRIMARY KEY,
    subkategori_id INTEGER NOT NULL REFERENCES subkategori(subkategori_id),
    merek_id INTEGER NOT NULL REFERENCES merek(merek_id),
    supplier_id INTEGER NOT NULL REFERENCES supplier(supplier_id),
    nama_produk VARCHAR(200) NOT NULL,
    deskripsi TEXT,
    berat_gram INTEGER NOT NULL
);`
  },
  {
    name: 'variasi_produk',
    pk: 'variasi_id',
    ddl: `CREATE TABLE variasi_produk (
    variasi_id SERIAL PRIMARY KEY,
    produk_id INTEGER NOT NULL REFERENCES produk(produk_id),
    sku VARCHAR(50) UNIQUE NOT NULL,
    warna VARCHAR(50),
    ukuran VARCHAR(30),
    harga_modal INTEGER NOT NULL,
    harga_jual INTEGER NOT NULL
);`
  },
  {
    name: 'stok_gudang',
    pk: 'stok_id',
    ddl: `CREATE TABLE stok_gudang (
    stok_id SERIAL PRIMARY KEY,
    gudang_id INTEGER NOT NULL REFERENCES gudang(gudang_id),
    variasi_id INTEGER NOT NULL REFERENCES variasi_produk(variasi_id),
    jumlah_stok INTEGER NOT NULL DEFAULT 0
);`
  },
  {
    name: 'pesanan',
    pk: 'pesanan_id',
    ddl: `CREATE TABLE pesanan (
    pesanan_id SERIAL PRIMARY KEY,
    nomor_invoice VARCHAR(50) UNIQUE NOT NULL,
    pelanggan_id INTEGER NOT NULL REFERENCES pelanggan(pelanggan_id),
    alamat_kirim_id INTEGER NOT NULL REFERENCES alamat_pelanggan(alamat_id),
    kurir_id INTEGER NOT NULL REFERENCES kurir_ekspedisi(kurir_id),
    metode_id INTEGER NOT NULL REFERENCES metode_pembayaran(metode_id),
    voucher_id INTEGER REFERENCES voucher_promo(voucher_id),
    tanggal_pesanan TIMESTAMP NOT NULL,
    status_pesanan VARCHAR(30) NOT NULL,
    total_berat_gram INTEGER NOT NULL,
    ongkos_kirim INTEGER NOT NULL,
    potongan_diskon INTEGER NOT NULL DEFAULT 0,
    total_bayar INTEGER NOT NULL
);`
  },
  {
    name: 'rincian_pesanan',
    pk: 'rincian_id',
    ddl: `CREATE TABLE rincian_pesanan (
    rincian_id SERIAL PRIMARY KEY,
    pesanan_id INTEGER NOT NULL REFERENCES pesanan(pesanan_id),
    variasi_id INTEGER NOT NULL REFERENCES variasi_produk(variasi_id),
    jumlah INTEGER NOT NULL,
    harga_satuan INTEGER NOT NULL,
    subtotal INTEGER NOT NULL
);`
  },
  {
    name: 'riwayat_pembayaran',
    pk: 'pembayaran_id',
    ddl: `CREATE TABLE riwayat_pembayaran (
    pembayaran_id SERIAL PRIMARY KEY,
    pesanan_id INTEGER NOT NULL REFERENCES pesanan(pesanan_id),
    tanggal_bayar TIMESTAMP NOT NULL,
    jumlah_dibayar INTEGER NOT NULL,
    nomor_referensi VARCHAR(100) NOT NULL,
    status_pembayaran VARCHAR(30) NOT NULL
);`
  },
  {
    name: 'status_pengiriman',
    pk: 'tracking_id',
    ddl: `CREATE TABLE status_pengiriman (
    tracking_id SERIAL PRIMARY KEY,
    pesanan_id INTEGER NOT NULL REFERENCES pesanan(pesanan_id),
    nomor_resi VARCHAR(50) NOT NULL,
    waktu_update TIMESTAMP NOT NULL,
    status_lokasi VARCHAR(100) NOT NULL,
    keterangan VARCHAR(255) NOT NULL
);`
  },
  {
    name: 'ulasan_produk',
    pk: 'ulasan_id',
    ddl: `CREATE TABLE ulasan_produk (
    ulasan_id SERIAL PRIMARY KEY,
    produk_id INTEGER NOT NULL REFERENCES produk(produk_id),
    pelanggan_id INTEGER NOT NULL REFERENCES pelanggan(pelanggan_id),
    pesanan_id INTEGER NOT NULL REFERENCES pesanan(pesanan_id),
    rating INTEGER CHECK(rating BETWEEN 1 AND 5),
    komentar TEXT,
    tanggal_ulasan TIMESTAMP NOT NULL
);`
  },
  {
    name: 'keranjang_belanja',
    pk: 'keranjang_id',
    ddl: `CREATE TABLE keranjang_belanja (
    keranjang_id SERIAL PRIMARY KEY,
    pelanggan_id INTEGER NOT NULL REFERENCES pelanggan(pelanggan_id),
    variasi_id INTEGER NOT NULL REFERENCES variasi_produk(variasi_id),
    jumlah INTEGER NOT NULL,
    tanggal_ditambahkan TIMESTAMP NOT NULL
);`
  },
  {
    name: 'wishlist_produk',
    pk: 'wishlist_id',
    ddl: `CREATE TABLE wishlist_produk (
    wishlist_id SERIAL PRIMARY KEY,
    pelanggan_id INTEGER NOT NULL REFERENCES pelanggan(pelanggan_id),
    produk_id INTEGER NOT NULL REFERENCES produk(produk_id),
    tanggal_simpan TIMESTAMP NOT NULL
);`
  }
];

function escapeValue(val) {
  if (val === null || val === undefined) {
    return 'NULL';
  }
  if (typeof val === 'number') {
    return val.toString();
  }
  if (typeof val === 'boolean') {
    return val ? 'TRUE' : 'FALSE';
  }
  const str = String(val).replace(/'/g, "''");
  return `'${str}'`;
}

let sql = `-- ============================================================
-- NEON POSTGRESQL SEED DUMP
-- Database: ecommerce (20 tables)
-- Generated: ${new Date().toISOString()}
-- ============================================================

BEGIN;

-- Drop existing tables in reverse dependency order
`;

for (let i = tables.length - 1; i >= 0; i--) {
  sql += `DROP TABLE IF EXISTS ${tables[i].name} CASCADE;\n`;
}

sql += '\n-- Create tables in forward order\n';
for (const t of tables) {
  sql += `-- ------------------------------------------------------------\n`;
  sql += `-- TABEL: ${t.name}\n`;
  sql += `-- ------------------------------------------------------------\n`;
  sql += `${t.ddl}\n\n`;
}

sql += '\n-- Insert data\n';
for (const t of tables) {
  const rows = db.prepare(`SELECT * FROM ${t.name}`).all();
  if (rows.length === 0) continue;

  const cols = Object.keys(rows[0]);
  const colList = cols.join(', ');

  sql += `-- Data: ${t.name} (${rows.length} rows)\n`;

  // Batch inserts in chunks of 500
  const CHUNK_SIZE = 500;
  for (let i = 0; i < rows.length; i += CHUNK_SIZE) {
    const chunk = rows.slice(i, i + CHUNK_SIZE);
    const valueStrings = chunk.map(row => {
      const vals = cols.map(c => escapeValue(row[c]));
      return `(${vals.join(', ')})`;
    });

    sql += `INSERT INTO ${t.name} (${colList}) VALUES\n  ${valueStrings.join(',\n  ')};\n`;
  }
  sql += '\n';
}

sql += '\n-- Reset sequence counters for identity / serial columns\n';
for (const t of tables) {
  sql += `SELECT setval(pg_get_serial_sequence('${t.name}', '${t.pk}'), COALESCE((SELECT MAX(${t.pk}) FROM ${t.name}), 1));\n`;
}

sql += '\nCOMMIT;\n';

fs.writeFileSync(outputPath, sql, 'utf8');
console.log(`Successfully generated PostgreSQL seed script at: ${outputPath}`);
console.log(`File size: ${(fs.statSync(outputPath).size / 1024 / 1024).toFixed(2)} MB`);
