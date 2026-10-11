# Latihan Mandiri SQL: Studi Kasus Riil E-Commerce

Panduan latihan menulis query SQL dasar menggunakan database riil e-commerce Indonesia: [`database/ecommerce.db`](../database/ecommerce.db).

> **Petunjuk Pengerjaan:**
> 1. Buka database `database/ecommerce.db` menggunakan aplikasi SQLite pilihan Anda (seperti **DB Browser for SQLite**, ekstensi VS Code **SQLite Viewer**, atau via CLI `sqlite3`).
> 2. Soal-soal di bawah ini dirancang dari **skenario bisnis baru dan tabel-tabel berbeda** (bukan sekadar mengulang contoh di Modul 2) untuk menguji pemahaman analisis mandiri Anda.
> 3. Kerjakan setiap nomor soal secara mandiri tanpa melihat kunci jawaban terlebih dahulu.
> 4. Kunci jawaban dan pembahasan teknis lengkap tersedia di file terpisah: [`kunci_jawaban.md`](./kunci_jawaban.md) serta versi interaktif di [`latihan.html`](../latihan.html).

---

## Daftar 10 Soal Latihan Mandiri

### Soal 1: Audit Kupon Promosi & Kuota Penggunaan (SELECT & LIMIT)
Tim promosi ingin mengaudit katalog kupon diskon yang sedang aktif beserta batas kuota penggunaannya.
- **Tabel:** `voucher_promo`
- **Instruksi:** Tampilkan kolom kode kupon (`kode_voucher`), jenis diskon (`tipe_diskon`), nominal/persen diskon (`nilai_diskon`), dan batas pemakaian (`kuota_pemakaian`). Batasi hasilnya hanya **5 baris pertama**.

---

### Soal 2: Kalkulasi Ongkos Kirim Paket Berat (Kalkulasi Matematika & Kolom Alias AS)
Tim operasional ingin membuat simulasi estimasi tarif pengiriman barang untuk paket berbobot 5 kilogram.
- **Tabel:** `kurir_ekspedisi`
- **Instruksi:** Tampilkan kolom `nama_kurir`, jenis `layanan`, `tarif_per_kg`, serta buat kolom kalkulasi perkiraan ongkir 5 kg (`tarif_per_kg * 5`) dengan nama alias `estimasi_ongkir_5kg`. Batasi hasilnya **5 baris pertama**.

---

### Soal 3: Peringatan Stok Menipis di Gudang (WHERE & Operator <=)
Manajer gudang membutuhkan sistem peringatan dini (restock alert) untuk produk yang persediaannya kritis agar segera dipesan ulang ke pemasok.
- **Tabel:** `stok_gudang`
- **Instruksi:** Tampilkan kolom identitas stok (`stok_id`), gudang penyimpanan (`gudang_id`), varian barang (`variasi_id`), dan sisa stok fisik (`jumlah_stok`). Saring data hanya untuk stok yang berjumlah 10 unit ke bawah (`jumlah_stok <= 10`). Urutkan dari stok yang paling kritis/sedikit (`ORDER BY jumlah_stok ASC`) dan batasi **5 baris pertama**.

---

### Soal 4: Kurasi Ulasan Tertulis Pelanggan (WHERE, AND, & IS NOT NULL)
Tim evaluasi kepuasan pelanggan ingin meneliti ulasan bintang 3 yang memiliki feedback komentar tertulis (bukan ulasan yang dikosongkan pembeli).
- **Tabel:** `ulasan_produk`
- **Instruksi:** Tampilkan kolom nomor ulasan (`ulasan_id`), produk terkait (`produk_id`), nilai bintang (`rating`), dan isi tanggapan pembeli (`komentar`). Filter hanya ulasan yang bernilai `rating = 3` DAN kolom `komentar IS NOT NULL`. Batasi hasil **5 baris pertama**.

---

### Soal 5: Sebaran Kota Pemasok Logistik Tanpa Duplikasi (DISTINCT & ORDER BY)
Divisi pengadaan barang (procurement) membutuhkan rekapitulasi kota-kota tempat mitra pemasok berdomisili untuk pemetaan rute suplai.
- **Tabel:** `supplier`
- **Instruksi:** Dapatkan daftar nama kota unik dari kolom `kota` tanpa ada nama kota yang berulang. Urutkan hasilnya berdasarkan abjad dari A ke Z (`ORDER BY kota ASC`).

---

### Soal 6: Analisis Saluran Pembayaran Perbankan Digital (Operator IN)
Manajer produk fintech ingin mengevaluasi saluran pembayaran perbankan digital bertipe Virtual Account dan E-Wallet.
- **Tabel:** `metode_pembayaran`
- **Instruksi:** Tampilkan kolom nama saluran (`nama_metode`), kategori pembayaran (`tipe`), dan biaya layanan (`biaya_admin`). Saring metode yang tipenya adalah `'Virtual Account'` atau `'E-Wallet'`. Urutkan hasilnya dari biaya admin termurah ke termahal, lalu urutkan nama metodenya secara ascending.

---

### Soal 7: Evaluasi Promo Belanja Skala Menengah (Operator BETWEEN)
Tim kampanye pemasaran ingin memfilter kupon voucher yang dirancang khusus untuk memicu transaksi bernilai menengah.
- **Tabel:** `voucher_promo`
- **Instruksi:** Tampilkan kolom `kode_voucher`, `tipe_diskon`, `nilai_diskon`, dan syarat belanja minimal (`minimal_belanja`). Filter voucher yang memiliki nilai `minimal_belanja` berada di antara `100000` sampai `250000` (inklusif). Urutkan dari syarat minimal belanja terkecil ke terbesar.

---

### Soal 8: Audit Legalitas Identitas Vendor Supplier (Pencarian Teks LIKE)
Tim legal perusahaan mewajibkan pendataan vendor penyedia barang yang berbadan hukum resmi Perseroan Terbatas (PT).
- **Tabel:** `supplier`
- **Instruksi:** Tampilkan kolom nomor identitas (`supplier_id`), nama mitra (`nama_supplier`), nama perwakilan (`kontak_person`), dan lokasi `kota`. Saring mitra yang nama perusahaannya diawali dengan kata `'PT'` (`LIKE 'PT%'`). Urutkan dari nama supplier secara alfabetis (A ke Z).

---

### Soal 9: Paginasi Leaderboard Produk Mewah Halaman ke-2 (ORDER BY, LIMIT, OFFSET)
Pada katalog aplikasi eksekutif, data variasi produk termahal ditampilkan sebanyak 5 barang per halaman.
- **Tabel:** `variasi_produk`
- **Instruksi:** Tampilkan kode barang (`sku`), pilihan `warna`, `ukuran`, dan harga jual (`harga_jual`). Urutkan dari varian harga termahal ke termurah (`ORDER BY harga_jual DESC`). Ambil data untuk **Halaman 2** (artinya lewati 5 produk termahal pertama, lalu ambil 5 produk berikutnya).

---

### Soal 10: Audit Risiko Transaksi Tertunda & Batal (Multi-Kondisi AND, OR, Kurung)
Tim manajemen risiko ingin memeriksa pesanan bernilai transaksi fantastis (di atas Rp 50.000.000) yang gagal diproses atau masih tertunda pembayarannya.
- **Tabel:** `pesanan`
- **Instruksi:** Tampilkan nomor nota (`nomor_invoice`), waktu belanja (`tanggal_pesanan`), status pengiriman (`status_pesanan`), biaya kirim (`ongkos_kirim`), dan nilai akhir (`total_bayar`). Filter pesanan yang memiliki `status_pesanan = 'Dibatalkan'` ATAU `status_pesanan = 'Menunggu Pembayaran'`, DAN bernilai `total_bayar >= 50000000`. Pastikan kondisi status dibungkus tanda kurung `( ... )`. Urutkan dari nilai transaksi terbesar (`ORDER BY total_bayar DESC`) dan batasi **5 baris**.
