# Latihan Mandiri: Studi Kasus Analis Data E-Commerce

Selamat datang di studi kasus data e-commerce! Di sini kamu berperan sebagai **Junior Data Analyst**. Kamu akan membantu berbagai divisi menyelesaikan permasalahan operasional sehari-hari menggunakan database perusahaan: [`database/ecommerce.db`](../database/ecommerce.db).

Untuk setiap misi:
1. Pahami kebutuhan dari tim terkait.
2. Buka database di **TablePlus**, lalu amati struktur tabel yang relevan.
3. Tulis query untuk menarik data yang diminta.

---

## 10 Misi Analisis Data

---

### Misi 1: Cek Sampel Kupon Promo Aktif
- **Divisi Pemohon:** Tim Marketing
- **Cerita Kasus:** Tim Marketing mau merilis materi promo *Flash Sale Gajian*. Sebelum materi promo disebarkan, manajer butuh mengecek sampel kupon apa saja yang saat ini terdaftar, bagaimana bentuk diskonnya, besaran potongannya, dan sisa kuota penggunaannya.
- **Kebutuhan Analisis:** Buka katalog voucher promo di TablePlus. Tampilkan data kode kupon, tipe diskon, nilai diskon, dan sisa kuota pemakaiannya. Tampilkan 5 baris pertama sebagai sampel awal.

---

### Misi 2: Simulasi Ongkos Kirim Paket 5 Kg
- **Divisi Pemohon:** Tim Customer Care & Logistik
- **Cerita Kasus:** Tim CS sering menerima pertanyaan dari pelanggan mengenai perkiraan ongkos kirim jika mereka membeli barang berat. Manajer logistik ingin membuat panduan cepat tarif ongkir untuk paket seberat 5 kilogram dari seluruh ekspedisi yang bekerja sama dengan toko kita.
- **Kebutuhan Analisis:** Buka data kurir ekspedisi di TablePlus. Tampilkan nama kurir, jenis layanan, dan tarif dasar per kg. Tambahkan satu kolom baru hasil perhitungan tarif untuk paket 5 kg dengan label nama kolom yang rapi dan mudah dipahami. Tampilkan 5 data pertama.

---

### Misi 3: Deteksi Stok Barang Kritis di Gudang
- **Divisi Pemohon:** Tim Operasional Gudang
- **Cerita Kasus:** Kepala Gudang butuh daftar barang yang persediaan fisiknya sudah menipis (tersisa 10 unit ke bawah). Data ini mendesak agar tim pengadaan barang bisa langsung memesan ulang ke pemasok sebelum stok benar-benar habis terjual.
- **Kebutuhan Analisis:** Buka data stok gudang di TablePlus. Saring hanya barang yang jumlah stoknya 10 unit ke bawah. Urutkan mulai dari yang stoknya paling sedikit agar barang yang paling darurat terlihat pertama kali, lalu ambil 5 produk teratas.

---

### Misi 4: Riset Masukan Berharga dari Ulasan Netral
- **Divisi Pemohon:** Tim Product & Customer Experience
- **Cerita Kasus:** Tim pengembangan produk ingin mencari masukan perbaikan yang objektif. Ulasan dengan rating bintang 3 (netral) biasanya memuat kritik yang membangun, asalkan pembeli memang menuliskan catatan ulasan secara lengkap (bukan review kosong).
- **Kebutuhan Analisis:** Buka data ulasan produk di TablePlus. Saring ulasan yang memberikan rating 3 dan memiliki teks komentar tertulis dari pembeli. Tampilkan 5 ulasan pertama untuk dipelajari tim produk.

---

### Misi 5: Pemetaan Kota Pemasok Tanpa Duplikasi
- **Divisi Pemohon:** Tim Pengadaan (Procurement)
- **Cerita Kasus:** Tim logistik ingin memetakan persebaran wilayah para pemasok barang toko kita. Manajer meminta daftar kota tempat para pemasok berada. Buat daftarnya rapi, ringkas, tanpa ada nama kota yang muncul berulang kali, dan tersusun alfabetis dari A sampai Z.
- **Kebutuhan Analisis:** Buka data supplier di TablePlus. Ambil data kota tempat pemasok berada tanpa ada kota yang terduplikasi, lalu urutkan nama kotanya dari A ke Z.

---

### Misi 6: Perbandingan Saluran Pembayaran Digital
- **Divisi Pemohon:** Tim Pembayaran & Finansial
- **Cerita Kasus:** Tim produk ingin mendorong penggunaan metode pembayaran instan. Mereka ingin membandingkan saluran pembayaran yang tergolong dalam kelompok Virtual Account atau E-Wallet, serta melihat opsi mana yang membebankan biaya admin paling hemat bagi pengguna.
- **Kebutuhan Analisis:** Buka data metode pembayaran di TablePlus. Saring hanya opsi pembayaran yang bertipe Virtual Account atau E-Wallet. Tampilkan nama metode, kategorinya, serta biaya admin. Urutkan dari biaya admin yang paling murah ke yang paling mahal. Jika biaya adminnya sama, urutkan nama metodenya secara alfabetis.

---

### Misi 7: Seleksi Voucher untuk Belanja Skala Menengah
- **Divisi Pemohon:** Tim Promosi & Kampanye
- **Cerita Kasus:** Tim marketing menyiapkan promo khusus untuk segmen pelanggan belanja menengah (keranjang belanja antara Rp 100.000 hingga Rp 250.000). Mereka butuh daftar kupon yang syarat minimal belanjanya berada tepat di rentang nominal tersebut.
- **Kebutuhan Analisis:** Buka katalog voucher promo di TablePlus. Ambil data kupon yang menetapkan batas minimal belanja di antara rentang Rp 100.000 sampai Rp 250.000. Urutkan dari syarat belanja yang paling terjangkau ke yang lebih tinggi.

---

### Misi 8: Audit Legalitas Rekanan Berbadan Hukum PT
- **Divisi Pemohon:** Tim Legal & Manajemen Vendor
- **Cerita Kasus:** Untuk kerja sama bernilai besar, kebijakan audit mengharuskan prioritas kerja sama diberikan kepada mitra yang berbadan hukum resmi Perseroan Terbatas (PT). Tim legal meminta daftar seluruh rekanan pemasok yang perusahaannya berawalan status PT.
- **Kebutuhan Analisis:** Buka data supplier di TablePlus. Saring pemasok yang nama perusahaannya diawali dengan kata 'PT'. Tampilkan identitas pemasok, nama perusahaan, kontak person yang bisa dihubungi, dan kota asalnya. Urutkan nama perusahaannya dari A ke Z.

---

### Misi 9: Paginasi Etalase Produk Premium Halaman ke-2
- **Divisi Pemohon:** Tim Front-End & Pengembang Web
- **Cerita Kasus:** Pada etalase aplikasi, daftar produk dengan harga tertinggi ditampilkan bertahap (5 produk per halaman). Halaman pertama (peringkat 1 sampai 5 termahal) sudah selesai ditampilkan. Sekarang tim pengembang butuh data untuk menampilkan **Halaman 2** (produk peringkat 6 sampai 10 termahal).
- **Kebutuhan Analisis:** Buka data variasi produk di TablePlus. Tampilkan kode varian, warna, ukuran, dan harga jualnya. Urutkan dari harga yang paling mahal ke paling murah. Lewati 5 produk termahal pertama, lalu ambil 5 produk berikutnya.

---

### Misi 10: Investigasi Transaksi Bernilai Besar yang Tertahan
- **Divisi Pemohon:** Tim Keuangan & Manajemen Risiko
- **Cerita Kasus:** Manajemen keuangan mendeteksi adanya transaksi bernilai sangat besar (di atas Rp 50.000.000) yang berisiko gagal menjadi pemasukan toko karena statusnya masih 'Menunggu Pembayaran' atau sudah 'Dibatalkan'. Tim butuh data transaksi ini segera untuk ditindaklanjuti.
- **Kebutuhan Analisis:** Buka data pesanan di TablePlus. Tampilkan informasi faktur, tanggal transaksi, status, biaya kirim, dan total bayar. Saring pesanan yang total bayarnya minimal Rp 50.000.000 dan statusnya berada di antara 'Dibatalkan' atau 'Menunggu Pembayaran'. Urutkan dari transaksi bernilai rupiah paling besar, lalu ambil 5 data teratas.
