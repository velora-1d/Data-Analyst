-- ============================================================
-- 04_join.sql: Relasi Multi-Tabel, INNER JOIN, LEFT JOIN & Anti-Join
-- Fundamental Coding — SQL & Software Engineering (by Velora)
-- ============================================================

-- ============================================================
-- QUERY: 1. INNER JOIN Multi-Tabel: Katalog Produk Lengkap (5 Tabel)
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom-kolom atribut spesifik yang ingin ditampilkan dari beberapa tabel yang berelasi
-- • FROM     : Menentukan tabel dasar yang menjadi titik awal penggabungan data
-- • JOIN     : Menggabungkan baris dari dua atau lebih tabel hanya jika terdapat nilai yang cocok pada kolom kondisi penghubung (ON)
-- • LIMIT    : Membatasi jumlah baris data yang dikembalikan pada hasil query
--
-- DIPAKAI KAPAN:
-- Ketika data yang dibutuhkan tersebar di beberapa tabel yang saling terhubung dan hanya baris yang memiliki pasangan data valid di seluruh tabel yang ingin ditampilkan.
--
-- KASUS:
-- Menggabungkan data katalog produk dengan tabel merek, subkategori, kategori induk, dan supplier untuk menampilkan informasi produk yang lengkap.
-- ============================================================
SELECT 
    pr.nama_produk, 
    m.nama_merek, 
    k.nama_kategori, 
    sk.nama_subkategori,
    s.nama_supplier
FROM produk pr
JOIN merek m        ON pr.merek_id = m.merek_id
JOIN subkategori sk ON pr.subkategori_id = sk.subkategori_id
JOIN kategori k     ON sk.kategori_id = k.kategori_id
JOIN supplier s     ON pr.supplier_id = s.supplier_id 
LIMIT 5;

-- ============================================================
-- QUERY: 2. LEFT JOIN Anti-Join: Pelanggan yang Belum Pernah Belanja (Zero Order / Inactive Leads)
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan atribut data identitas pelanggan yang ingin ditampilkan
-- • FROM     : Menentukan tabel kiri sebagai tabel acuan utama yang seluruh baris datanya tetap dipertahankan
-- • LEFT JOIN: Menggabungkan semua baris dari tabel kiri dengan baris yang cocok dari tabel kanan; jika tidak ada pasangan yang cocok, kolom tabel kanan akan berisi nilai NULL
-- • WHERE    : Menyaring baris hasil gabungan dengan kondisi nilai kolom tabel kanan IS NULL (teknik anti-join untuk menemukan data yang tidak berelasi)
-- • LIMIT    : Membatasi jumlah baris data yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Ketika ingin menemukan rekaman data pada suatu tabel yang sama sekali tidak memiliki riwayat atau catatan relasi di tabel lainnya.
--
-- KASUS:
-- Mencari daftar data pelanggan yang sudah terdaftar di sistem namun belum pernah membuat transaksi pesanan sama sekali.
-- ============================================================
SELECT 
    pl.pelanggan_id, 
    pl.nama_lengkap, 
    pl.email, 
    pl.tanggal_daftar
FROM pelanggan pl
LEFT JOIN pesanan p ON pl.pelanggan_id = p.pelanggan_id
WHERE p.pesanan_id IS NULL 
LIMIT 5;

-- ============================================================
-- QUERY: 3. Rantai Multi-Tabel Transaksi Belanja Utuh (6 Tabel)
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom atribut faktur, pembeli, produk, varian fisik, kuantitas, subtotal, dan nama kurir dengan penamaan alias
-- • FROM     : Menentukan tabel transaksi utama yang menjadi pusat relasi
-- • JOIN     : Menggabungkan baris-baris data dari 6 tabel berbeda secara berantai berdasarkan kesamaan nilai foreign key
-- • LIMIT    : Membatasi jumlah baris data transaksi yang ditampilkan
--
-- DIPAKAI KAPAN:
-- Ketika ingin merekonstruksi satu entitas proses yang kompleks (seperti rincian faktur transaksi belanja) yang atributnya dinormalisasi ke berbagai tabel master.
--
-- KASUS:
-- Menampilkan rincian transaksi belanja lengkap beserta identitas pembeli, nama produk, varian warna, kuantitas barang, subtotal belanja, dan jasa ekspedisi pengiriman.
-- ============================================================
SELECT 
    p.nomor_invoice, 
    pl.nama_lengkap AS nama_pembeli, 
    pr.nama_produk, 
    vp.warna, 
    rp.jumlah       AS qty, 
    rp.subtotal, 
    ke.nama_kurir
FROM pesanan p
JOIN pelanggan pl        ON p.pelanggan_id = pl.pelanggan_id
JOIN rincian_pesanan rp  ON p.pesanan_id = rp.pesanan_id
JOIN variasi_produk vp   ON rp.variasi_id = vp.variasi_id
JOIN produk pr           ON vp.produk_id = pr.produk_id
JOIN kurir_ekspedisi ke  ON p.kurir_id = ke.kurir_id 
LIMIT 5;

-- ============================================================
-- QUERY: 4. Aggregate JOIN: Valuasi Nilai dan Volume Stok per Hub Gudang
--
-- FUNGSI QUERY:
-- • SELECT   : Menentukan kolom lokasi gudang, penghitungan jumlah variasi unik (COUNT DISTINCT), total kuantitas stok (SUM), serta total estimasi nilai rupiah
-- • FROM     : Menentukan tabel gudang sebagai sumber data awal
-- • JOIN     : Menggabungkan tabel gudang dengan tabel perantara stok dan tabel variasi produk untuk mendapatkan harga modal
-- • GROUP BY : Mengelompokkan baris-baris data transaksi stok berdasarkan identitas unik gudang
-- • ORDER BY : Mengurutkan kelompok baris data hasil kalkulasi dari nilai total aset terbesar ke terkecil (DESC)
--
-- DIPAKAI KAPAN:
-- Ketika perlu menggabungkan beberapa tabel relasi sekaligus melakukan kalkulasi agregasi matematika pada kelompok entitas tertentu.
--
-- KASUS:
-- Menghitung total variasi produk tersimpan, total unit barang fisik, dan total estimasi valuasi nilai modal stok di masing-masing fasilitas gudang.
-- ============================================================
SELECT 
    g.nama_gudang,
    g.kota,
    COUNT(DISTINCT sg.variasi_id)        AS total_variasi_tersimpan,
    SUM(sg.jumlah_stok)                  AS total_unit_fisik,
    SUM(sg.jumlah_stok * vp.harga_modal) AS estimasi_nilai_aset_gudang
FROM gudang g
JOIN stok_gudang sg    ON g.gudang_id = sg.gudang_id
JOIN variasi_produk vp ON sg.variasi_id = vp.variasi_id
GROUP BY g.gudang_id
ORDER BY estimasi_nilai_aset_gudang DESC;
