-- 01_tipe_data.sql: Tipe Data SQL
PRAGMA table_info(pelanggan);

SELECT nama_lengkap, UPPER(nama_lengkap) AS nama_kapital,
       SUBSTR(no_hp, 1, 4) || '****' || SUBSTR(no_hp, -3) AS no_hp_sensor
FROM pelanggan LIMIT 5;

SELECT sku, harga_modal, harga_jual, harga_jual - harga_modal AS profit_nominal,
       ROUND((CAST(harga_jual - harga_modal AS REAL) / harga_jual) * 100, 1) AS margin_persen
FROM variasi_produk LIMIT 5;

SELECT nomor_invoice, tanggal_pesanan,
       STRFTIME('%Y-%m', tanggal_pesanan) AS tahun_bulan,
       STRFTIME('%H:%M', tanggal_pesanan) AS jam_menit
FROM pesanan LIMIT 5;

SELECT nomor_invoice, COALESCE(voucher_id, 0) AS voucher_id_aman, potongan_diskon, total_bayar
FROM pesanan LIMIT 5;