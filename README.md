# 🛒 SQL E-Commerce Data Analytics Course

Kurikulum interaktif pembelajaran SQL tingkat dasar hingga mahir (Data Analyst) menggunakan database riil **Toko E-Commerce Indonesia (20 Tabel Relasional & 5.600+ Data Transaksi)**.

---

## 🚀 1. Cara Menjalankan Secara Lokal (Dev Server)

Buka terminal di folder ini, lalu jalankan salah satu perintah berikut:

```bash
# Menggunakan npm
npm run dev

# Atau menggunakan pnpm
pnpm run dev

# Atau langsung dengan npx
npx serve . -p 3000
```

Buka browser di: **`http://localhost:3000`**

---

## 🌐 2. Cara Deploy Online (Gratis)

### Opsi A: Deploy ke Vercel (Paling Cepat 10 Detik)
```bash
npx vercel
```

### Opsi B: Deploy ke Netlify
```bash
npx netlify deploy --prod
```

### Opsi C: GitHub Pages
1. Buka **Settings** -> **Pages** -> Pilih branch `main` / root -> Save.

---

## 📁 Struktur Proyek
- `database/ecommerce.db` : File database biner untuk dibuka di DB Browser for SQLite / DBeaver.
- `database/schema.sql` : DDL Skema 20 tabel (VARCHAR, CHAR, BIGINT).
- `sql/semua_query_latihan.sql` : 1 File master berisi seluruh query latihan Modul 1 - 7.
- `modul/` : 7 Modul HTML pembelajaran interaktif.
- `index.html` : Portal utama kurikulum.
