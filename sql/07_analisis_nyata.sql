-- 07_analisis_nyata.sql: Capstone Project
SELECT SUM(rp.subtotal) AS omzet_kotor, SUM(p.potongan_diskon) AS total_diskon,
       SUM(rp.jumlah * vp.harga_modal) AS total_hpp_modal,
       SUM(rp.subtotal) - SUM(p.potongan_diskon) - SUM(rp.jumlah * vp.harga_modal) AS laba_bersih,
       ROUND((CAST(SUM(rp.subtotal) - SUM(p.potongan_diskon) - SUM(rp.jumlah * vp.harga_modal) AS REAL) / SUM(rp.subtotal)) * 100, 2) AS profit_margin_percent
FROM pesanan p
JOIN rincian_pesanan rp ON p.pesanan_id = rp.pesanan_id
JOIN variasi_produk vp ON rp.variasi_id = vp.variasi_id
WHERE p.status_pesanan = 'Selesai';