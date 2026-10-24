# Kunci Jawaban & Pembahasan: Studi Kasus Analis Data E-Commerce

Dokumen ini berisi solusi query SQL resmi untuk memecahkan 12 misi studi kasus pada [`soal_latihan.md`](./soal_latihan.md). Seluruh query telah diuji langsung pada database transaksi nyata: [`database/ecommerce.db`](../database/ecommerce.db) menggunakan **TablePlus**.

---

### Misi 1: Cek Sampel Kupon Promo Aktif
- **Divisi Pemohon:** Tim Marketing
- **Tabel Sumber di TablePlus:** `voucher_promo`
- **Fungsi Query:** Perintah `SELECT` berfungsi mengambil data dari kolom-kolom yang ditentukan (`kode_voucher`, `tipe_diskon`, `nilai_diskon`, `kuota_pemakaian`), `FROM` menentukan tabel sumber data (`voucher_promo`), dan klausa `LIMIT` membatasi jumlah baris hasil query agar hanya menampilkan 5 baris pertama.
- **Dipakai Kapan:** Digunakan saat ingin memeriksa struktur isi tabel atau mengecek sampel data awal secara cepat dan ringan tanpa perlu menampilkan seluruh isi tabel.
- **Kasus:** Menampilkan 5 sampel data kupon promo aktif beserta tipe potongan, nilai diskon, dan sisa kuotanya.

```sql
SELECT 
    kode_voucher, 
    tipe_diskon, 
    nilai_diskon, 
    kuota_pemakaian
FROM voucher_promo
LIMIT 5;
```

**Pembahasan Logika Analis:**
- **Pemilihan Kolom:** Kolom `kode_voucher`, `tipe_diskon`, `nilai_diskon`, dan `kuota_pemakaian` dipilih karena memuat informasi esensial yang diminta tim marketing untuk materi promosi. Kolom lain seperti tanggal kedaluwarsa atau minimal belanja tidak ditarik agar output ringkas.
- `LIMIT 5`: Menghentikan pembacaan engine database setelah 5 baris pertama ditemukan, sangat efisien untuk sekadar verifikasi sampel data.

**Pratinjau Hasil di TablePlus:**
| kode_voucher | tipe_diskon | nilai_diskon | kuota_pemakaian |
|---|---|---|---|
| GAJIANHEMAT50 | Nominal | 50000 | 1000 |
| DISKONMEMBER25 | Nominal | 25000 | 2500 |
| ONGKIRGRATIS15 | Nominal | 15000 | 5000 |
| ELEKTRONIK100K | Nominal | 100000 | 800 |
| FASHIONFEST20 | Persen | 20 | 1500 |

---

### Misi 2: Simulasi Ongkos Kirim Paket 5 Kg
- **Divisi Pemohon:** Tim Customer Care & Logistik
- **Tabel Sumber di TablePlus:** `kurir_ekspedisi`
- **Fungsi Query:** Perintah `SELECT` mengambil kolom data, ekspresi aritmatika `(tarif_per_kg * 5)` menghitung perkalian nilai secara langsung di dalam database, klausa `AS` memberikan alias (nama pengganti) pada kolom hasil hitungan agar mudah dipahami, dan `LIMIT` membatasi jumlah baris output.
- **Dipakai Kapan:** Digunakan ketika perlu melakukan kalkulasi matematika langsung pada kolom numerik (seperti perkalian biaya, diskon, atau simulasi tarif) dan menyajikan nama kolom yang bersih.
- **Kasus:** Menghitung perkiraan ongkos kirim paket 5 kg untuk tiap layanan ekspedisi kurir.

```sql
SELECT 
    nama_kurir, 
    layanan, 
    tarif_per_kg,
    (tarif_per_kg * 5) AS estimasi_ongkir_5kg
FROM kurir_ekspedisi
LIMIT 5;
```

**Pembahasan Logika Analis:**
- **Perhitungan Langsung:** Operasi `(tarif_per_kg * 5)` menghitung biaya total paket 5 kg langsung di dalam database tanpa perlu dihitung manual di spreadsheet.
- **Alias Kolom (`AS`):** Memberikan nama `estimasi_ongkir_5kg` agar header laporan ramah dibaca oleh staf Customer Care.
- `LIMIT 5`: Menampilkan 5 sampel kurir pertama sebagai bahan panduan cepat.

**Pratinjau Hasil di TablePlus:**
| nama_kurir | layanan | tarif_per_kg | estimasi_ongkir_5kg |
|---|---|---|---|
| JNE Express | Reguler (2-3 Hari) | 10000 | 50000 |
| JNE Express | YES - Yakin Esok Sampai | 20000 | 100000 |
| SiCepat Express | SiUntung Reguler | 9500 | 47500 |
| SiCepat Express | BEST - Besok Sampai Tujuan | 18500 | 92500 |
| J&T Express | EZ Standard Service | 11000 | 55000 |

---

### Misi 3: Deteksi Stok Barang Kritis di Gudang
- **Divisi Pemohon:** Tim Operasional Gudang
- **Tabel Sumber di TablePlus:** `stok_gudang`
- **Fungsi Query:** Klausa `WHERE` dengan operator perbandingan `<=` menyaring baris data yang nilainya memenuhi batas tertentu, dan klausa `ORDER BY ... ASC` mengurutkan data secara menaik (dari angka terkecil ke terbesar).
- **Dipakai Kapan:** Digunakan saat ingin menemukan data yang berada di bawah atau sama dengan ambang batas kritis tertentu dan memprioritaskan nilai yang paling kecil terlebih dahulu.
- **Kasus:** Menampilkan barang-barang gudang yang stok fisiknya tersisa 10 unit ke bawah, diurutkan dari yang persediaannya paling sedikit.

```sql
SELECT 
    stok_id, 
    gudang_id, 
    variasi_id, 
    jumlah_stok
FROM stok_gudang
WHERE jumlah_stok <= 10
ORDER BY jumlah_stok ASC
LIMIT 5;
```

**Pembahasan Logika Analis:**
- `WHERE jumlah_stok <= 10`: Menyaring hanya barang dengan stok fisik 10 unit ke bawah yang masuk kategori kritis.
- `ORDER BY jumlah_stok ASC`: Mengurutkan dari angka stok terkecil (paling sedikit) ke yang lebih banyak. Dengan urutan menaik ini, barang yang tersisa 2 unit langsung berada di posisi teratas daftar prioritas restock.
- `LIMIT 5`: Mengambil 5 barang paling darurat untuk segera dipesan ke pabrik hari ini.

**Pratinjau Hasil di TablePlus:**
| stok_id | gudang_id | variasi_id | jumlah_stok |
|---|---|---|---|
| 125 | 5 | 25 | 2 |
| 132 | 2 | 27 | 2 |
| 153 | 3 | 31 | 2 |
| 176 | 1 | 36 | 2 |
| 183 | 3 | 37 | 2 |

---

### Misi 4: Riset Masukan Berharga dari Ulasan Netral
- **Divisi Pemohon:** Tim Product & Customer Experience
- **Tabel Sumber di TablePlus:** `ulasan_produk`
- **Fungsi Query:** Operator `=` menyaring nilai yang persis cocok, operator logika `AND` menggabungkan dua kondisi sehingga kedua syarat harus bernilai benar, dan operator `IS NOT NULL` menyaring kolom agar hanya data yang memiliki teks (bukan nilai kosong/NULL) yang ditarik.
- **Dipakai Kapan:** Digunakan ketika perlu memfilter data dengan beberapa kriteria sekaligus dan memastikan bahwa data pada kolom tertentu benar-benar terisi atau tidak kosong.
- **Kasus:** Mengambil ulasan pelanggan yang memberikan rating netral (bintang 3) dan memiliki komentar tertulis.

```sql
SELECT 
    ulasan_id, 
    produk_id, 
    rating, 
    komentar
FROM ulasan_produk
WHERE rating = 3 
  AND komentar IS NOT NULL
LIMIT 5;
```

**Pembahasan Logika Analis:**
- `WHERE rating = 3`: Memfokuskan analisis hanya pada ulasan dengan skor netral (bintang 3).
- `AND komentar IS NOT NULL`: Memastikan bahwa pembeli benar-benar mengisi teks ulasan. Di SQL standar, nilai kosong (`NULL`) tidak boleh dibandingkan dengan `= NULL` atau `<> NULL`, melainkan harus menggunakan `IS NOT NULL`.
- `LIMIT 5`: Mengambil 5 sampel ulasan pertama untuk dianalisis tim produk.

**Pratinjau Hasil di TablePlus:**
| ulasan_id | produk_id | rating | komentar |
|---|---|---|---|
| 4 | 15 | 3 | Kualitas bahan sangat bagus, jahitan rapi, ukuran pas di badan. |
| 8 | 5 | 3 | Harga bersaing dibanding toko sebelah, respon admin cepat dan ramah. |
| 9 | 8 | 3 | Packing aman sekali dengan bubble wrap tebal dan kardus tebal. |
| 18 | 6 | 3 | Bintang 5! Sangat memuaskan, repeat order kedua kalinya. |
| 35 | 22 | 3 | Bintang 5! Sangat memuaskan, repeat order kedua kalinya. |

---

### Misi 5: Pemetaan Kota Pemasok Tanpa Duplikasi
- **Divisi Pemohon:** Tim Pengadaan (Procurement)
- **Tabel Sumber di TablePlus:** `supplier`
- **Fungsi Query:** Kata kunci `DISTINCT` berfungsi menyaring dan menghilangkan baris duplikat sehingga setiap nilai unik hanya muncul 1 kali, dan klausa `ORDER BY ... ASC` mengurutkan teks secara alfabetis dari A sampai Z.
- **Dipakai Kapan:** Digunakan saat sebuah kolom memuat banyak nilai yang sama berulang kali dan kita hanya membutuhkan daftar nilai uniknya saja.
- **Kasus:** Mengambil daftar kota tempat rekanan supplier berada tanpa ada nama kota yang berulang, diurutkan dari A ke Z.

```sql
SELECT DISTINCT 
    kota
FROM supplier
ORDER BY kota ASC;
```

**Pembahasan Logika Analis:**
- `SELECT DISTINCT kota`: Menghapus duplikasi nama kota. Jika ada beberapa pemasok berdomisili di kota yang sama, nama kota tersebut hanya ditampilkan 1 kali dalam laporan.
- `ORDER BY kota ASC`: Mengurutkan nama kota secara alfabetis dari abjad A sampai Z untuk memudahkan pencarian rute logistik.

**Pratinjau Hasil di TablePlus:**
| kota |
|---|
| Balikpapan |
| Bandung |
| Denpasar |
| Jakarta Pusat |
| Makassar |
| Medan |
| Semarang |
| Surabaya |
| Tangerang |
| Yogyakarta |

---

### Misi 6: Perbandingan Saluran Pembayaran Digital
- **Divisi Pemohon:** Tim Pembayaran & Finansial
- **Tabel Sumber di TablePlus:** `metode_pembayaran`
- **Fungsi Query:** Operator `IN (...)` dalam klausa `WHERE` berfungsi mencocokkan data kolom dengan sekumpulan nilai anggota tertentu, dan klausa `ORDER BY` bertingkat mengurutkan baris pertama berdasarkan `biaya_admin` (terendah ke tertinggi) lalu dilanjutkan berdasarkan abjad `nama_metode` jika nilai biayanya sama.
- **Dipakai Kapan:** Digunakan saat ingin menyaring data yang cocok dengan salah satu dari beberapa pilihan nilai tertentu secara ringkas dan rapi, serta mengatur urutan tampilan dengan prioritas ganda.
- **Kasus:** Menemukan metode pembayaran yang bertipe Virtual Account atau E-Wallet, lalu mengurutkannya dari biaya admin paling murah dan nama metode secara alfabetis.

```sql
SELECT 
    nama_metode, 
    tipe, 
    biaya_admin
FROM metode_pembayaran
WHERE tipe IN ('Virtual Account', 'E-Wallet')
ORDER BY biaya_admin ASC, nama_metode ASC;
```

**Pembahasan Logika Analis:**
- `WHERE tipe IN ('Virtual Account', 'E-Wallet')`: Operator `IN` menyaring data berdasarkan kumpulan nilai, jauh lebih ringkas dan bersih dibanding menggunakan rangkaian `OR`.
- `ORDER BY biaya_admin ASC, nama_metode ASC`: Pengurutan bertingkat. Data diurutkan dari biaya admin termurah ke termahal; jika biaya adminnya sama, urutan dilanjutkan berdasarkan alfabetis nama metode dari A ke Z.

**Pratinjau Hasil di TablePlus:**
| nama_metode | tipe | biaya_admin |
|---|---|---|
| GoPay Indonesia | E-Wallet | 1000 |
| OVO Cash | E-Wallet | 1000 |
| ShopeePay Digital | E-Wallet | 1000 |
| BNI Virtual Account | Virtual Account | 1500 |
| BRI Virtual Account (BRIVA) | Virtual Account | 1500 |
| BCA Virtual Account | Virtual Account | 2000 |
| Mandiri Virtual Account | Virtual Account | 2000 |

---

### Misi 7: Seleksi Voucher untuk Belanja Skala Menengah
- **Divisi Pemohon:** Tim Promosi & Kampanye
- **Tabel Sumber di TablePlus:** `voucher_promo`
- **Fungsi Query:** Operator `BETWEEN ... AND ...` dalam klausa `WHERE` berfungsi menyaring nilai kolom numerik yang berada di antara batas bawah dan batas atas secara inklusif (kedua nilai batas ikut masuk dalam hasil), dan `ORDER BY ... ASC` mengurutkannya dari nilai terkecil ke terbesar.
- **Dipakai Kapan:** Digunakan saat mencari data angka atau rentang tanggal yang berada di antara dua batas nilai tertentu.
- **Kasus:** Menampilkan kupon promo yang menetapkan syarat minimal belanja di rentang Rp 100.000 hingga Rp 250.000.

```sql
SELECT 
    kode_voucher, 
    tipe_diskon, 
    nilai_diskon, 
    minimal_belanja
FROM voucher_promo
WHERE minimal_belanja BETWEEN 100000 AND 250000
ORDER BY minimal_belanja ASC;
```

**Pembahasan Logika Analis:**
- `WHERE minimal_belanja BETWEEN 100000 AND 250000`: Operator `BETWEEN` menyaring rentang nilai secara inklusif (angka 100.000 dan 250.000 ikut dihitung masuk).
- `ORDER BY minimal_belanja ASC`: Mengurutkan dari syarat belanja yang paling ringan ke yang lebih tinggi.

**Pratinjau Hasil di TablePlus:**
| kode_voucher | tipe_diskon | nilai_diskon | minimal_belanja |
|---|---|---|---|
| ONGKIRGRATIS15 | Nominal | 15000 | 100000 |
| BEAUTYGLOW15 | Persen | 15 | 120000 |
| DISKONMEMBER25 | Nominal | 25000 | 150000 |
| FASHIONFEST20 | Persen | 20 | 200000 |
| SUPERDEAL35K | Nominal | 35000 | 250000 |

---

### Misi 8: Audit Legalitas Rekanan Berbadan Hukum PT
- **Divisi Pemohon:** Tim Legal & Manajemen Vendor
- **Tabel Sumber di TablePlus:** `supplier`
- **Fungsi Query:** Operator `LIKE` berfungsi mencocokkan pola string/teks, dan karakter wildcard tanda persen (`%`) bertindak sebagai pengganti nol atau lebih karakter apa pun, sehingga `'PT%'` akan menyaring data yang diawali teks 'PT'.
- **Dipakai Kapan:** Digunakan saat ingin mencari kecocokan teks yang fleksibel, seperti mencari awalan kata tertentu, akhiran kata, atau potongan kata di tengah teks.
- **Kasus:** Mencari rekanan supplier yang nama perusahaannya berawalan kata 'PT'.

```sql
SELECT 
    supplier_id, 
    nama_supplier, 
    kontak_person, 
    kota
FROM supplier
WHERE nama_supplier LIKE 'PT%'
ORDER BY nama_supplier ASC;
```

**Pembahasan Logika Analis:**
- `WHERE nama_supplier LIKE 'PT%'`: Simbol wildcard `%` di belakang huruf 'PT' mencocokkan semua teks yang berawalan dengan kata 'PT' tanpa membatasi panjang karakternya.
- `ORDER BY nama_supplier ASC`: Mengurutkan daftar perusahaan dari A ke Z agar mempermudah tim audit legal mengecek kelengkapan berkas.

**Pratinjau Hasil di TablePlus:**
| supplier_id | nama_supplier | kontak_person | kota |
|---|---|---|---|
| 9 | PT Banten Niaga Cipta | Siti Maryam | Tangerang |
| 8 | PT Celebes Global Logistik | Irfan Syamsuddin | Makassar |
| 1 | PT Nusantara Mega Distribusi | Budi Hartono | Jakarta Pusat |
| 3 | PT Sinergi Abadi Sentosa | Dewi Sartika | Bandung |
| 4 | PT Surya Graha Perkasa | Ahmad Rizal | Semarang |
| 6 | PT Tri Tunggal Sejahtera | Faisal Lubis | Medan |

---

### Misi 9: Paginasi Etalase Produk Premium Halaman ke-2
- **Divisi Pemohon:** Tim Front-End & Pengembang Web
- **Tabel Sumber di TablePlus:** `variasi_produk`
- **Fungsi Query:** Klausa `ORDER BY ... DESC` mengurutkan baris dari nilai terbesar ke terkecil, klausa `OFFSET` berfungsi melompati (melewati) sejumlah baris data awal, dan klausa `LIMIT` membatasi berapa baris data yang diambil setelah baris yang dilewati.
- **Dipakai Kapan:** Digunakan saat mengimplementasikan fitur paginasi pada aplikasi web/mobile untuk memecah daftar data panjang menjadi halaman per halaman (halaman 1, 2, 3, dst.).
- **Kasus:** Mengambil data variasi produk untuk halaman ke-2 etalase (produk dengan harga jual tertinggi peringkat 6 sampai 10).

```sql
SELECT 
    sku, 
    warna, 
    ukuran, 
    harga_jual
FROM variasi_produk
ORDER BY harga_jual DESC
LIMIT 5 OFFSET 5;
```

**Pembahasan Logika Analis:**
- `ORDER BY harga_jual DESC`: Mengurutkan dari produk berharga paling mahal ke paling terjangkau.
- `LIMIT 5 OFFSET 5`: Logika paginasi aplikasi. `OFFSET 5` melompati 5 produk termahal pertama (halaman 1), kemudian `LIMIT 5` mengambil 5 produk berikutnya untuk mengisi slot halaman ke-2.

**Pratinjau Hasil di TablePlus:**
| sku | warna | ukuran | harga_jual |
|---|---|---|---|
| SAM-S24U-BLK-256 | Titanium Black | 256GB | 19999000 |
| SAM-ZFL5-GRA-512 | Graphite | 512GB | 16499000 |
| SAM-ZFL5-MNT-256 | Mint Green | 256GB | 14499000 |
| SNY-WH5-BLK | Black Matte | Over-Ear | 5499000 |
| SNY-WH5-SLV | Silver Platinum | Over-Ear | 5499000 |

---

### Misi 10: Investigasi Transaksi Bernilai Besar yang Tertahan
- **Divisi Pemohon:** Tim Keuangan & Manajemen Risiko
- **Tabel Sumber di TablePlus:** `pesanan`
- **Fungsi Query:** Operator perbandingan `>=` menyaring batas minimal angka, operator logika `OR` memberikan syarat alternatif (salah satu boleh benar), operator logika `AND` mewajibkan syarat kedua bernilai benar, dan tanda kurung `( ... )` mengelompokkan urutan logika agar syarat `OR` dievaluasi bersama terlebih dahulu sebelum dievaluasi dengan `AND`.
- **Dipakai Kapan:** Digunakan saat membuat kriteria pencarian majemuk yang memadukan syarat wajib dengan syarat pilihan bersarang agar tidak terjadi kesalahan logika penyaringan.
- **Kasus:** Menemukan transaksi bernilai Rp 50.000.000 ke atas yang berstatus 'Dibatalkan' atau 'Menunggu Pembayaran'.

```sql
SELECT 
    nomor_invoice, 
    tanggal_pesanan, 
    status_pesanan, 
    ongkos_kirim, 
    total_bayar
FROM pesanan
WHERE (status_pesanan = 'Dibatalkan' OR status_pesanan = 'Menunggu Pembayaran')
  AND total_bayar >= 50000000
ORDER BY total_bayar DESC
LIMIT 5;
```

**Pembahasan Logika Analis:**
- **Tanda Kurung `( ... )`:** Wajib membungkus kondisi status agar klausa `OR` dihitung sebagai satu kesatuan filter status sebelum dievaluasi bersama kondisi `AND total_bayar >= 50000000`. Jika tanpa tanda kurung, aturan presedensi operator SQL akan menyebabkan data transaksi yang terambil salah.
- `ORDER BY total_bayar DESC`: Mengurutkan transaksi fantastis dari nominal terbesar agar tim mitigasi bisa memprioritaskan penyelamatan omzet tertinggi.
- `LIMIT 5`: Mengambil 5 faktur paling prioritas untuk ditindaklanjuti.

**Pratinjau Hasil di TablePlus:**
| nomor_invoice | tanggal_pesanan | status_pesanan | ongkos_kirim | total_bayar |
|---|---|---|---|---|
| INV/20240613/02323 | 2024-06-13 16:10:13 | Dibatalkan | 30000 | 73043000 |
| INV/20240310/01450 | 2024-03-10 17:35:50 | Dibatalkan | 60000 | 72156000 |
| INV/20240427/02253 | 2024-04-27 18:00:44 | Dibatalkan | 210000 | 70802000 |
| INV/20240719/01108 | 2024-07-19 14:43:40 | Dibatalkan | 95000 | 70675000 |
| INV/20240520/01813 | 2024-05-20 17:34:53 | Dibatalkan | 100000 | 69946000 |

---

### Misi 11: Rekapitulasi Pendapatan & Volume Transaksi per Metode Pembayaran
- **Divisi Pemohon:** Tim Keuangan (Finance) & Tim Operasional Pembayaran
- **Tabel Sumber di TablePlus:** `pesanan` dan `metode_pembayaran`
- **Fungsi Query:** Klausa `JOIN` menggabungkan dua tabel berdasarkan kolom relasi (`p.metode_id = mp.metode_id`), klausa `GROUP BY` mengelompokkan baris data yang bernilai sama pada kolom kategori (`mp.nama_metode`), fungsi agregasi `COUNT()` menghitung total baris pesanan, `SUM()` menghitung total penerimaan uang, dan `AVG()` menghitung rata-rata nilai per transaksi (dibulatkan dengan `ROUND()`).
- **Dipakai Kapan:** Digunakan saat ingin membuat rangkuman ringkas (rekapitulasi agregat) dari ribuan baris transaksi berdasarkan kelompok atau kategori tertentu.
- **Kasus:** Menghitung total frekuensi pesanan, total akumulasi pendapatan, dan rata-rata nominal transaksi untuk setiap metode pembayaran, diurutkan dari pendapatan tertinggi.

```sql
SELECT 
    mp.nama_metode,
    COUNT(p.pesanan_id) AS total_transaksi,
    SUM(p.total_bayar) AS total_pendapatan,
    ROUND(AVG(p.total_bayar), 0) AS rata_rata_transaksi
FROM pesanan p
JOIN metode_pembayaran mp ON p.metode_id = mp.metode_id
GROUP BY mp.nama_metode
ORDER BY total_pendapatan DESC;
```

**Pembahasan Logika Analis:**
- `JOIN metode_pembayaran mp ON p.metode_id = mp.metode_id`: Menghubungkan data pesanan dengan master metode pembayaran agar laporan menampilkan nama metode yang mudah dipahami manusia (`mp.nama_metode`), bukan hanya kode angka ID.
- `GROUP BY mp.nama_metode`: Mengelompokkan ribuan baris transaksi pesanan menjadi 1 baris ringkasan per metode pembayaran.
- `COUNT(p.pesanan_id)`: Menghitung berapa kali metode tersebut dipilih oleh pembeli dalam transaksi toko.
- `SUM(p.total_bayar)`: Menjumlahkan seluruh nominal uang yang berhasil dialirkan melalui saluran pembayaran terkait.
- `ROUND(AVG(p.total_bayar), 0)`: Menghitung rata-rata nilai transaksi (*Average Order Value*) dan membulatkan desimalnya agar angka rapi dibaca.
- `ORDER BY total_pendapatan DESC`: Mengurutkan saluran pembayaran dari kontributor omzet terbesar hingga terkecil.

**Pratinjau Hasil di TablePlus:**
| nama_metode | total_transaksi | total_pendapatan | rata_rata_transaksi |
|---|---|---|---|
| COD (Bayar Tunai di Tempat) | 290 | 4980457000 | 17173990.0 |
| OVO Cash | 280 | 4903827500 | 17513670.0 |
| BNI Virtual Account | 297 | 4560759850 | 15356094.0 |
| GoPay Indonesia | 285 | 4555939250 | 15985752.0 |
| ShopeePay Digital | 272 | 4322490975 | 15891511.0 |
| BCA Virtual Account | 276 | 4178744250 | 15140378.0 |
| Kartu Kredit / Debit Online Visa/Mastercard | 279 | 4125788850 | 14787774.0 |
| QRIS Nasional (Semua Bank / e-Wallet) | 293 | 4001566425 | 13657223.0 |
| Mandiri Virtual Account | 258 | 3776091500 | 14636014.0 |
| BRI Virtual Account (BRIVA) | 283 | 3653193850 | 12908812.0 |

---

### Misi 12: Identifikasi Kota Pasar Potensial Beromzet Tinggi
- **Divisi Pemohon:** Tim Logistik & Tim Operasional
- **Tabel Sumber di TablePlus:** `pesanan` dan `alamat_pelanggan`
- **Fungsi Query:** Klausa `JOIN` menghubungkan data pesanan ke data alamat pengiriman, klausa `GROUP BY` mengelompokkan baris pesanan berdasarkan kota tujuan kirim (`ap.kota`), fungsi agregasi `COUNT()`, `SUM()`, `AVG()` menghitung ringkasan data tiap kota, dan klausa `HAVING` menyaring hasil kelompok data agar hanya menampilkan kelompok kota dengan total omzet minimal Rp 1,8 Miliar (`HAVING SUM(p.total_bayar) >= 1800000000`).
- **Dipakai Kapan:** Digunakan ketika kita perlu memfilter data berdasarkan hasil perhitungan fungsi agregasi (seperti total atau rata-rata), yang mana filter semacam ini tidak bisa dilakukan oleh klausa `WHERE`.
- **Kasus:** Menemukan kota-kota pengiriman yang akumulasi total belanjanya telah mencapai minimal Rp 1.800.000.000 (Rp 1,8 Miliar).

```sql
SELECT 
    ap.kota,
    COUNT(p.pesanan_id) AS total_pesanan,
    SUM(p.total_bayar) AS total_omzet,
    ROUND(AVG(p.total_bayar), 0) AS rata_rata_transaksi
FROM pesanan p
JOIN alamat_pelanggan ap ON p.alamat_kirim_id = ap.alamat_id
GROUP BY ap.kota
HAVING SUM(p.total_bayar) >= 1800000000
ORDER BY total_omzet DESC;
```

**Pembahasan Logika Analis:**
- `JOIN alamat_pelanggan ap ON p.alamat_kirim_id = ap.alamat_id`: Menghubungkan pesanan ke tabel alamat pelanggan untuk mengetahui kota tujuan pengiriman paket.
- `GROUP BY ap.kota`: Mengelompokkan seluruh transaksi berdasarkan kota domisili pengiriman pembeli.
- `HAVING SUM(p.total_bayar) >= 1800000000`: Memfilter data **setelah** pengelompokan selesai dihitung. Perlu diingat, klausa `WHERE` tidak bisa digunakan untuk memfilter fungsi agregasi seperti `SUM()`, sehingga SQL mewajibkan penggunaan klausa `HAVING`.
- `ORDER BY total_omzet DESC`: Mengurutkan kota paling produktif secara finansial dari nominal terbesar ke nominal terkecil.

**Pratinjau Hasil di TablePlus:**
| kota | total_pesanan | total_omzet | rata_rata_transaksi |
|---|---|---|---|
| Balikpapan | 132 | 2140936500 | 16219216.0 |
| Denpasar | 101 | 2104629700 | 20837918.0 |
| Samarinda | 99 | 1997118000 | 20172909.0 |
| Banjarmasin | 108 | 1928808750 | 17859340.0 |
| Medan | 143 | 1894733500 | 13249885.0 |
| Jakarta Selatan | 122 | 1826917000 | 14974730.0 |
