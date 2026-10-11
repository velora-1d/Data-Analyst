# Kunci Jawaban & Pembahasan: Query Dasar & Filtering

Dokumen ini berisi kunci jawaban query SQL, penjelasan logika sintaks, dan pratinjau hasil query untuk seluruh soal pada [`soal_latihan.md`](./soal_latihan.md).

---

### Jawaban Soal 1: SELECT & LIMIT
**Instruksi:** Tampilkan nama produk dan berat gram untuk 5 produk pertama dari tabel `produk`.

```sql
SELECT 
    nama_produk, 
    berat_gram
FROM produk
LIMIT 5;
```

**Pembahasan:**
- Klausa `SELECT` menentukan kolom mana saja yang ingin diambil (`nama_produk`, `berat_gram`).
- `FROM produk` merujuk ke tabel target.
- `LIMIT 5` membatasi agar database hanya mengembalikan 5 baris pertama, mencegah transfer data berlebih.

---

### Jawaban Soal 2: Pemberian Alias (AS) & Kalkulasi Matematika
**Instruksi:** Tampilkan SKU, harga modal, harga jual, dan selisih profit (`keuntungan_nominal`) untuk 5 variasi produk.

```sql
SELECT 
    sku,
    harga_modal,
    harga_jual,
    (harga_jual - harga_modal) AS keuntungan_nominal
FROM variasi_produk
LIMIT 5;
```

**Pembahasan:**
- Ekspresi aritmatika `(harga_jual - harga_modal)` menghitung nilai laba kotor per satuan unit.
- Kata kunci `AS keuntungan_nominal` memberikan nama alias yang lebih representatif dan mudah dibaca oleh aplikasi frontend/laporan.

---

### Jawaban Soal 3: Filter Numerik (WHERE & Operator >=)
**Instruksi:** Tampilkan pesanan selesai dengan `total_bayar >= 1000000`, diurutkan dari termurah, ambil 5 baris.

```sql
SELECT 
    nomor_invoice, 
    tanggal_pesanan, 
    total_bayar, 
    status_pesanan
FROM pesanan
WHERE status_pesanan = 'Selesai'
  AND total_bayar >= 1000000
ORDER BY total_bayar ASC
LIMIT 5;
```

**Pembahasan:**
- Operator logika `AND` memastikan kedua syarat harus terpenuhi: status pesanan wajib `'Selesai'` DAN nilai pembayaran minimal `1000000`.
- `ORDER BY total_bayar ASC` mengurutkan data dari nominal terkecil ke terbesar.

---

### Jawaban Soal 4: Filter Majemuk String & Tanggal (WHERE, AND)
**Instruksi:** Cari pelanggan wanita yang mendaftar pada atau setelah '2023-01-01', batasi 5 baris.

```sql
SELECT 
    pelanggan_id, 
    nama_lengkap, 
    gender, 
    tanggal_daftar, 
    email
FROM pelanggan
WHERE gender = 'Wanita'
  AND tanggal_daftar >= '2023-01-01'
LIMIT 5;
```

**Pembahasan:**
- Di SQLite, tipe data tanggal disimpan dalam format ISO-8601 standar (`YYYY-MM-DD`).
- Operator perbandingan `>= '2023-01-01'` menyaring transaksi mulai dari 1 Januari 2023 hingga waktu sekarang.

---

### Jawaban Soal 5: DISTINCT & Pengurutan Ganda (ORDER BY)
**Instruksi:** Dapatkan daftar unik kota dan provinsi pengiriman, urutkan provinsi ASC lalu kota ASC, ambil 10 baris.

```sql
SELECT DISTINCT 
    kota, 
    provinsi
FROM alamat_pelanggan
ORDER BY provinsi ASC, kota ASC
LIMIT 10;
```

**Pembahasan:**
- Kata kunci `DISTINCT` bekerja pada kombinasi kolom yang dipilih, menghapus baris duplikat sehingga setiap pasangan kota-provinsi hanya muncul 1 kali.
- `ORDER BY provinsi ASC, kota ASC` menerapkan prioritas pengurutan hierarkis: database mengurutkan provinsi terlebih dahulu, lalu mengurutkan kota di dalam provinsi yang sama.

---

### Jawaban Soal 6: Operator IN
**Instruksi:** Filter pesanan dengan status 'Diproses' atau 'Dikirim', urutkan tanggal pesanan terbaru, ambil 5 baris.

```sql
SELECT 
    nomor_invoice, 
    tanggal_pesanan, 
    status_pesanan, 
    total_bayar
FROM pesanan
WHERE status_pesanan IN ('Diproses', 'Dikirim')
ORDER BY tanggal_pesanan DESC
LIMIT 5;
```

**Pembahasan:**
- `IN ('Diproses', 'Dikirim')` setara dengan penulisan `(status_pesanan = 'Diproses' OR status_pesanan = 'Dikirim')`, namun jauh lebih ringkas dan mudah diperluas jika ada status baru.
- `ORDER BY tanggal_pesanan DESC` menempatkan transaksi paling baru di baris teratas.

---

### Jawaban Soal 7: Operator Rentang BETWEEN
**Instruksi:** Cari pesanan dengan nilai total bayar antara 250.000 sampai 500.000, urutkan terbesar ke terkecil, batasi 5 baris.

```sql
SELECT 
    nomor_invoice, 
    total_bayar, 
    status_pesanan
FROM pesanan
WHERE total_bayar BETWEEN 250000 AND 500000
ORDER BY total_bayar DESC
LIMIT 5;
```

**Pembahasan:**
- Operator `BETWEEN a AND b` bersifat inklusif (artinya nilai batas 250000 dan 500000 ikut masuk dalam kriteria filter).
- Ekivalen dengan: `WHERE total_bayar >= 250000 AND total_bayar <= 500000`.

---

### Jawaban Soal 8: Pattern Matching (LIKE & OR)
**Instruksi:** Cari produk yang mengandung kata 'Wireless' atau 'Gaming' pada nama produk.

```sql
SELECT 
    produk_id, 
    nama_produk, 
    deskripsi
FROM produk
WHERE nama_produk LIKE '%Wireless%'
   OR nama_produk LIKE '%Gaming%';
```

**Pembahasan:**
- Karakter wildcard `%` berarti cocok dengan sembarang karakter berapa pun panjangnya (sebelum atau sesudah kata kunci pencarian).
- Operator `OR` memastikan produk yang memenuhi salah satu kata kunci tersebut akan terpilih.

---

### Jawaban Soal 9: Paginasi (LIMIT & OFFSET)
**Instruksi:** Urutkan pesanan dari nilai total bayar tertinggi ke terendah, lalu ambil halaman kedua (10 data berikutnya).

```sql
SELECT 
    nomor_invoice, 
    tanggal_pesanan, 
    total_bayar
FROM pesanan
ORDER BY total_bayar DESC
LIMIT 10 OFFSET 10;
```

**Pembahasan:**
- `LIMIT 10`: Menentukan ukuran halaman (page size) sebanyak 10 data.
- `OFFSET 10`: Menentukan berapa banyak baris yang dilewati (skip 10 baris pertama / Halaman 1).
- Pola umum paginasi halaman ke-`N` adalah: `LIMIT <page_size> OFFSET (<N> - 1) * <page_size>`.

---

### Jawaban Soal 10: Pengecekan Nilai NULL (IS NULL)
**Instruksi:** Tampilkan pesanan yang tidak menggunakan voucher (`voucher_id IS NULL`), urutkan dari transaksi terbaru, batasi 5 baris.

```sql
SELECT 
    nomor_invoice, 
    potongan_diskon, 
    voucher_id, 
    total_bayar, 
    tanggal_pesanan
FROM pesanan
WHERE voucher_id IS NULL
ORDER BY tanggal_pesanan DESC
LIMIT 5;
```

**Pembahasan:**
- Nilai `NULL` di database relasional tidak dapat dibandingkan dengan operator standar seperti `= NULL` atau `!= NULL` karena `NULL` berarti "tidak diketahui/ketiadaan nilai".
- Sintaks yang benar dan standar SQL wajib menggunakan `IS NULL` atau `IS NOT NULL`.
