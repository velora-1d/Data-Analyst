# Latihan Mandiri SQL: Query Dasar & Filtering

Panduan latihan menulis query SQL dasar menggunakan database riil e-commerce Indonesia: [`database/ecommerce.db`](../database/ecommerce.db).

> **Petunjuk Pengerjaan:**
> 1. Buka database `database/ecommerce.db` menggunakan aplikasi SQLite pilihan Anda (seperti **DB Browser for SQLite**, ekstensi VS Code **SQLite Viewer**, atau via CLI `sqlite3`).
> 2. Kerjakan setiap nomor soal secara mandiri tanpa melihat kunci jawaban terlebih dahulu.
> 3. Kunci jawaban dan penjelasan lengkap tersedia di file terpisah: [`kunci_jawaban.md`](./kunci_jawaban.md).

---

## Daftar Soal Latihan

### Soal 1: Pemilihan Kolom Tertentu & Pembatasan Baris (SELECT & LIMIT)
Tim operasional logistik ingin melihat katalog produk beserta bobot barang untuk estimasi pengemasan.
- **Tabel:** `produk`
- **Instruksi:** Tampilkan kolom `nama_produk` dan `berat_gram`. Batasi hasilnya hanya **5 baris pertama**.

---

### Soal 2: Pemberian Alias Kolom & Kalkulasi Matematika (AS & Perhitungan)
Tim keuangan ingin menganalisis selisih harga jual dan harga modal pada setiap varian produk.
- **Tabel:** `variasi_produk`
- **Instruksi:** Tampilkan kolom `sku`, `harga_modal`, `harga_jual`, dan kolom kalkulasi selisih keuntungan nominal (`harga_jual - harga_modal`) dengan nama alias `keuntungan_nominal`. Batasi hasilnya **5 baris**.

---

### Soal 3: Filter Kondisi Numerik dengan Perbandingan (WHERE & Operator >=)
Manajer penjualan ingin meninjau transaksi belanja besar yang sudah berstatus sukses.
- **Tabel:** `pesanan`
- **Instruksi:** Tampilkan nomor nota (`nomor_invoice`), tanggal transaksi (`tanggal_pesanan`), total belanja (`total_bayar`), dan `status_pesanan` untuk semua pesanan yang memiliki `status_pesanan = 'Selesai'` dan bernilai `total_bayar >= 1000000` (Rp 1.000.000 ke atas). Urutkan dari yang termurah ke termahal (`ORDER BY total_bayar ASC`) dan batasi **5 baris**.

---

### Soal 4: Filter Majemuk Kombinasi String & Tanggal (WHERE, AND)
Tim pemasaran ingin mendata akun pelanggan wanita yang baru mendaftar sejak awal tahun 2023.
- **Tabel:** `pelanggan`
- **Instruksi:** Tampilkan kolom `pelanggan_id`, `nama_lengkap`, `gender`, `tanggal_daftar`, dan `email`. Filter hanya pelanggan berjenis kelamin `'Wanita'` yang terdaftar pada atau setelah tanggal `'2023-01-01'`. Batasi hasil **5 baris**.

---

### Soal 5: Eliminasi Duplikasi & Pengurutan Ganda (DISTINCT & ORDER BY)
Tim kurir membutuhkan rekapitulasi daftar wilayah tujuan pengiriman tanpa data ganda.
- **Tabel:** `alamat_pelanggan`
- **Instruksi:** Dapatkan kombinasi unik dari kolom `kota` dan `provinsi`. Urutkan hasilnya berdasarkan nama `provinsi` secara ascending (A ke Z), lalu jika provinsinya sama, urutkan berdasarkan `kota` secara ascending. Tampilkan **10 baris pertama**.

---

### Soal 6: Filter Berdasarkan Kumpulan Nilai (IN)
Tim gudang ingin memonitor semua pesanan yang saat ini sedang aktif berjalan (belum sampai ke pembeli dan belum dibatalkan).
- **Tabel:** `pesanan`
- **Instruksi:** Tampilkan `nomor_invoice`, `tanggal_pesanan`, `status_pesanan`, dan `total_bayar`. Filter pesanan yang statusnya adalah `'Diproses'` atau `'Dikirim'`. Urutkan berdasarkan `tanggal_pesanan` terbaru (`DESC`) dan batasi **5 baris**.

---

### Soal 7: Filter Rentang Nilai Numerik (BETWEEN)
Manajer pemasaran ingin mengevaluasi pesanan dengan nilai belanja menengah.
- **Tabel:** `pesanan`
- **Instruksi:** Tampilkan `nomor_invoice`, `total_bayar`, dan `status_pesanan`. Filter pesanan yang memiliki `total_bayar` berada di antara `250000` sampai `500000` (inklusif). Urutkan dari total bayar terbesar ke terkecil dan batasi **5 baris**.

---

### Soal 8: Pencarian Pola Karakter Teks (LIKE & Wildcard)
Pelanggan mencari perangkat nirkabel atau gaming di katalog toko.
- **Tabel:** `produk`
- **Instruksi:** Tampilkan kolom `produk_id`, `nama_produk`, dan `deskripsi`. Filter produk yang mengandung kata `'Wireless'` ATAU mengandung kata `'Gaming'` pada nama produknya.

---

### Soal 9: Paginasi Halaman Data (LIMIT & OFFSET)
Pada dashboard aplikasi admin, data pesanan dengan transaksi tertinggi ditampilkan 10 data per halaman.
- **Tabel:** `pesanan`
- **Instruksi:** Tampilkan `nomor_invoice`, `tanggal_pesanan`, dan `total_bayar`. Urutkan dari nilai `total_bayar` tertinggi ke terendah (`DESC`). Ambil data untuk **Halaman 2** (artinya lewati 10 data teratas pertama, lalu ambil 10 data berikutnya).

---

### Soal 10: Pengecekan Nilai Kosong (IS NULL & ORDER BY)
Tim analitik ingin mengetahui pesanan mana saja yang dilakukan oleh pelanggan tanpa menggunakan kupon/diskon sama sekali.
- **Tabel:** `pesanan`
- **Instruksi:** Tampilkan `nomor_invoice`, `potongan_diskon`, `voucher_id`, `total_bayar`, dan `tanggal_pesanan`. Filter transaksi di mana kolom `voucher_id` bernilai `NULL` (tidak memakai voucher). Urutkan berdasarkan `tanggal_pesanan` terbaru dan batasi **5 baris**.
