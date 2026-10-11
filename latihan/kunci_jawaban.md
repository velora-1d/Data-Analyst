# Kunci Jawaban & Pembahasan: Latihan Mandiri SQL

Dokumen ini berisi solusi query SQL terverifikasi di [`database/ecommerce.db`](../database/ecommerce.db), pembahasan logika klausa, dan pratinjau hasil data untuk seluruh soal pada [`soal_latihan.md`](./soal_latihan.md).

---

### Jawaban Soal 1: Audit Kupon Promosi & Kuota Penggunaan (SELECT & LIMIT)
**Instruksi:** Tampilkan `kode_voucher`, `tipe_diskon`, `nilai_diskon`, dan `kuota_pemakaian` dari tabel `voucher_promo` sebanyak 5 baris pertama.

```sql
SELECT 
    kode_voucher, 
    tipe_diskon, 
    nilai_diskon, 
    kuota_pemakaian
FROM voucher_promo
LIMIT 5;
```

**Pembahasan Logika:**
- `SELECT kode_voucher, tipe_diskon, nilai_diskon, kuota_pemakaian`: Menarik kolom-kolom spesifik untuk kebutuhan promosi tanpa memuat kolom minimal belanja.
- `FROM voucher_promo`: Menunjuk tabel sumber data promo voucher.
- `LIMIT 5`: Menghentikan pembacaan engine database setelah 5 baris pertama ditemukan, sangat hemat bandwidth dan memori.

**Pratinjau Hasil di ecommerce.db:**
| kode_voucher | tipe_diskon | nilai_diskon | kuota_pemakaian |
|---|---|---|---|
| GAJIANHEMAT50 | Nominal | 50000 | 1000 |
| DISKONMEMBER25 | Nominal | 25000 | 2500 |
| ONGKIRGRATIS15 | Nominal | 15000 | 5000 |
| ELEKTRONIK100K | Nominal | 100000 | 800 |
| FASHIONFEST20 | Persen | 20 | 1500 |

---

### Jawaban Soal 2: Kalkulasi Ongkos Kirim Paket Berat (Kalkulasi Matematika & Kolom Alias AS)
**Instruksi:** Tampilkan `nama_kurir`, `layanan`, `tarif_per_kg`, dan kalkulasi tarif 5 kg (`tarif_per_kg * 5`) dengan alias `estimasi_ongkir_5kg` dari tabel `kurir_ekspedisi` (5 baris).

```sql
SELECT 
    nama_kurir, 
    layanan, 
    tarif_per_kg,
    (tarif_per_kg * 5) AS estimasi_ongkir_5kg
FROM kurir_ekspedisi
LIMIT 5;
```

**Pembahasan Logika:**
- `(tarif_per_kg * 5)`: Melakukan operasi perkalian matematis langsung di level database engine.
- `AS estimasi_ongkir_5kg`: Memberi nama baru pada header kolom hasil hitungan agar ramah dibaca tim bisnis (tanpa nama aneh seperti `tarif_per_kg * 5`).
- `LIMIT 5`: Membatasi tampilan 5 opsi kurir pertama.

**Pratinjau Hasil di ecommerce.db:**
| nama_kurir | layanan | tarif_per_kg | estimasi_ongkir_5kg |
|---|---|---|---|
| JNE Express | Reguler (2-3 Hari) | 10000 | 50000 |
| JNE Express | YES - Yakin Esok Sampai | 20000 | 100000 |
| SiCepat Express | SiUntung Reguler | 9500 | 47500 |
| SiCepat Express | BEST - Besok Sampai Tujuan | 18500 | 92500 |
| J&amp;T Express | EZ Standard Service | 11000 | 55000 |

---

### Jawaban Soal 3: Peringatan Stok Menipis di Gudang (WHERE & Operator <=)
**Instruksi:** Saring stok gudang dari tabel `stok_gudang` yang berjumlah 10 unit ke bawah (`jumlah_stok <= 10`), urutkan dari yang paling sedikit (`ASC`), batasi 5 baris.

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

**Pembahasan Logika:**
- `WHERE jumlah_stok <= 10`: Menyaring hanya baris data fisik yang memenuhi ambang batas kritis (kondisi boolean bernilai True).
- `ORDER BY jumlah_stok ASC`: Mengurutkan dari stok yang paling kritis (terkecil) ke yang lebih banyak agar prioritas restock tertangani pertama kali.
- `LIMIT 5`: Mengambil 5 varian barang teratas yang paling mendesak untuk di-restock.

**Pratinjau Hasil di ecommerce.db:**
| stok_id | gudang_id | variasi_id | jumlah_stok |
|---|---|---|---|
| 125 | 5 | 25 | 2 |
| 132 | 2 | 27 | 2 |
| 153 | 3 | 31 | 2 |
| 176 | 1 | 36 | 2 |
| 183 | 3 | 37 | 2 |

---

### Jawaban Soal 4: Kurasi Ulasan Tertulis Pelanggan (WHERE, AND, & IS NOT NULL)
**Instruksi:** Filter tabel `ulasan_produk` untuk ulasan bernilai `rating = 3` DAN kolom `komentar IS NOT NULL`. Batasi 5 baris.

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

**Pembahasan Logika:**
- `rating = 3`: Memfilter ulasan dengan skor netral (bintang 3).
- `AND komentar IS NOT NULL`: Memastikan bahwa pembeli benar-benar mengetikkan ulasan teks (bukan hanya memberikan bintang tanpa komentar). Ingat: jangan gunakan `<> NULL` karena di SQL standar nilai NULL wajib diuji dengan `IS NOT NULL`.

**Pratinjau Hasil di ecommerce.db:**
| ulasan_id | produk_id | rating | komentar |
|---|---|---|---|
| 4 | 15 | 3 | Kualitas bahan sangat bagus, jahitan rapi, ukuran pas di badan. |
| 8 | 5 | 3 | Harga bersaing dibanding toko sebelah, respon admin cepat dan ramah. |
| 9 | 8 | 3 | Packing aman sekali dengan bubble wrap tebal dan kardus tebal. |
| 18 | 6 | 3 | Bintang 5! Sangat memuaskan, repeat order kedua kalinya. |
| 35 | 22 | 3 | Bintang 5! Sangat memuaskan, repeat order kedua kalinya. |

---

### Jawaban Soal 5: Sebaran Kota Pemasok Logistik Tanpa Duplikasi (DISTINCT & ORDER BY)
**Instruksi:** Dapatkan nama kota unik dari tabel `supplier` dan urutkan secara ascending (A ke Z).

```sql
SELECT DISTINCT 
    kota
FROM supplier
ORDER BY kota ASC;
```

**Pembahasan Logika:**
- `SELECT DISTINCT kota`: Menghapus semua nama kota yang duplikat sehingga setiap kota hanya muncul tepat 1 kali.
- `ORDER BY kota ASC`: Mengurutkan nama kota secara alfabetis dari A sampai Z.

**Pratinjau Hasil di ecommerce.db:**
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

### Jawaban Soal 6: Analisis Saluran Pembayaran Perbankan Digital (Operator IN)
**Instruksi:** Tampilkan metode pembayaran dari tabel `metode_pembayaran` yang bertipe `'Virtual Account'` atau `'E-Wallet'`, urutkan dari biaya admin termurah.

```sql
SELECT 
    nama_metode, 
    tipe, 
    biaya_admin
FROM metode_pembayaran
WHERE tipe IN ('Virtual Account', 'E-Wallet')
ORDER BY biaya_admin ASC, nama_metode ASC;
```

**Pembahasan Logika:**
- `WHERE tipe IN ('Virtual Account', 'E-Wallet')`: Jauh lebih ringkas dan elegan dibanding menulis multi-kondisi `OR` (`WHERE tipe = 'Virtual Account' OR tipe = 'E-Wallet'`).
- `ORDER BY biaya_admin ASC, nama_metode ASC`: Pengurutan bertingkat. Data diurutkan berdasarkan `biaya_admin` terkecil dulu; jika ada biaya admin yang sama, urutkan berdasarkan `nama_metode` dari A ke Z.

**Pratinjau Hasil di ecommerce.db:**
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

### Jawaban Soal 7: Evaluasi Promo Belanja Skala Menengah (Operator BETWEEN)
**Instruksi:** Saring voucher dari tabel `voucher_promo` yang memiliki `minimal_belanja` antara Rp 100.000 sampai Rp 250.000, urutkan dari yang terendah.

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

**Pembahasan Logika:**
- `WHERE minimal_belanja BETWEEN 100000 AND 250000`: Menyaring rentang nilai secara inklusif (sama artinya dengan `minimal_belanja >= 100000 AND minimal_belanja <= 250000`).
- `ORDER BY minimal_belanja ASC`: Mengurutkan dari syarat transaksi terendah ke tertinggi.

**Pratinjau Hasil di ecommerce.db:**
| kode_voucher | tipe_diskon | nilai_diskon | minimal_belanja |
|---|---|---|---|
| ONGKIRGRATIS15 | Nominal | 15000 | 100000 |
| BEAUTYGLOW15 | Persen | 15 | 120000 |
| DISKONMEMBER25 | Nominal | 25000 | 150000 |
| FASHIONFEST20 | Persen | 20 | 200000 |
| SUPERDEAL35K | Nominal | 35000 | 250000 |

---

### Jawaban Soal 8: Audit Legalitas Identitas Vendor Supplier (Pencarian Teks LIKE)
**Instruksi:** Cari vendor dari tabel `supplier` yang namanya diawali dengan `'PT'`, urutkan nama supplier secara ascending.

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

**Pembahasan Logika:**
- `LIKE 'PT%'`: Wildcard `%` di akhir kata berarti mencocokkan teks yang diawali huruf 'PT' dan diikuti oleh karakter apa pun setelahnya.
- `ORDER BY nama_supplier ASC`: Mengurutkan daftar perusahaan dari abjad A ke Z.

**Pratinjau Hasil di ecommerce.db:**
| supplier_id | nama_supplier | kontak_person | kota |
|---|---|---|---|
| 9 | PT Banten Niaga Cipta | Siti Maryam | Tangerang |
| 8 | PT Celebes Global Logistik | Irfan Syamsuddin | Makassar |
| 1 | PT Nusantara Mega Distribusi | Budi Hartono | Jakarta Pusat |
| 3 | PT Sinergi Abadi Sentosa | Dewi Sartika | Bandung |
| 4 | PT Surya Graha Perkasa | Ahmad Rizal | Semarang |
| 6 | PT Tri Tunggal Sejahtera | Faisal Lubis | Medan |

---

### Jawaban Soal 9: Paginasi Leaderboard Produk Mewah Halaman ke-2 (ORDER BY, LIMIT, OFFSET)
**Instruksi:** Tampilkan 5 variasi produk termahal halaman ke-2 (peringkat 6 s/d 10 termahal) dari tabel `variasi_produk`.

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

**Pembahasan Logika:**
- `ORDER BY harga_jual DESC`: Mengurutkan harga jual dari yang paling mahal (jutaan rupiah) ke yang paling murah.
- `LIMIT 5 OFFSET 5`: Rumus paginasi standar di mana `OFFSET 5` melompati 5 baris pertama (halaman 1), dan `LIMIT 5` mengambil 5 baris berikutnya (halaman 2).

**Pratinjau Hasil di ecommerce.db:**
| sku | warna | ukuran | harga_jual |
|---|---|---|---|
| SAM-S24U-BLK-256 | Titanium Black | 256GB | 19999000 |
| SAM-ZFL5-GRA-512 | Graphite | 512GB | 16499000 |
| SAM-ZFL5-MNT-256 | Mint Green | 256GB | 14499000 |
| SNY-WH5-BLK | Black Matte | Over-Ear | 5499000 |
| SNY-WH5-SLV | Silver Platinum | Over-Ear | 5499000 |

---

### Jawaban Soal 10: Audit Risiko Transaksi Tertunda & Batal (Multi-Kondisi AND, OR, Kurung)
**Instruksi:** Filter pesanan di tabel `pesanan` yang berstatus `'Dibatalkan'` atau `'Menunggu Pembayaran'` dan bernilai `total_bayar >= 50000000`. Batasi 5 baris dengan urutan total bayar terbesar.

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

**Pembahasan Logika:**
- `(status_pesanan = 'Dibatalkan' OR status_pesanan = 'Menunggu Pembayaran')`: Wajib dibungkus tanda kurung `( ... )` agar klausa `OR` diproses sebagai satu kelompok logika sebelum disandingkan dengan operator `AND`.
- `AND total_bayar >= 50000000`: Memastikan hanya transaksi bernilai sangat besar (kategori risiko tinggi) yang disaring.
- `ORDER BY total_bayar DESC`: Mengurutkan transaksi fantastis dari yang paling jumbo.

**Pratinjau Hasil di ecommerce.db:**
| nomor_invoice | tanggal_pesanan | status_pesanan | ongkos_kirim | total_bayar |
|---|---|---|---|---|
| INV/20240613/02323 | 2024-06-13 16:10:13 | Dibatalkan | 30000 | 73043000 |
| INV/20240310/01450 | 2024-03-10 17:35:50 | Dibatalkan | 60000 | 72156000 |
| INV/20240427/02253 | 2024-04-27 18:00:44 | Dibatalkan | 210000 | 70802000 |
| INV/20240719/01108 | 2024-07-19 14:43:40 | Dibatalkan | 95000 | 70675000 |
| INV/20240520/01813 | 2024-05-20 17:34:53 | Dibatalkan | 100000 | 69946000 |
