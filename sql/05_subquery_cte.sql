-- ============================================================
-- 05_subquery_cte.sql: Subquery & Common Table Expressions (CTE)
-- Fundamental Coding — SQL & Software Engineering (by Velora)
-- ============================================================

-- ============================================================
-- QUERY: 1. Scalar Subquery: Transaksi Bernilai di Atas Rata-rata Toko
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
-- QUERY: 2. Correlated Subquery / EXISTS: Identifikasi Pembeli Kategori Unggulan
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
-- QUERY: 3. CTE (Common Table Expression): Segmentasi Spending Tier & Loyalitas Pelanggan
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
-- QUERY: 4. Multi-CTE: Kontribusi Omzet Kategori terhadap Grand Total Penjualan Toko
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
