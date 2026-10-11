# Kunci Jawaban & Pembahasan: Studi Kasus Analis Data E-Commerce

Dokumen ini berisi solusi query SQL resmi untuk memecahkan 10 misi studi kasus pada [`soal_latihan.md`](./soal_latihan.md). Seluruh query telah diuji langsung pada database transaksi nyata: [`database/ecommerce.db`](../database/ecommerce.db) menggunakan **TablePlus**.

---

### Misi 1: Cek Sampel Kupon Promo Aktif
- **Divisi Pemohon:** Tim Marketing
- **Tabel Sumber di TablePlus:** `voucher_promo`

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
