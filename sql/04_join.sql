-- 04_join.sql: Multi-Table JOIN
SELECT pr.nama_produk, m.nama_merek, k.nama_kategori, s.nama_supplier
FROM produk pr
JOIN merek m ON pr.merek_id = m.merek_id
JOIN subkategori sk ON pr.subkategori_id = sk.subkategori_id
JOIN kategori k ON sk.kategori_id = k.kategori_id
JOIN supplier s ON pr.supplier_id = s.supplier_id LIMIT 5;

SELECT pl.pelanggan_id, pl.nama_lengkap, pl.email, pl.tanggal_daftar
FROM pelanggan pl
LEFT JOIN pesanan p ON pl.pelanggan_id = p.pelanggan_id
WHERE p.pesanan_id IS NULL LIMIT 5;

SELECT p.nomor_invoice, pl.nama_lengkap AS nama_pembeli, pr.nama_produk, vp.warna, rp.jumlah AS qty, rp.subtotal, ke.nama_kurir
FROM pesanan p
JOIN pelanggan pl ON p.pelanggan_id = pl.pelanggan_id
JOIN rincian_pesanan rp ON p.pesanan_id = rp.pesanan_id
JOIN variasi_produk vp ON rp.variasi_id = vp.variasi_id
JOIN produk pr ON vp.produk_id = pr.produk_id
JOIN kurir_ekspedisi ke ON p.kurir_id = ke.kurir_id LIMIT 5;