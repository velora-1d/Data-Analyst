# SQL E-Commerce Data Analytics Curriculum

Kurikulum pembelajaran SQL komprehensif untuk Data Analyst berbasis studi kasus industri nyata menggunakan database relasional **E-Commerce Indonesia** (20 Tabel Relasional dan 5.600+ baris data transaksi).

---

## 1. Menjalankan Proyek Secara Lokal

Pastikan Node.js telah terpasang, kemudian jalankan perintah berikut di direktori proyek:

```bash
# Menggunakan npm
npm run dev

# Atau menggunakan pnpm
pnpm run dev

# Atau langsung menggunakan npx serve
npx serve . -p 3000
```

Setelah server aktif, buka browser pada alamat: **`http://localhost:3000`**

---

## 2. Struktur Direktori Proyek

```text
├── assets/
│   ├── style.css                 # Stylesheet antarmuka (Dark mode default, Palet biru)
│   └── script.js                 # Skrip kuis interaktif, navigasi modul, dan copy code
├── database/
│   ├── ecommerce.db              # Database SQLite 20 tabel relasional (5.631 baris transaksi)
│   └── schema.sql                # Skema DDL tabel dengan tipe data standar (VARCHAR, CHAR, DATETIME)
├── modul/
│   ├── 01_tipe_data.html         # Modul 1: Tipe Data SQL & Inspeksi Skema
│   ├── 02_query_dasar.html        # Modul 2: Query Dasar, Filtering & Paginasi
│   ├── 03_agregasi.html           # Modul 3: Fungsi Agregasi & Metrik Penjualan
│   ├── 04_join.html               # Modul 4: Normalisasi & Relasi Multi-Tabel
│   ├── 05_subquery_cte.html       # Modul 5: Subquery & Common Table Expressions
│   ├── 06_window_functions.html   # Modul 6: Window Functions & Analisis Tren
│   └── 07_analisis_nyata.html     # Modul 7: Capstone Studi Kasus Analisis Bisnis
├── sql/
│   ├── semua_query_latihan.sql   # 1 Berkas master seluruh query latihan Modul 1-7
│   ├── 01_tipe_data.sql          # Kumpulan query latihan Modul 1
│   ├── 02_query_dasar.sql         # Kumpulan query latihan Modul 2
│   ├── 03_agregasi.sql            # Kumpulan query latihan Modul 3
│   ├── 04_join.sql                # Kumpulan query latihan Modul 4
│   ├── 05_subquery_cte.sql        # Kumpulan query latihan Modul 5
│   ├── 06_window_functions.sql    # Kumpulan query latihan Modul 6
│   └── 07_analisis_nyata.sql      # Kumpulan query latihan Modul 7 (Capstone)
├── index.html                    # Portal utama kurikulum belajar
├── package.json                  # Konfigurasi dev server lokal
└── README.md                     # Dokumentasi proyek
```

---

## 3. Silabus & Modul Pembelajaran

| No | Modul | Topik Utama | Tingkat |
| :--- | :--- | :--- | :--- |
| 1 | **Tipe Data SQL** | `VARCHAR`, `CHAR`, `INTEGER`, `REAL`, `DATETIME`, SQLite Type Affinity, `NULL` Handling, `CAST()` | Pemula |
| 2 | **Query Dasar & Filtering** | `SELECT`, `WHERE`, `AND`/`OR`, `ORDER BY`, `LIMIT & OFFSET`, `DISTINCT`, `BETWEEN`, `IN`, `LIKE` | Pemula |
| 3 | **Fungsi Agregasi** | `COUNT(*)`, `SUM()`, `AVG()`, `MIN()`, `MAX()`, `GROUP BY`, `HAVING` vs `WHERE`, Kalkulasi AOV & GMV | Menengah |
| 4 | **JOIN Multi-Tabel** | `INNER JOIN`, `LEFT JOIN` (Anti-join / User Churn), Rantai 6 Tabel Transaksi, `CROSS JOIN` | Menengah |
| 5 | **Subquery & CTE** | Scalar Subquery, Correlated Subquery, `EXISTS`, `WITH ... AS` (Multi-level CTE Data Pipeline) | Mahir |
| 6 | **Window Functions** | `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`, `PARTITION BY`, `LAG()` (MoM Growth), Running Total | Mahir |
| 7 | **Capstone Studi Kasus** | Laba Bersih Finansial Toko, Profitabilitas Kategori, Segmentasi RFM, Evaluasi Promo ROI, Stok Kritis | Capstone |

---

## 4. Panduan Membuka Database di DB Browser for SQLite

1. Unduh dan buka aplikasi **DB Browser for SQLite** atau **DBeaver**.
2. Pilih menu **Open Database** dan arahkan ke file `database/ecommerce.db`.
3. Buka tab **Execute SQL** lalu jalankan kueri latihan yang terdapat di folder `sql/` atau melalui berkas gabungan `sql/semua_query_latihan.sql`.
