-- ============================================================
-- 06_window_functions.sql: Window Functions & Analisis Tren Lanjutan
-- Fundamental Coding — SQL & Software Engineering (by Velora)
-- ============================================================

-- ============================================================
-- QUERY: 1. DENSE_RANK: Peringkat Top Produk Terlaris di Tiap Kategori
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
-- QUERY: 2. LAG: Analisis Pertumbuhan Pendapatan Bulanan (Month-over-Month / MoM Growth)
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
-- QUERY: 3. SUM() OVER: Akumulasi Omzet Berjalan (Running Total / YTD Revenue)
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
