-- ============================================================
-- 07_analisis_nyata.sql: Capstone Analisis Bisnis Nyata E-Commerce
-- Fundamental Coding — SQL & Software Engineering (by Velora)
-- ============================================================

-- ============================================================
-- QUERY: 1. Analisis Laba Bersih Finansial Toko (Net Profit & Profit Margin Percent)
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
-- QUERY: 2. Evaluasi Efektivitas Campaign Voucher Promo (Promo Burn Rate & ROI)
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
-- QUERY: 3. Evaluasi Kinerja Logistik & Distribusi Beban Ongkos Kirim Kurir
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
