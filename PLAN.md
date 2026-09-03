# MASTER IMPLEMENTATION PLAN: FUNDAMENTAL CODING
> **Platform Edukasi Rekayasa Perangkat Lunak, Full-Stack, Database, Arsitektur & Infrastruktur**  
> **Dikembangkan oleh:** Velora | **Disusun oleh:** Mahin Utsman Nawawi, S.H  
> **Repository:** `https://github.com/velora-1d/Data-Analyst.git` (Folder: `Fundamental`)  
> **Roadmap Interaktif (Web App):** <a href="plan.html"><code>plan.html</code> (Klik untuk membuka dashboard interaktif di browser)</a>

---

<div align="center">
  <span style="background: #2563EB; color: #FFFFFF; padding: 4px 12px; border-radius: 9999px; font-weight: 700; font-size: 13px;">STATUS: ARSITEKTUR FINAL DIKUNCI</span>
  <span style="background: #1E3260; color: #60A5FA; padding: 4px 12px; border-radius: 9999px; font-weight: 600; font-size: 13px;">STACK: PURE SEMANTIC HTML5 + MODERN BLUE CSS3 + MODULAR ES6 JS</span>
  <span style="background: #065F46; color: #34D399; padding: 4px 12px; border-radius: 9999px; font-weight: 600; font-size: 13px;">TOTAL: 10 TRACK | 30 FASE EKSEKUSI LENGKAP</span>
</div>

<br>

---

## 1. Visi & Filosofi Arsitektur Platform

### A. Visi Platform
**Fundamental Coding** bukan sekadar tutorial sintaks pemula (*"hello world"*). Platform ini dirancang sebagai **ensiklopedia dan kurikulum interaktif rekayasa perangkat lunak pragmatis**, membedah teknologi dari prinsip pertama (*first principles*) hingga tingkat arsitektur sistem industri skala produksi:
- **Frontend (FE):** Dari rendering pipeline browser (DOM/CSSOM/Reflow/Paint/Composite) hingga arsitektur state management reaktif.
- **Backend (BE):** Dari protokol jaringan (TCP 3-way handshake, HTTP/1.1 vs HTTP/2 vs HTTP/3 QUIC) hingga arsitektur API terdistribusi (REST, GraphQL, gRPC).
- **Database (DB):** Dari query relasional SQL 20 tabel e-commerce hingga struktur storage engine (slotted pages, B-Tree, LSM-Tree, WAL, MVCC, dan level isolasi ANSI).
- **Arsitektur Sistem:** Bedah mendalam Monorepo vs Polyrepo, Monolith vs Modular Monolith vs Microservices, DDD, Clean Architecture, dan transaksi terdistribusi (Saga Pattern).
- **Jaringan & Server:** Model OSI 7-lapis, subnetting CIDR, NAT, hierarki resolusi DNS, Nginx reverse proxy (epoll event loop), dan terminasi TLS.
- **DevOps & Kontainer:** Linux kernel primitives (Namespaces & cgroups), arsitektur Docker internals, multi-stage image optimization, dan otomasi CI/CD zero-downtime.
- **Bahasa Pemrograman & Runtime:** Analisis komparatif memory management (Stack vs Heap, Manual vs Tracing GC vs Rust Ownership), type systems, dan runtime execution (V8, JVM, Native Go/Rust).
- **Git & Engineering Workflow:** Struktur DAG (*Directed Acyclic Graph*), format objek Git (Blob, Tree, Commit, Tag), rebase vs merge, dan Trunk-Based Development.

---

### B. Keputusan Teknologi: Murni HTML5 + CSS3 + Modular JS (Zero Framework Overhead)

> <p><strong>KEPUTUSAN FINAL ARSITEKTUR:</strong><br>
> <em>"Udah, pakai HTML aja!"</em> — Seluruh keraguan terhadap penggunaan framework berat (Next.js / Nuxt / SvelteKit) secara resmi dihentikan. Platform dibangun <strong>100% menggunakan Semantic HTML5 murni, Modern Blue CSS3 Design System, dan Modular ES6 JavaScript</strong>.</p>

<table width="100%">
  <thead>
    <tr style="background:#111C38; color:#F8FAFC;">
      <th>Parameter Evaluasi</th>
      <th style="color:#60A5FA;">Pilihan Platform: Pure HTML5 + Modular JS</th>
      <th style="color:#94A3B8;">Opsi Ditolak: Next.js (App Router)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Kecepatan Buka &amp; TTFB</strong></td>
      <td><strong>0ms (Instan)</strong>. Dibuka langsung dari filesystem atau CDN tanpa cold start server.</td>
      <td>Membutuhkan server Node.js aktif atau waktu hydration bundle JavaScript React (~200ms - 1s).</td>
    </tr>
    <tr>
      <td><strong>Overhead &amp; Build Time</strong></td>
      <td><strong>Nol Build Step</strong>. Simpan file <code>.html</code> dan langsung refresh di browser. Zero compilation lock.</td>
      <td>Waktu kompilasi <code>next build</code> melonjak seiring bertambahnya ratusan file materi.</td>
    </tr>
    <tr>
      <td><strong>Biaya Hosting &amp; Portabilitas</strong></td>
      <td><strong>100% Gratis Selamanya</strong>. Bisa di-hosting di GitHub Pages, Cloudflare Pages, atau bahkan di-flashdisk offline.</td>
      <td>Ketergantungan pada hosting Vercel Pro atau server VPS Node.js yang membutuhkan biaya berkala.</td>
    </tr>
    <tr>
      <td><strong>Pengalaman Belajar Siswa</strong></td>
      <td><strong>Transparan &amp; Nyata</strong>. Siswa bisa melakukan <em>Right-Click -&gt; Inspect Element</em> dan melihat kode asli tanpa terbungkus bundler sintetis.</td>
      <td>Kode terbungkus ribuan lapisan runtime abstraksi webpack/turbopack dan minified vendor chunks.</td>
    </tr>
    <tr>
      <td><strong>Daya Tahan Masa Depan</strong></td>
      <td><strong>Bertahan puluhan tahun</strong>. Standar W3C HTML5 dan CSS3 tidak pernah mengalami breaking change usang.</td>
      <td>Sering mengalami breaking changes antar major version (misal: Pages Router vs App Router).</td>
    </tr>
  </tbody>
</table>

---

## 2. Struktur Direktori Terintegrasi

```text
Fundamental/
├── assets/
│   ├── script.js             # Instant SPA Router, Prefetcher, & Theme Engine (Local Memory)
│   ├── style.css              # Modern Blue Design System (#2563EB, #1E3260, #0B132B)
│   └── nav-data.json          # Single Source of Truth silabus 8 Track & 25 Fase
├── index.html                 # Portal Utama Pembelajaran & Directory Roadmap
├── plan.html                  # Dashboard Interaktif Master Plan & Tracker Progres (Web App)
├── PLAN.md                    # Berkas Master Implementation Plan Ini (HTML/MD Hybrid)
├── README.md                  # Dokumentasi Proyek & Panduan Memulai
├── package.json               # Konfigurasi Dev Server Lokal (npx serve)
├── database/
│   ├── ecommerce.db           # SQLite DB Utama (20 Tabel Relasional, 5.600+ Baris Data)
│   └── schema.sql             # Skema DDL 20 Tabel Standar Industri (VARCHAR, CHAR, DATETIME)
├── sql/                       # Kumpulan Query Latihan SQL Praktik per Bab
│   ├── semua_query_latihan.sql
│   ├── 01_tipe_data.sql s/d 07_analisis_nyata.sql
├── modul/                     # Modul Pembelajaran Aktif (HTML Semantik Murni)
│   ├── 01_tipe_data.html s/d 07_analisis_nyata.html
└── tracks/                    # Direktori Multi-Track Mendatang
    ├── 01_database_sql/       # Modul SQL Relasional & DB Internals
    ├── 02_frontend/           # Modul Browser Pipeline, Modern CSS & State Architecture
    ├── 03_backend/            # Modul Protokol Jaringan, REST, GraphQL & gRPC
    ├── 04_arsitektur_sistem/  # Modul Monorepo vs Polyrepo, Clean Arch, Modular Monolith
    ├── 05_jaringan_server/    # Modul OSI, TCP, Subnetting CIDR, DNS & Nginx
    ├── 06_devops_docker/      # Modul Linux Namespaces, cgroups, Docker & CI/CD
    ├── 07_bahasa_pemrograman/ # Modul Runtime V8/JVM/Go/Rust, Memory Stack/Heap/GC
    └── 08_git_workflow/       # Modul Git DAG, Objek Internals & Trunk-Based Dev
```

---

## 3. Silabus Lengkap 25 Fase Eksekusi (8 Track Utama)

<details open>
<summary><strong>🏛️ BAGIAN I: FONDASI PLATFORM & NAVIGASI MULTI-TRACK (Fase 1 - 3)</strong></summary>
<br>

### Fase 1: Redesain Beranda Portal Kurikulum (`index.html`)
* **Sasaran Kompetensi:** Menghubungkan seluruh kurikulum dalam satu portal navigasi terpadu berbasis single entry point, berorientasi UX intuitif dan visual modern.
* **First Principles & Teori Mendalam:**
  - Anatomi portal edukasi rekayasa: Cognitive Load Reduction (hukum Hick's Law).
  - Hirarki visual: Hero Section -> Search Filter Instan -> Matrix Grid 8 Track -> Live Progress Indicator.
* **Lab & Praktik Nyata:**
  - Merombak `index.html` dari beranda khusus SQL menjadi Learning Portal Multi-Track.
  - Implementasi komponen pencarian instan lokal berbasis JavaScript (fuzzy match nama bab, deskripsi, dan tag kompetensi).
* **Common Pitfalls & Anti-Patterns:**
  - *Hardcoding daftar modul:* Mengakibatkan duplikasi pemeliharaan saat ada bab baru ditambahkan.
* **Definition of Done (DoD):** Siswa dapat melihat 8 kartu track utama dengan indikator tingkat kesulitan (Pemula, Menengah, Mahir, Capstone) dan filter pencarian real-time.

---

### Fase 2: Navigasi Sidebar Dinamis Berbasis `nav-data.json` & SPA Router
* **Sasaran Kompetensi:** Mengelola struktur navigasi ratusan bab secara otomatis tanpa perlu duplikasi kode HTML di setiap berkas modul.
* **First Principles & Teori Mendalam:**
  - *Single Source of Truth (SSOT)*: Seluruh metadata track, bab, judul, icon, durasi, dan file link didefinisikan dalam format `nav-data.json`.
  - DOM Generation vs Virtual DOM: Memanfaatkan DocumentFragment untuk injeksi menu accordion secara efisien (1 kali reflow DOM).
* **Lab & Praktik Nyata:**
  - Pembuatan file `assets/nav-data.json` mencakup silabus 25 fase.
  - Skrip `assets/script.js` membaca file JSON via `fetch()`, merender accordion sidebar dinamis, dan menandai bab yang sedang aktif berdasarkan `window.location.pathname`.
* **Common Pitfalls & Anti-Patterns:**
  - *Reflow Thrashing:* Melakukan append element DOM satu per satu di dalam loop tanpa menggunakan `DocumentFragment`.
* **Definition of Done (DoD):** Sidebar ter-render otomatis di seluruh halaman modul, status bab aktif menyala dengan warna biru brand, dan accordion track dapat di-expand/collapse dengan mulus.

---

### Fase 3: Standarisasi Component Library & Callout Boxes
* **Sasaran Kompetensi:** Menyediakan elemen visual modular untuk menyampaikan nuansa industri nyata pada materi teknis.
* **First Principles & Teori Mendalam:**
  - Design Tokens: Standarisasi CSS Custom Properties untuk semantic callouts (Info, Warning, Production Pitfall, Architecture Trade-off).
* **Lab & Praktik Nyata:**
  - Pembuatan kelas CSS: `.callout-production`, `.callout-tradeoff`, `.callout-pitfall`, dan `.code-preview-pane`.
  - Diagram visual interaktif berbasis SVG inline (diagram topologi jaringan, struktur memori, dan diagram relasi tabel).
* **Common Pitfalls & Anti-Patterns:**
  - Menaruh style *inline CSS* di setiap tag HTML alih-alih memanfaatkan kelas utility design system.
* **Definition of Done (DoD):** Seluruh modul memiliki format tampilan seragam untuk studi kasus kegagalan produksi (*war stories*), komparasi kelebihan/kekurangan, dan demo kode interaktif.

</details>

<br>

<details open>
<summary><strong>🗄️ BAGIAN II: TRACK DATABASE & SQL INTERNALS (Fase 4 - 6)</strong></summary>
<br>

### Fase 4: Database Storage Engine & Struktur B-Tree (Deep Dive)
* **Sasaran Kompetensi:** Memahami bagaimana data database relasional secara fisik disimpan di media disk, struktur halaman data (*page*), serta perbedaan mekanisme B-Tree vs LSM-Tree.
* **First Principles & Teori Mendalam (Riset: Alex Petrov, *Database Internals*):**
  - **On-Disk Page Layout:** Pembagian disk block (default 4096 bytes / 4KB pada SQLite/Postgres/InnoDB). Anatomi *Slotted Page Structure*: Page Header -> Cell Pointers Array -> Free Space Gap -> Row Payload Data (dari bawah ke atas).
  - **B-Tree & B+Tree Architecture:**
    - Branching factor (fanout) tinggi untuk meminimalkan I/O disk (tinggi tree $O(\log_B N)$).
    - Perbedaan kunci: B-Tree menyimpan data di node internal dan daun; B+Tree **hanya menyimpan data di node daun (leaf nodes)** yang saling terhubung membentuk *doubly linked list* untuk optimasi *sequential range scan*.
  - **LSM-Tree (Log-Structured Merge-Tree):**
    - Mengapa NoSQL (Cassandra, RocksDB) menggunakannya: Mengubah *random writes* menjadi *sequential appends*.
    - Komponen: *MemTable* (in-memory skiplist/red-black tree), *Write-Ahead Log (WAL)* di disk, dan *SSTables* (Sorted String Tables) bertingkat.
    - *Compaction Strategies:* Size-Tiered vs Leveled Compaction, didukung *Bloom Filters* untuk menepis pengecekan disk yang tidak perlu.
  - **Write-Ahead Logging (WAL) & Crash Recovery:**
    - Prinsip ARIES: Write log record to disk before flushing dirty data pages to ensure ACID Atomicity & Durability.
* **Lab & Praktik Nyata:**
  - Inspeksi biner file `database/ecommerce.db` menggunakan tools SQLite CLI (`sqlite3_analyzer` atau hexdump) untuk melihat header halaman 100-byte dan alokasi cell pointer.
* **Common Pitfalls & Anti-Patterns:**
  - Berasumsi bahwa database memperbarui baris data langsung pada file disk saat `UPDATE` dijalankan tanpa melewati Buffer Pool dan WAL.
* **Definition of Done (DoD):** Siswa mampu menggambar anatomi Slotted Page dan menjelaskan trade-off kapan sistem memerlukan B+Tree (Read-heavy OLTP) vs LSM-Tree (Write-heavy Log Engine).

---

### Fase 5: Strategi Indexing & Anatomi Execution Plan
* **Sasaran Kompetensi:** Menganalisis bottleneck performa query SQL dan mendesain indeks komposit optimal berbasis *Cost-Based Optimizer* (CBO).
* **First Principles & Teori Mendalam:**
  - **Indeks B-Tree Tunggal vs Komposit (Compound Index):**
    - Aturan Emas *Leftmost Prefix Rule*: Indeks pada `(status, created_at, total_amount)` hanya efektif untuk filter yang menyertakan kolom `status`.
    - Selektivitas Kolom: Menempatkan kolom dengan kardinalitas tertinggi di posisi depan indeks komposit untuk *filtering power* maksimal.
  - **Mekanisme Akses Data:**
    - *Table Scan / Full Scan:* Membaca setiap halaman dari awal sampai akhir ($O(N)$).
    - *Index Scan + Table Lookup:* Menemukan rowid di indeks, lalu membaca halaman tabel untuk mengambil sisa kolom.
    - *Covering Index (Index Only Scan):* Semua kolom yang diminta oleh `SELECT` dan `WHERE` berada di dalam indeks itu sendiri, menghilangkan 100% biaya table lookup.
  - **Bedah `EXPLAIN QUERY PLAN`:**
    - Membaca operator: `SEARCH TABLE ... USING INDEX`, `SCAN TABLE`, `USE TEMP B-TREE FOR ORDER BY / GROUP BY`.
* **Lab & Praktik Nyata:**
  - Eksekusi query lambat pada tabel `pesanan` (5.600+ baris) dengan `WHERE status = 'PAID' AND tanggal_pesanan BETWEEN '2024-01-01' AND '2024-06-30' ORDER BY total_bayar DESC`.
  - Bandingkan eksekusi sebelum dan sesudah dibuat `CREATE INDEX idx_pesanan_perf ON pesanan(status, tanggal_pesanan, total_bayar);`.
* **Common Pitfalls & Anti-Patterns:**
  - *Over-indexing:* Menaruh indeks di semua kolom tabel, yang memperlambat operasi `INSERT`, `UPDATE`, dan `DELETE` karena setiap mutasi harus memperbarui seluruh pohon B-Tree.
  - Melakukan fungsi kalkulasi pada kolom filter (`WHERE YEAR(created_at) = 2024`) yang mematikan efektivitas indeks (wajib menggunakan range: `created_at >= '2024-01-01' AND created_at < '2025-01-01'`).
* **Definition of Done (DoD):** Siswa mampu mentransformasikan query berkategori `SCAN TABLE` menjadi `SEARCH TABLE ... USING COVERING INDEX` dan mendokumentasikan efisiensi latensinya.

---

### Fase 6: Transaksi, Level Isolasi & Transaksi Terdistribusi
* **Sasaran Kompetensi:** Menguasai proteksi integritas data saat sistem menangani ribuan transaksi bersamaan (*high concurrency*) dan membedah transaksi terdistribusi.
* **First Principles & Teori Mendalam:**
  - **4 Anomali Konkurensi Data ANSI:**
    1. *Dirty Read:* Transaksi A membaca perubahan data Transaksi B yang belum di-commit (dan bisa di-rollback).
    2. *Non-Repeatable Read:* Transaksi A membaca baris yang sama dua kali, tetapi mendapatkan nilai berbeda karena Transaksi B melakukan update di tengah jalan.
    3. *Phantom Read:* Transaksi A menjalankan query range, lalu Transaksi B menyisipkan baris baru yang cocok dengan range tersebut.
    4. *Serialization Anomaly:* Interleaving eksekusi dua transaksi menghasilkan state yang tidak konsisten dengan urutan serial mana pun.
  - **4 Level Isolasi Standar ANSI SQL:**
    - Read Uncommitted, Read Committed, Repeatable Read, dan Serializable.
  - **Mekanisme Kontrol Konkurensi:**
    - *Two-Phase Locking (2PL):* Growing phase (mengambil kunci) dan Shrinking phase (melepaskan kunci). Pessimistic locking: `SELECT ... FOR UPDATE`.
    - *Multi-Version Concurrency Control (MVCC):* Readers do not block writers, and writers do not block readers. Data disimpan dengan identifier transaksi (`xmin`/`xmax` di Postgres, undo log di MySQL/InnoDB).
    - *Optimistic Concurrency Control (OCC):* Validasi versi row (`WHERE id = ? AND version = ?`) saat commit.
  - **Pengantar Transaksi Terdistribusi:**
    - Limitasi *Two-Phase Commit (2PC)*: Blocking protocol, single point of failure (Coordinator).
    - *Saga Pattern:* Rangkaian transaksi lokal yang dikoordinasikan via *Choreography* (Event-driven) atau *Orchestration* (Central State Machine) dengan aksi kompensasi (*compensating transactions*).
* **Lab & Praktik Nyata:**
  - Simulasi kasus *Flash Sale Checkout*: Dua sesi koneksi konkuren mencoba membeli barang dengan sisa `stok = 1`. Demonstrasi *Race Condition* tanpa lock vs pencegahan menggunakan pessimistic lock `BEGIN IMMEDIATE` / `FOR UPDATE`.
* **Common Pitfalls & Anti-Patterns:**
  - Membiarkan transaksi terbuka terlalu lama (*Long-running transactions*) yang menyebabkan penumpukan lock database dan kehabisan undo log storage.
* **Definition of Done (DoD):** Siswa memahami tabel matriks level isolasi vs 4 anomali data serta mampu menulis query locking yang bebas dari *deadlock*.

</details>

<br>

<details open>
<summary><strong>🌐 BAGIAN III: TRACK FRONTEND ENGINEERING & BROWSER INTERNALS (Fase 7 - 9)</strong></summary>
<br>

### Fase 7: Browser Rendering Pipeline & The Event Loop
* **Sasaran Kompetensi:** Memahami bagaimana engine peramban web (Chromium/V8, WebKit) mengonversi teks HTML/CSS/JS menjadi piksel di monitor dengan standar 60 FPS (16.6ms frame budget).
* **First Principles & Teori Mendalam (Riset: W3C & Chrome DevTools Architecture):**
  - **The Critical Rendering Path (CRP):**
    1. *DOM Construction:* Bytes -> Characters -> Tokens -> Nodes -> DOM Tree.
    2. *CSSOM Construction:* CSS Parsing -> Render-blocking stylesheet processing.
    3. *Render Tree:* Penggabungan DOM + CSSOM (mengabaikan elemen `display: none` atau `<head>`).
    4. *Layout (Reflow):* Perhitungan geometri visual tiap node (posisi x, y, lebar, tinggi) di viewport.
    5. *Paint (Rasterization):* Pengisian piksel warna, borders, teks, gambar ke dalam memory buffer.
    6. *Compositing:* Pemisahan elemen ke layer GPU independen dan rendering layer gabungan.
  - **Pemicu Pipeline (Layout vs Paint vs Composite):**
    - Properti yang memicu full Reflow (mahal): `width`, `height`, `margin`, `padding`, `top`, `left`, `fontSize`.
    - Properti yang hanya memicu Paint: `color`, `background-color`, `box-shadow`, `border-color`.
    - Properti yang langsung ditangani GPU Compositor (performa 60fps mulus): `transform: translate3d()` dan `opacity`.
  - **JavaScript Event Loop:**
    - Call Stack (Single-threaded).
    - Web APIs (Timer, Fetch, DOM Events).
    - *Macrotask Queue:* `setTimeout`, `setInterval`, I/O.
    - *Microtask Queue:* `Promise.then()`, `queueMicrotask`, `MutationObserver` (dieksekusi habis sebelum macrotask berikutnya).
    - *Render Phase:* `requestAnimationFrame` dieksekusi tepat sebelum layout dan paint browser.
* **Lab & Praktik Nyata:**
  - Menggunakan tab *Performance* di Chrome DevTools: Merekam animasi perubahan `left` vs `transform: translateX()`, mengidentifikasi drop frame (*jank*), dan menghitung waktu reflow.
* **Common Pitfalls & Anti-Patterns:**
  - *Layout Thrashing (Forced Synchronous Layout):* Membaca properti layout (`offsetHeight`, `clientWidth`) lalu segera menulis properti style DOM di dalam loop yang sama.
* **Definition of Done (DoD):** Siswa mampu mengidentifikasi dan memperbaiki layout thrashing serta membuat animasi 60 FPS tanpa memicu reflow.

---

### Fase 8: Modern CSS Architecture & Responsive Design Systems
* **Sasaran Kompetensi:** Merancang arsitektur CSS berskala besar yang bersih, modular, maintainable, dan bebas konflik spesifisitas (*specificity hell*).
* **First Principles & Teori Mendalam:**
  - **Layout Algorithm:** Perbedaan mendalam model 1D Flexbox (main axis vs cross axis, `flex-grow`, `flex-shrink`, `flex-basis`) vs model 2D CSS Grid (`grid-template-columns`, `minmax()`, `fr` units).
  - **CSS Custom Properties (Design Tokens):**
    - Variabel dinamis cascading: `--brand`, `--bg-primary`, `--text-primary`.
    - Implementasi Dark Mode instan tanpa flicker menggunakan `data-theme` attribute pada root `<html>`.
  - **Komparasi Arsitektur CSS Industri:**
    - BEM (Block Element Modifier): Konvensi penamaan tegas, spesifisitas rendah (`.card__button--active`).
    - Utility-First (Tailwind style): Zero unused CSS dengan purging, komposisi cepat di markup.
    - CSS-in-JS (Styled Components / Emotion): Fleksibel namun membawa beban runtime serialization JS yang menurunkan skor Core Web Vitals (INP/FID).
* **Lab & Praktik Nyata:**
  - Membangun responsive grid layout yang fleksibel dari mobile (1 kolom) ke desktop (4 kolom) menggunakan pure CSS Grid `repeat(auto-fit, minmax(280px, 1fr))` tanpa membutuhkan satu baris pun media query.
* **Common Pitfalls & Anti-Patterns:**
  - Menggunakan `!important` untuk menyelesaikan konflik spesifisitas, yang merusak prinsip cascading CSS.
* **Definition of Done (DoD):** Sistem CSS platform `Fundamental Coding` menggunakan variabel token terpusat dengan dukungan dark/light mode dan zero layout shift (CLS = 0).

---

### Fase 9: Paradigma Frontend Framework & State Management
* **Sasaran Kompetensi:** Memahami cara kerja mesin reaktivitas framework modern, kapan membutuhkan framework, dan bagaimana mengelola state aplikasi skala besar.
* **First Principles & Teori Mendalam:**
  - **3 Paradigma Reaktivitas Framework:**
    1. *Virtual DOM Diffing (React):* Tree reconciliation, heuristik O(N), re-render seluruh subtree kecuali di-memoize.
    2. *Compile-Time Reactivity (Svelte):* Tanpa virtual DOM. Kompiler mentranslasikan state assignments (`count += 1`) langsung menjadi manipulasi DOM imperatif yang sangat hemat memori.
    3. *Fine-Grained Signals (Solid.js, Vue 3, Angular Signals):* Observer pattern berbasis dependency graph. Hanya node DOM spesifik yang bergantung pada signal yang di-update tanpa menyentuh sisa komponen.
  - **Model Rendering Web Modern:**
    - CSR (Client-Side Rendering) vs SSR (Server-Side Rendering) vs SSG (Static Site Generation) vs ISR (Incremental Static Regeneration) vs Islands Architecture (Astro).
  - **Arsitektur State:**
    - Client State (UI state lokal / form inputs).
    - Server Cache State (Data fetching, deduping, background refetch, stale-while-revalidate via TanStack Query / SWR).
* **Lab & Praktik Nyata:**
  - Membuat mini reactivity engine dengan JavaScript Vanilla: Implementasi kelas `ReactiveStore` menggunakan `Proxy` untuk auto-update elemen DOM saat properti objek dimutasi.
* **Common Pitfalls & Anti-Patterns:**
  - Menyimpan data API server ke dalam global Redux store secara manual tanpa manajemen loading, error, dan stale-time caching.
* **Definition of Done (DoD):** Siswa dapat membedah trade-off antara React, Svelte, dan Signals, serta mampu memilih strategi rendering yang tepat sesuai karakteristik proyek (SEO, interaktivitas, atau kecepatan TTFB).

</details>

<br>

<details open>
<summary><strong>⚙️ BAGIAN IV: TRACK BACKEND ENGINEERING & PROTOKOL JARINGAN (Fase 10 - 12)</strong></summary>
<br>

### Fase 10: Protokol Komunikasi: Anatomi HTTP/TCP & Real-Time Web
* **Sasaran Kompetensi:** Menguasai lapisan transport dan aplikasi pada komunikasi internet modern serta memilih protokol komunikasi data yang tepat.
* **First Principles & Teori Mendalam:**
  - **Evolusi Protokol HTTP:**
    - *HTTP/1.1:* Plain text, persistent TCP connection via `keep-alive`. Masalah kronis: *Head-of-Line (HoL) Blocking* di level HTTP (1 request lambat menahan antrean request lain pada koneksi yang sama).
    - *HTTP/2:* Binary framing layer. Multiplexing (mengirim banyak request/response secara paralel dalam 1 koneksi TCP tunggal), Header Compression (HPACK), Stream prioritization. Masalah tersisa: TCP-level HoL blocking saat terjadi *packet loss*.
    - *HTTP/3:* Menggantikan TCP dengan **QUIC (Quick UDP Internet Connections)**. Menghilangkan TCP HoL blocking secara total, 0-RTT connection resumption, dan connection migration (perpindahan mulus dari Wi-Fi ke jaringan seluler 4G/5G tanpa putus koneksi).
  - **Protokol Real-time Web:**
    - *Short Polling:* Request HTTP berulang pada interval tertentu (boros bandwidth dan server overhead).
    - *Long Polling:* Server menahan koneksi HTTP terbuka hingga ada data baru.
    - *Server-Sent Events (SSE):* Unidirectional (Server -> Client) melalui HTTP standar, reconnection otomatis, native browser API (`EventSource`).
    - *WebSockets:* Full-duplex bidirectional streaming di atas single TCP socket setelah HTTP Upgrade handshake.
* **Lab & Praktik Nyata:**
  - Membuat server Node.js sederhana yang mendemonstrasikan SSE streaming ticker harga komoditas e-commerce secara real-time dan inspeksi frame via Wireshark / DevTools Network tab.
* **Common Pitfalls & Anti-Patterns:**
  - Menggunakan WebSocket untuk kasus penggunaan data satu arah (seperti notifikasi atau live feed) yang sebenarnya jauh lebih hemat dan stabil jika menggunakan Server-Sent Events (SSE).
* **Definition of Done (DoD):** Siswa mampu menganalisis struktur paket binary HTTP/2 frames dan menentukan kapan menggunakan REST, SSE, atau WebSocket.

---

### Fase 11: Arsitektur API: REST vs GraphQL vs gRPC
* **Sasaran Kompetensi:** Mendesain kontrak API tingkat produksi dengan efisiensi tinggi sesuai kebutuhan klien (Web, Mobile, dan Microservices IPC).
* **First Principles & Teori Mendalam:**
  - **RESTful API Standar Industri:**
    - *Richardson Maturity Model* (Level 0: The Swamp of POX -> Level 1: Resources -> Level 2: HTTP Verbs -> Level 3: HATEOAS).
    - Strategi Paginasi: *Offset-based* (`LIMIT 10 OFFSET 10000` lambat di database besar) vs *Cursor-based pagination* (`WHERE id > last_seen_id LIMIT 10` instan dengan B-Tree index).
    - Idempotency Keys pada endpoint pembayaran `POST /v1/payments`.
  - **GraphQL Architecture:**
    - Memecahkan masalah *Over-fetching* (mengambil data yang tidak dibutuhkan) dan *Under-fetching* (membutuhkan multiple round-trip).
    - Schema Definition Language (SDL) & Abstract Syntax Tree (AST).
    - *The N+1 Query Problem* pada resolvers dan solusinya: Batching & Caching menggunakan pattern *DataLoader*.
  - **gRPC & Protocol Buffers (Protobuf):**
    - Schema-first IDL (`.proto`), binary serialization kompak (efisiensi 5x lebih kecil dan 10x lebih cepat dibanding JSON).
    - Strongly typed client stub generation untuk komunikasi mikroservis internal.
* **Lab & Praktik Nyata:**
  - Menulis file `ecommerce.proto`, mengompilasinya menjadi stubs kode, dan membandingkan ukuran payload JSON vs Protobuf untuk objek pesanan 100 item.
* **Common Pitfalls & Anti-Patterns:**
  - Menggunakan GraphQL langsung ke database tanpa lapisan DataLoader, yang memicu ratusan query database individual (*N+1 disaster*) pada relasi nested.
* **Definition of Done (DoD):** Siswa memahami kapan memilih REST untuk public API, GraphQL untuk agregasi frontend multi-screen, dan gRPC untuk low-latency backend-to-backend communication.

---

### Fase 12: Autentikasi, Otorisasi & Pertahanan Keamanan API (OWASP)
* **Sasaran Kompetensi:** Mengamankan API backend dari kebocoran data dan ancaman eksploitasi berbasis standar OWASP Top 10 API Security.
* **First Principles & Teori Mendalam:**
  - **Stateful Session vs Stateless JWT:**
    - Session: ID acak tersimpan di HTTP-only cookie, state diverifikasi di memory server / Redis cluster. Mudah di-revoke sewaktu-waktu.
    - JWT: Token mandiri (Header, Payload Base64URL, HMAC/RSA Signature). Bebas query database untuk verifikasi, tetapi sulit di-revoke instan sebelum masa kadaluarsa (wajib implementasi *Refresh Token Rotation*).
  - **OAuth 2.0 & OpenID Connect (OIDC):**
    - Alur *Authorization Code Flow with PKCE* (Proof Key for Code Exchange) untuk aplikasi Single Page Application (SPA) dan mobile.
  - **Pertahanan OWASP Top 10 API:**
    - *BOLA (Broken Object Level Authorization):* Verifikasi bahwa user yang mengakses `GET /api/orders/123` benar-benar pemilik sah pesanan tersebut.
    - *Rate Limiting:* Algoritma *Token Bucket* dan *Sliding Window Counter* menggunakan Redis.
    - *CORS (Cross-Origin Resource Sharing):* Memahami mekanisme `OPTIONS` Preflight request, origin whitelist, dan cookie flags (`SameSite=Strict/Lax`, `Secure`, `HttpOnly`).
* **Lab & Praktik Nyata:**
  - Simulasi eksploitasi celah IDOR/BOLA pada endpoint pesanan dan menulis middleware guard otorisasi tingkat baris (*Row-Level Security*).
* **Common Pitfalls & Anti-Patterns:**
  - Menyimpan token akses JWT di `localStorage` browser (sangat rentan dicuri lewat serangan Cross-Site Scripting / XSS).
* **Definition of Done (DoD):** Siswa mampu mengonfigurasi autentikasi aman berbasis HTTP-only cookies dengan refresh token rotation dan proteksi rate limiting.

</details>

<br>

<details open>
<summary><strong>🏗️ BAGIAN V: TRACK ARSITEKTUR SISTEM & REPOSITORI (Fase 13 - 16)</strong></summary>
<br>

### Fase 13: Diskusi Mendalam: Monorepo vs Polyrepo (Multi-Repo)
* **Sasaran Kompetensi:** Menganalisis strategi pengorganisasian repositori kode organisasi enterprise, tooling monorepo modern, dan trade-off manajemen tim.
* **First Principles & Teori Mendalam:**
  - **Definisi & Arsitektur:**
    - *Monorepo:* Seluruh source code proyek, libraries, backend services, frontend apps, dan mobile klien berada dalam satu version control repository tunggal.
    - *Polyrepo:* Setiap microservice atau library memiliki repositori Git terpisah dengan siklus rilis dan versioning semantik independen.
  - **Matriks Komparasi Industri Menyeluruh:**
    - *Atomic Refactoring:* Mengubah nama interface library bersama langsung memperbarui semua service yang mengonsumsinya dalam 1 commit (Monorepo unggul mutlak).
    - *Dependency Hell:* Polyrepo sering terjebak dalam *version drift* (Service A menggunakan lib v1.2, Service B menggunakan v1.8 dengan breaking changes).
    - *CI/CD & Build Tooling:* Monorepo memerlukan *Affected Build Graph* (Turborepo, Nx, Bazel) agar commit kecil tidak memicu kompilasi ulang seluruh repositori.
    - *Akses & Skala Git:* Polyrepo memberikan isolasi akses tim yang mudah; Monorepo membutuhkan tooling Git tingkat lanjut (sparse checkout, LFS) jika ukuran repo mencapai skala gigabyte (seperti Google/Meta).
* **Lab & Praktik Nyata:**
  - Menyiapkan struktur monorepo terarah: `packages/shared-types`, `apps/web-portal`, dan `apps/api-server` dengan mekanisme symlink workspace lokal.
* **Common Pitfalls & Anti-Patterns:**
  - Mengadopsi Monorepo tanpa build system yang mendukung caching komputasi terdistribusi (akibatnya waktu pipeline CI menjadi berjam-jam).
* **Definition of Done (DoD):** Siswa mampu menyajikan rekomendasi formal kapan startup atau enterprise harus memulai dengan Monorepo vs Polyrepo.

---

### Fase 14: Monolith vs Modular Monolith vs Microservices
* **Sasaran Kompetensi:** Memahami evolusi arsitektur backend, menghindari jebakan *distributed monolith*, dan menerapkan pola *Strangler Fig*.
* **First Principles & Teori Mendalam:**
  - **Ilusi Microservices (The Distributed Fallacy):**
    - Fallacy jaringan: Jaringan itu andal, latensinya nol, bandwidth tidak terbatas, dan topologi tidak berubah.
    - Kompleksitas terdistribusi: Partial failures, network latency overhead, cascading timeouts, tracing distributed tracing (OpenTelemetry, Jaeger), log aggregation terpusat.
  - **Paradigma Modular Monolith:**
    - Alternatif terbaik: Membangun aplikasi dalam 1 deployable unit (monolith), namun secara arsitektur memiliki batas modul (*strict module boundaries*) yang terisolasi secara logis.
    - Modul hanya berkomunikasi lewat publik API antarmuka di dalam memori tanpa network call.
  - **Transisi Dekomposisi:**
    - Pola *Strangler Fig Pattern*: Secara bertahap memotong satu per satu use-case spesifik dari Monolith ke service independen di balik API Gateway tanpa rewrite total.
* **Lab & Praktik Nyata:**
  - Desain modular monolith untuk sistem E-Commerce: Pemisahan modul `Catalog`, `Cart`, `Payment`, dan `Shipping` dengan pelarangan cross-database foreign key coupling antar modul.
* **Common Pitfalls & Anti-Patterns:**
  - Memecah monolith menjadi microservices saat domain bisnis belum stabil, menghasilkan *Distributed Monolith* (seluruh kerugian microservices tanpa satupun keuntungannya).
* **Definition of Done (DoD):** Siswa mampu mendesain arsitektur Modular Monolith dengan *package boundary enforcement* dan rencana dekomposisi Strangler Fig.

---

### Fase 15: Clean Architecture, Hexagonal & Onion Architecture
* **Sasaran Kompetensi:** Merancang aplikasi bisnis yang independen dari framework, database, dan external tools menggunakan prinsip *Inversion of Control*.
* **First Principles & Teori Mendalam:**
  - **Dependency Inversion Principle (DIP):** Modul tingkat tinggi (logika bisnis inti) tidak boleh bergantung pada modul tingkat rendah (database / HTTP framework). Keduanya harus bergantung pada abstraksi (interface).
  - **Lapisan Clean Architecture:**
    1. *Domain Entities:* Aturan bisnis inti dan objek nilai (*pure business logic*, zero external dependencies).
    2. *Use Cases / Application Services:* Alur kerja spesifik sistem (misal: `CheckoutOrderUseCase`).
    3. *Interface Adapters:* Controllers, Presenters, Gateways, Repository Implementations.
    4. *Frameworks & Drivers:* Express/Fastify/Gin, PostgreSQL driver, Redis cache, UI views.
  - **Hexagonal Architecture (Ports and Adapters):**
    - *Driving Ports & Adapters:* Klien yang memicu sistem (HTTP controller, CLI runner, Test suite).
    - *Driven Ports & Adapters:* Sistem yang dipicu oleh aplikasi kita (Database repository, Email sender, Payment gateway).
* **Lab & Praktik Nyata:**
  - Menulis use-case `CreateOrder` di mana unit test dapat dijalankan 100% menggunakan `MockOrderRepository` di memori dalam 2 milidetik tanpa menyalakan koneksi database database SQLite nyata.
* **Common Pitfalls & Anti-Patterns:**
  - Melewatkan entitas ORM database langsung ke lapisan domain atau UI, yang merusak batas isolasi Clean Architecture.
* **Definition of Done (DoD):** Siswa mampu merefaktor kode monolithic kotor menjadi struktur Clean Architecture dengan repository pattern dan dependency injection murni.

---

### Fase 16: Domain-Driven Design (DDD) & Event-Driven Architecture
* **Sasaran Kompetensi:** Mengelola kompleksitas domain bisnis berskala enterprise melalui pemodelan strategis dan pola komunikasi berbasis event asynchronous.
* **First Principles & Teori Mendalam:**
  - **Strategic DDD:**
    - *Ubiquitous Language:* Bahasa formal tunggal yang disepakati bersama antara software engineer dan domain expert / pemangku kepentingan bisnis.
    - *Bounded Context:* Batas konseptual tegas di mana suatu model domain memiliki makna spesifik (contoh: istilah "Produk" di Context Penjualan berbeda maknanya dengan "Produk" di Context Logistik Gudang).
    - *Context Mapping:* Hubungan antar bounded context (Shared Kernel, Customer-Supplier, Anti-Corruption Layer / ACL).
  - **Tactical DDD:**
    - *Entities:* Objek dengan identitas unik (`id`) yang bertahan melewati waktu.
    - *Value Objects:* Objek immutable tanpa identitas, hanya dibedakan berdasarkan nilainya (contoh: `Money(amount, currency)`).
    - *Aggregates & Aggregate Root:* Kumpulan entitas dan value object yang diperlakukan sebagai satu kesatuan konsistensi atomik (contoh: `Order` sebagai aggregate root dari `OrderItem`).
  - **Event-Driven Architecture (EDA):**
    - *Event Sourcing:* Menyimpan riwayat perubahan state sebagai urutan event immutable (`OrderCreated`, `PaymentReceived`, `OrderShipped`) alih-alih hanya menyimpan state terkini.
    - *CQRS (Command Query Responsibility Segregation):* Memisahkan model penulisan mutasi (*Commands*) dari model pembacaan query (*Queries*).
    - *Transactional Outbox Pattern:* Menghindari ketidaksinkronan data antara commit database dan publish message broker (Kafka/RabbitMQ) dengan menyimpan event ke tabel `outbox` dalam transaksi atomik yang sama.
* **Lab & Praktik Nyata:**
  - Implementasi Transactional Outbox Pattern di SQLite: Menyimpan mutasi status pesanan dan record outbox event dalam 1 transaksi `BEGIN TRANSACTION ... COMMIT`.
* **Common Pitfalls & Anti-Patterns:**
  - Menerapkan Event Sourcing dan CQRS pada sistem CRUD sederhana yang tidak membutuhkannya, menimbulkan *accidental complexity* yang luar biasa tinggi.
* **Definition of Done (DoD):** Siswa mampu mendesain Aggregate Root dengan batasan konsistensi data yang benar dan menjelaskan solusi konsistensi data eventual via Outbox Pattern.

</details>

<br>

<details open>
<summary><strong>🐧 BAGIAN VI: TRACK LINUX, SERVER & JARINGAN (Fase 17 - 19)</strong></summary>
<br>

### Fase 17: Dasar Jaringan Komputer, Model OSI & TCP/IP
* **Sasaran Kompetensi:** Membedah perjalanan setiap paket data dari saat pengguna menekan tombol di browser hingga tiba di proses server Linux.
* **First Principles & Teori Mendalam:**
  - **7 Lapisan Model OSI vs 4 Lapisan TCP/IP:**
    - Physical & Data Link: Frame Ethernet, MAC Address, Switch.
    - Network Layer: Paket IP, Routing, ICMP.
    - Transport Layer: TCP Segment vs UDP Datagram, Port Numbers.
    - Application Layer: HTTP, DNS, TLS, SSH.
  - **Mekanika Protokol TCP:**
    - *TCP 3-Way Handshake:* SYN -> SYN-ACK -> ACK. Pembangunan socket state (`LISTEN`, `SYN_SENT`, `ESTABLISHED`).
    - *TCP Teardown:* 4-Way FIN handshake dan state `TIME_WAIT`.
    - Mekanisme Reliabilitas: Sequence Number, Acknowledgment Number, Sliding Window flow control, dan *TCP Slow Start / Congestion Control* (mengapa koneksi TCP baru membutuhkan waktu untuk mencapai kecepatan puncak).
    - Pertahanan *SYN Flood Attack*: Mekanisme kernel *SYN Cookies*.
* **Lab & Praktik Nyata:**
  - Menggunakan CLI Linux `netstat -tuln` / `ss -tulpn` dan `tcpdump -i any -nn port 80` untuk melihat proses pertukaran paket 3-way handshake secara langsung di terminal.
* **Common Pitfalls & Anti-Patterns:**
  - Mengabaikan overhead koneksi baru TCP/TLS (solusi: selalu gunakan HTTP Connection Keep-Alive atau connection pooling pada database).
* **Definition of Done (DoD):** Siswa mampu menginspeksi status soket jaringan Linux dan menjelaskan dampak TCP handshaking terhadap latency TTFB web.

---

### Fase 18: IP Addressing, CIDR, Subnetting & Routing
* **Sasaran Kompetensi:** Menguasai matematika subnetting jaringan, alokasi blok IP pada Virtual Private Cloud (VPC), dan mekanisme routing internet.
* **First Principles & Teori Mendalam:**
  - **Anatomi Alamat IP:**
    - IPv4: 32-bit bilangan biner (4 oktet). Network ID vs Host ID.
    - Notasi CIDR (Classless Inter-Domain Routing): Panjang prefix bit mask (misal: `/24` memiliki 24-bit network mask `255.255.255.0` dan menyisakan 8-bit host = 256 alamat IP, 254 usable).
  - **IP Publik vs IP Privat (RFC 1918):**
    - Rentang Privat: `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`.
    - Mengapa IP privat tidak dapat di-routing langsung di internet publik.
  - **Network Address Translation (NAT):**
    - SNAT (Source NAT) & Masquerading: Mengizinkan ribuan server privat di subnet internal mengakses internet luar melalui 1 IP gateway publik bersama.
    - DNAT (Destination NAT) / Port Forwarding: Meneruskan traffic eksternal ke host privat di dalam jaringan.
* **Lab & Praktik Nyata:**
  - Menghitung pembagian subnet VPC untuk arsitektur 3-Tier:
    - Subnet Publik (Load Balancer): `10.0.1.0/24`
    - Subnet Privat Aplikasi (Backend Services): `10.0.2.0/24`
    - Subnet Privat Database (Isolasi total tanpa akses internet luar): `10.0.3.0/24`
* **Common Pitfalls & Anti-Patterns:**
  - Mengalokasikan subnet terlalu sempit (misal `/28` = hanya 16 IP) di cloud Kubernetes di mana tiap Pod mengonsumsi 1 IP, mengakibatkan cluster kehabisan IP address (*IP exhaustion*).
* **Definition of Done (DoD):** Siswa mampu menghitung rentang IP, usable host, network address, dan broadcast address dari notasi CIDR mana pun dalam hitungan detik.

---

### Fase 19: DNS Resolution, Web Server Nginx & Reverse Proxy
* **Sasaran Kompetensi:** Mengonfigurasi web server performa tinggi, reverse proxying, SSL/TLS termination, dan mitigasi load balancing.
* **First Principles & Teori Mendalam:**
  - **Hierarki Resolusi DNS:**
    - Browser Cache -> OS Resolver Cache -> Recursive DNS (ISP / `1.1.1.1`) -> Root Nameservers (`.`) -> TLD Nameservers (`.com`, `.id`) -> Authoritative Nameservers.
    - Record Tipe: A (IPv4), AAAA (IPv6), CNAME (Canonical Name alias), MX (Mail), TXT (SPF/DKIM verification).
  - **Arsitektur Nginx:**
    - Mengapa Nginx jauh lebih cepat dan hemat memori dibanding Apache: Model *Event-Driven Asynchronous Non-blocking (epoll di Linux / kqueue di BSD)* dengan sedikit Worker Process, bukan *Thread-per-connection* (Apache prefork).
  - **Fitur Utama Nginx di Industri:**
    - *Reverse Proxy:* Meneruskan request dari internet publik ke port aplikasi internal (`proxy_pass http://127.0.0.1:3000;`).
    - *Load Balancing Algorithms:* Round Robin, Least Connections, IP Hash (session persistence).
    - *SSL/TLS Termination:* Menangani enkripsi HTTPS di perimeter luar sehingga backend service di jaringan privat berjalan ringan dengan HTTP polos.
* **Lab & Praktik Nyata:**
  - Menulis file konfigurasi `nginx.conf` production-ready: Rate limiting burst zone, gzip compression, caching static assets 30 hari, security headers (`HSTS`, `X-Content-Type-Options`, `X-Frame-Options`).
* **Common Pitfalls & Anti-Patterns:**
  - Mengabaikan setting header `proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;` yang mengakibatkan backend logging mencatat IP load balancer alih-alih IP asli pengguna.
* **Definition of Done (DoD):** Siswa mampu menulis konfigurasi Nginx reverse proxy yang lolos audit keamanan SSL Labs (A+ rating).

</details>

<br>

<details open>
<summary><strong>🐳 BAGIAN VII: TRACK DEVOPS, DOCKER & CI/CD (Fase 20 - 22)</strong></summary>
<br>

### Fase 20: Kontainerisasi Tingkat Rendah & Docker Architecture
* **Sasaran Kompetensi:** Membedah bahwa kontainer bukanlah Virtual Machine, memahami isolasi kernel Linux, dan membuat image kontainer produksi yang sangat ringkas.
* **First Principles & Teori Mendalam (Riset: Linux Kernel Primitives & OCI):**
  - **"Containers are Just Isolated Linux Processes":**
    - Tidak ada virtualisasi hardware atau hypervisor. Kontainer berbagi satu kernel Linux yang sama dengan host OS.
  - **2 Pilar Utama Kernel Linux:**
    1. **Linux Namespaces (Membatasi apa yang bisa DILIHAT proses):**
       - `PID Namespace`: Isolasi nomor proses (proses di kontainer merasa dirinya PID 1).
       - `NET Namespace`: Virtual network interface, routing table, dan port terisolasi sendiri.
       - `MNT Namespace`: Mount points terisolasi (root filesystem sendiri).
       - `IPC / UTS / USER Namespaces`: Inter-process communication, hostname, dan pemetaan UID/GID.
    2. **Control Groups / cgroups v2 (Membatasi apa yang bisa DIGUNAKAN proses):**
       - Membatasi limit CPU quota, memory limits (mencegah OOM Killer mematikan host), block I/O throttle.
  - **Layered Storage:** OverlayFS (Upper writable layer + Lower read-only image layers).
  - **Arsitektur Docker:** Docker CLI -> Docker Daemon (`dockerd`) -> `containerd` -> `runc` (OCI reference implementation).
* **Lab & Praktik Nyata:**
  - Menulis *Multi-Stage Dockerfile* untuk aplikasi fullstack: Memisahkan builder environment (Node/Go SDK) dari production runner minimal berbasis `alpine` atau `scratch`, memangkas ukuran image dari 1.2 GB menjadi 25 MB.
* **Common Pitfalls & Anti-Patterns:**
  - Menjalankan kontainer sebagai user `root` (ancaman fatal container breakout ke sistem host OS).
* **Definition of Done (DoD):** Siswa mampu menjelaskan perbedaan namespaces vs cgroups dan menghasilkan image Docker dengan skor audit keamanan zero critical vulnerabilities.

---

### Fase 21: Jaringan, Volume & Multi-Container dengan Docker Compose
* **Sasaran Kompetensi:** Mengatur orkestrasi multi-kontainer pada lingkungan lokal/staging serta memahami persistensi volume dan jaringan inter-service.
* **First Principles & Teori Mendalam:**
  - **Docker Storage Drivers & Data Persistence:**
    - *Ephemeral Layer:* Data yang ditulis ke kontainer hilang saat kontainer di-destroy.
    - *Named Volumes:* Dikelola Docker di `/var/lib/docker/volumes/`, performa native, solusi utama database.
    - *Bind Mounts:* Memetakan folder host spesifik (`./src:/app/src`), ideal untuk live-reload pengembangan lokal.
  - **Docker Network Drivers:**
    - *Bridge Network (Default):* Virtual bridge (`docker0`), kontainer dalam satu user-defined bridge network dapat saling memanggil menggunakan nama servicenya (Docker internal DNS resolution).
    - *Host Network:* Menghilangkan isolasi jaringan, performa raw tanpa NAT.
    - *Overlay Network:* Komunikasi kontainer antar multi-host server (Docker Swarm / Kubernetes).
* **Lab & Praktik Nyata:**
  - Menulis berkas `docker-compose.yml` multi-layanan produksi: Web Frontend + Backend API + SQLite/Postgres DB + Redis Cache, lengkap dengan dependensi `depends_on` dengan healthcheck (`condition: service_healthy`).
* **Common Pitfalls & Anti-Patterns:**
  - Mengandalkan `depends_on` tanpa healthcheck (port database sudah terbuka namun database engine belum selesai melakukan booting inisialisasi tabel).
* **Definition of Done (DoD):** Seluruh stack aplikasi dapat dinyalakan dengan satu perintah `docker compose up -d` dan data database tetap utuh saat kontainer dimatikan dan dinyalakan kembali.

---

### Fase 22: Otomasi CI/CD & Deployment Pipeline Zero-Downtime
* **Sasaran Kompetensi:** Merancang pipeline Continuous Integration dan Continuous Deployment otomatis yang andal, aman, dan tanpa downtime (*Zero-Downtime Deployment*).
* **First Principles & Teori Mendalam:**
  - **Continuous Integration (CI):**
    - Filosofi: Mengintegrasikan kode ke branch utama sesering mungkin.
    - Tahapan Pipeline: Linting -> Static Analysis / Typecheck -> Automated Unit Testing -> Integration Testing -> Security Dependency Scan (Trivy / Snyk) -> Build Container Image.
  - **Strategi Deployment Industri:**
    - *Recreate:* Matikan v1, nyalakan v2 (mengakibatkan downtime beberapa menit).
    - *Rolling Update:* Ganti instance secara bertahap satu per satu di balik load balancer (zero-downtime, hemat sumber daya).
    - *Blue-Green Deployment:* Menyalakan environment v2 (Green) secara penuh di samping v1 (Blue), lalu mengalihkan traffic load balancer 100% instan (rollback instan).
    - *Canary Release:* Mengalihkan 5% traffic pengguna ke versi baru untuk menguji stabilitas error rate sebelum rilis 100%.
* **Lab & Praktik Nyata:**
  - Membuat workflow `.github/workflows/deploy.yml`: Otomatis menjalankan unit testing, membuat release tag, mengompilasi image, dan melakukan rilis otomatis ke GitHub Pages / VPS server via SSH Actions.
* **Common Pitfalls & Anti-Patterns:**
  - Menyimpan token akses database atau secret API keys langsung di file script repository alih-alih menggunakan GitHub Repository Secrets / HashiCorp Vault.
* **Definition of Done (DoD):** Setiap pull request yang di-merge ke branch `main` memicu automated test dan otomatis ter-deploy tanpa intervensi manual.

</details>

<br>

<details open>
<summary><strong>🔤 BAGIAN VIII: TRACK BAHASA PEMROGRAMAN, RUNTIMES & GIT ADVANCED (Fase 23 - 25)</strong></summary>
<br>

### Fase 23: Paradigma Bahasa & Analisis Runtime Execution
* **Sasaran Kompetensi:** Memahami bagaimana kode komputer dieksekusi oleh prosesor, karakteristik berbagai runtime, dan memilih bahasa pemrograman yang tepat untuk kebutuhan sistem tertentu.
* **First Principles & Teori Mendalam:**
  - **Sistem Pengetikan (Type Systems):**
    - *Static vs Dynamic:* Tipe diperiksa saat waktu kompilasi (Go, Rust, TypeScript) vs saat runtime (Python, JavaScript, PHP).
    - *Strong vs Weak:* Bahasa melarang implisit type coercion yang berbahaya (Python adalah strong dynamic: `"5" + 2` error) vs mengizinkan konversi aneh (JavaScript adalah weak dynamic: `"5" + 2 = "52"`).
  - **3 Model Eksekusi Kode:**
    1. *Direct Machine Code Compilation:* Kode dikonversi langsung menjadi instruksi biner CPU (C, C++, Go, Rust). Performa puncak, startup instan, zero runtime overhead.
    2. *Bytecode Virtual Machine:* Kode dikompilasi menjadi bytecode perantara yang dieksekusi oleh VM (Java/JVM, C#/.NET CLR). Portabilitas lintas OS, optimasi JIT bertingkat (*Tiered Compilation*).
    3. *JIT Interpreted Engine:* Dynamic code parsing dan JIT optimization on-the-fly (V8 pada Node.js/Chromium, PyPy). Cepat untuk prototyping, namun memiliki pemakaian memori awal lebih tinggi.
  - **Matriks Pemilihan Bahasa Industri:**
    - *Go:* Konkurensi tinggi via goroutines, compile super cepat, microservices standar cloud.
    - *Rust:* Sistem bare-metal, zero-cost abstractions, memory safety tanpa Garbage Collector.
    - *Python:* Dominasi ekosistem AI, Machine Learning, dan Data Engineering.
    - *TypeScript:* Standar universal fullstack web, ekosistem library npm terbesar di dunia.
* **Lab & Praktik Nyata:**
  - Benchmark komputasi algoritma Fibonacci di berbagai runtime (Go vs Node.js vs Python) dan analisis profil konsumsi CPU serta penggunaan memori RAM.
* **Common Pitfalls & Anti-Patterns:**
  - Memilih bahasa hanya karena tren (*hype-driven development*) alih-alih mengevaluasi kecocokan karakteristik runtime terhadap masalah bisnis yang dihadapi.
* **Definition of Done (DoD):** Siswa mampu menyusun dokumen arsitektur *Language Selection Justification Matrix* berdasarkan karakteristik memori, latensi, dan ekosistem.

---

### Fase 24: Manajemen Memori & Garbage Collection Internals
* **Sasaran Kompetensi:** Menguasai cara sistem operasi dan runtime mengelola alokasi memori komputer, mendeteksi memory leak, dan membedah internal Garbage Collector.
* **First Principles & Teori Mendalam:**
  - **Stack vs Heap Allocation:**
    - *Stack:* Alokasi otomatis berbasis LIFO (*Last-In, First-Out*), super cepat (hanya menggeser stack pointer register), alokasi lokal untuk fungsi primitif. Ukuran fixed.
    - *Heap:* Alokasi dinamis untuk objek ukuran variabel/panjang, dikelola melalui memory allocator. Membawa overhead fragmentasi dan membutuhkan dereferensi pointer.
    - *Escape Analysis:* Bagaimana compiler (Go / Java) memutuskan apakah variabel tetap di Stack atau "kabur" (*escapes*) ke Heap.
  - **3 Filosofi Penanganan Memori di Industri:**
    1. *Manual Memory Management (C/C++):* `malloc()` / `free()`. Cepat tanpa interupsi, namun berisiko fatal: *Memory Leak*, *Dangling Pointer*, *Buffer Overflow*, *Use-After-Free*.
    2. *Tracing Garbage Collection (Java, Go, V8 JS):*
       - *Mark-and-Sweep:* Menelusuri graph objek dari *GC Roots*. Menandai yang hidup, menyapu yang mati.
       - *Generational Hypothesis:* Asumsi bahwa sebagian besar objek mati muda (Young Generation: Eden/Survivor -> Old/Tenured Generation).
       - *Stop-The-World (STW) Pauses:* Waktu jeda eksekusi aplikasi saat GC merapikan memori.
    3. *Ownership & Borrow Checker (Rust):*
       - Setiap nilai di memori hanya memiliki **satu pemilik (single owner)**. Saat pemilik keluar dari scope (`}`), memori langsung dibebaskan otomatis saat kompilasi.
       - Aturan Borrowing: Boleh banyak referensi baca immutable (`&T`) ATAU satu referensi tulis mutable (`&mut T`), tidak boleh keduanya bersamaan. Zero memory leak tanpa butuh runtime GC!
* **Lab & Praktik Nyata:**
  - Membuat simulasi memory leak di Node.js (closure retain reference pada global array) dan menggunakan Chrome DevTools / Heap Snapshot untuk melacak *Retaining Path* objek yang bocor.
* **Common Pitfalls & Anti-Patterns:**
  - Menyimpan event listener di DOM atau global object tanpa melepaskannya (`removeEventListener`) saat komponen dihancurkan.
* **Definition of Done (DoD):** Siswa mampu membaca Heap Snapshot untuk mendiagnosis memory leak dan menjelaskan cara kerja rust ownership model.

---

### Fase 25: Git Internals & Engineering Collaboration Workflow
* **Sasaran Kompetensi:** Menguasai struktur data internal Git tingkat rendah (*plumbing*) dan menerapkan alur kolaborasi rekayasa standar tim engineering kelas dunia.
* **First Principles & Teori Mendalam (Riset: Git Internals DAG Architecture):**
  - **Content-Addressable Storage:**
    - Git adalah filesystem beralamat konten. Setiap data diidentifikasi oleh hash SHA-1 / SHA-256 dari isinya. Jika isi file berubah 1 byte saja, hash-nya berubah total.
  - **4 Tipe Objek Inti di `.git/objects`:**
    1. *Blob (Binary Large Object):* Menyimpan isi mentah berkas (tanpa nama file atau izin akses). Otomatis deduplikasi jika ada 2 file dengan isi identik!
    2. *Tree:* Mewakili direktori. Memetakan nama file, izin POSIX, dan referensi pointer ke SHA Blob atau sub-Tree lainnya.
    3. *Commit:* Snapshot proyek pada titik waktu tertentu. Berisi pointer ke root Tree, parent commit SHA, metadata author, committer, timestamp, dan commit message.
    4. *Annotated Tag:* Referensi permanen berlabel ke commit tertentu.
  - **Directed Acyclic Graph (DAG):**
    - Commit membentuk graph berarah tanpa siklus. Branch hanyalah file teks kecil 41-byte di `.git/refs/heads/` yang berisi SHA commit terakhir (pointer bergerak).
  - **Plumbing vs Porcelain Commands:**
    - Porcelain (High-level): `git commit`, `git add`, `git branch`.
    - Plumbing (Low-level): `git hash-object`, `git cat-file -p`, `git write-tree`, `git commit-tree`.
  - **Strategi Kolaborasi & Rekayasa:**
    - *Rebase vs Merge:* Linear commit history (`git rebase`) vs preserving historical parallel branches (`git merge --no-ff`).
    - *Trunk-Based Development:* Seluruh engineer melakukan merge commit kecil setiap hari ke branch utama (`main`) dilindungi oleh **Feature Flags / Feature Toggles**, meninggalkan alur rumit GitFlow.
    - *Teknik Darurat:* Mengembalikan commit yang terhapus via `git reflog`, memindahkan commit parsial via `git cherry-pick`, dan pencarian binary search otomatis baris pembuat bug menggunakan `git bisect`.
* **Lab & Praktik Nyata:**
  - Membuat commit Git dari nol tanpa perintah `git add` atau `git commit`: Menggunakan perintah plumbing `git hash-object -w`, `git write-tree`, dan `git commit-tree` langsung di terminal.
* **Common Pitfalls & Anti-Patterns:**
  - Melakukan `git push --force` ke branch bersama (yang menghancurkan histori DAG milik rekan tim).
* **Definition of Done (DoD):** Siswa mampu menjelaskan struktur internal direktori `.git/` dan melakukan operasi penyelamatan kode menggunakan `git reflog` serta binary debug dengan `git bisect`.

</details>

<br>

<details open>
<summary><strong>🧪 BAGIAN IX: TRACK TESTING, OBSERVABILITY & RELIABILITY ENGINEERING (Fase 26 - 28)</strong></summary>
<br>

### Fase 26: Piramida Testing, TDD & Contract Testing (Playwright & Pact)
* **Sasaran Kompetensi:** Merancang strategi pengujian otomatis end-to-end yang tangguh, mencegah regresi kode di produksi, dan memvalidasi kontrak integrasi API.
* **First Principles & Teori Mendalam:**
  - **The Testing Pyramid (Martin Fowler):**
    - *Unit Tests (Dasar, Cepat, Banyak):* Menguji fungsi murni dan domain logic secara terisolasi tanpa I/O network atau database nyata.
    - *Integration Tests (Menengah):* Memvalidasi interaksi antar modul (misal: Service memanggil Database SQLite nyata melalui Repository).
    - *End-to-End (E2E) Tests (Puncak, Lambat, Presisi):* Menjalankan browser tanpa kepala (headless Chromium) via Playwright untuk menguji alur pengguna nyata dari frontend ke backend.
  - **TDD (Test-Driven Development):**
    - Siklus *Red-Green-Refactor*: Menulis tes gagal terlebih dahulu -> menulis implementasi seminimal mungkin hingga tes lulus -> merefaktor kode dengan rasa aman.
  - **Contract Testing (Pact):**
    - *Consumer-Driven Contracts:* Menghilangkan kebutuhan staging environment raksasa dengan memvalidasi skema payload antara Consumer (Frontend/Mobile) dan Provider (Backend API) secara otomatis sebelum deployment.
* **Lab & Praktik Nyata:**
  - Menulis test suite Playwright E2E untuk alur checkout pesanan e-commerce (pilih produk -> isi alamat -> pilih metode pembayaran -> verifikasi nota pembelian).
* **Common Pitfalls & Anti-Patterns:**
  - *The Inverted Testing Pyramid (Ice Cream Cone):* Terlalu banyak tes E2E yang lambat dan rapuh (*flaky tests*) namun miskin unit tests pada domain logic inti.
* **Definition of Done (DoD):** Seluruh pipeline pengujian berjalan otomatis dengan cakupan (*coverage*) > 85% dan waktu eksekusi unit test < 5 detik.

---

### Fase 27: Tiga Pilar Observability (Logs, Metrics, Traces) & W3C Trace Context
* **Sasaran Kompetensi:** Mengimplementasikan telemetri sistem produksi terdistribusi menggunakan standar OpenTelemetry untuk melacak bottleneck latensi dan akar masalah kegagalan secara instan.
* **First Principles & Teori Mendalam (Riset: W3C & OpenTelemetry Standards):**
  - **Tiga Pilar Observability:**
    1. *Structured Logging (Logs):* Log beralamat JSON dengan level konsisten (`INFO`, `WARN`, `ERROR`) yang diindeks oleh Loki / Elasticsearch.
    2. *Time-Series Metrics (Metrics):* Metrik teragregasi (Prometheus). Tipe metrik: *Counter* (hanya naik, misal: total request), *Gauge* (naik-turun, misal: memory usage), *Histogram* (distribusi durasi request p50, p95, p99), dan *Summary*.
    3. *Distributed Tracing (Traces):* Visualisasi perjalanan request melewati puluhan microservices. Terdiri dari *Trace ID* dan hirarki *Span ID*.
  - **W3C Trace Context Specification:**
    - Standardisasi HTTP Header `traceparent` lintas platform:
      `00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01`
      (Version 2-digit, Trace ID 32-hex, Parent Span ID 16-hex, Trace Flags 2-digit).
  - **Metodologi Monitoring:**
    - *RED Method (Request-driven services):* **R**ate (request/sec), **E**rrors (failed requests/sec), **D**uration (latency distribution).
    - *USE Method (Resource-driven hardware):* **U**tilization (%), **S**aturation (queue length), **E**rrors (hardware faults).
* **Lab & Praktik Nyata:**
  - Menghubungkan aplikasi ke OpenTelemetry SDK, mempropagasi header `traceparent` antar service, dan memvisualisasikan waterfall trace latensi di Grafana Tempo.
* **Common Pitfalls & Anti-Patterns:**
  - Melakukan *unstructured logging* (`console.log("error disini")`) tanpa timestamp, trace ID, atau metadata yang menyulitkan pencarian saat insiden produksi.
* **Definition of Done (DoD):** Siswa mampu mendeteksi endpoint bottleneck lambat menggunakan waterfall distributed tracing dan membuat dashboard Grafana dengan metrik RED.

---

### Fase 28: Site Reliability Engineering (SRE), Chaos & Resiliency Patterns
* **Sasaran Kompetensi:** Membangun sistem yang mampu bertahan dari kegagalan jaringan dan lonjakan beban ekstrem menggunakan pola ketahanan sistem (*resilience engineering*).
* **First Principles & Teori Mendalam (Riset: Google SRE Handbook):**
  - **Fondasi Keandalan SRE:**
    - *SLI (Service Level Indicator):* Metrik kepatuhan kuantitatif (misal: % request yang sukses dengan latensi < 200ms).
    - *SLO (Service Level Objective):* Target internal tim (misal: 99.9% request berhasil selama periode 30 hari).
    - *SLA (Service Level Agreement):* Komitmen hukum terhadap klien bisnis dengan konsekuensi finansial.
    - *Error Budget:* Jatah toleransi kegagalan (100% - SLO) yang dapat digunakan oleh tim untuk merilis fitur baru dengan cepat.
  - **Pola Desain Ketahanan (Resiliency Patterns):**
    - *Circuit Breaker (Finite State Machine):*
      - `CLOSED`: Aliran request normal.
      - `OPEN`: Saat ambang batas error terlampaui, request langsung digagalkan seketika tanpa membebani backend yang sedang tumbang.
      - `HALF-OPEN`: Menguji beberapa request sampel secara berkala untuk mengecek pemulihan server downstream.
    - *Retry with Exponential Backoff & Full Jitter:* Mencegah *thundering herd* saat server pulih via formula probabilistik.
    - *Bulkhead Pattern:* Mengisolasi resource pool (thread pool / database connection pool) agar kegagalan satu fitur tidak menumbangkan seluruh sistem.
* **Lab & Praktik Nyata:**
  - Menulis implementasi Circuit Breaker state machine di JavaScript/Node.js dan melakukan injeksi *Chaos Engineering* (mematikan port dependensi secara acak) untuk membuktikan sistem tetap responsif memberikan response *fallback*.
* **Common Pitfalls & Anti-Patterns:**
  - Melakukan retry request secara instan dan serentak (*retry storm*) yang justru memperparah kondisi server yang sedang mengalami *overload*.
* **Definition of Done (DoD):** Sistem memiliki Circuit Breaker teruji yang beralih ke state OPEN saat error rate > 50% dan mampu kembali pulih ke state CLOSED secara otomatis.

</details>

<br>

<details open>
<summary><strong>☁️ BAGIAN X: TRACK DISTRIBUTED CACHING, SCALABILITY & CAPSTONE (Fase 29 - 30)</strong></summary>
<br>

### Fase 29: Distributed Caching, Redis Internals & Algoritma XFetch
* **Sasaran Kompetensi:** Mendesain sistem caching terdistribusi berkinerja tinggi serta mencegah bencana *Cache Stampede / Thundering Herd* menggunakan algoritma probabilistik.
* **First Principles & Teori Mendalam (Riset: Redis Engine & Vattani et al.):**
  - **Pola Arsitektur Caching:**
    - *Cache-Aside (Lazy Loading):* Aplikasi membaca dari cache; jika miss, aplikasi mengambil dari database lalu menulis ke cache.
    - *Write-Through:* Menulis ke cache dan database secara sinkron bersamaan.
    - *Write-Behind (Write-Back):* Menulis ke cache terlebih dahulu, lalu di-flush ke database secara asinkron (performa tulis sangat tinggi).
  - **Arsitektur Internal Redis:**
    - Single-threaded event loop berbasis *I/O multiplexing (epoll)*, memory allocator jemalloc, protokol serialisasi biner RESP (*REdis Serialization Protocol*).
    - Struktur data internal: SDS (Simple Dynamic String), ZipList, QuickList, SkipList (untuk Sorted Sets `ZSET`).
  - **Mitigasi Bencana Cache Stampede (Dogpiling):**
    - Terjadi ketika kunci cache yang sangat populer (*hot key*) kedaluwarsa, memicu ribuan request bersamaan membobol database secara simultan.
    - *Algoritma XFetch (Probabilistic Early Recomputation):*
      Merekalkulasi nilai cache secara asinkron sebelum waktu kedaluwarsa tiba tanpa membutuhkan distributed lock yang mahal:
      $$\text{current\_time} - (\delta \times \beta \times \ln(\text{random}())) \ge \text{expiry\_time}$$
      di mana $\delta$ adalah durasi kalkulasi sebelumnya, dan $\beta > 0$ adalah parameter agresivitas pre-fetching.
  - **Consistent Hashing:** Distribusi kunci cache merata di cluster multi-node dengan penambahan/pengurangan node tanpa kehilangan seluruh data cache.
* **Lab & Praktik Nyata:**
  - Implementasi fungsi cache-aside dengan algoritma XFetch di Node.js/SQLite untuk query laporan penjualan terberat, mengukur stabilitas latensi p99 di bawah beban 1.000 concurrent virtual users.
* **Common Pitfalls & Anti-Patterns:**
  - Tidak menetapkan TTL (Time-To-Live) pada cache key atau menggunakan pola invalidasi cache global `FLUSHALL` di server produksi.
* **Definition of Done (DoD):** Siswa mampu mengeliminasi spike latensi cache stampede menggunakan algoritma XFetch dan mendokumentasikan efisiensi hit rate cache > 95%.

---

### Fase 30: Capstone Project: End-to-End Enterprise System Design & Production Deployment
* **Sasaran Kompetensi:** Menggabungkan seluruh 29 fase sebelumnya ke dalam satu rancang bangun arsitektur sistem skala enterprise yang siap menangani 100.000 QPS.
* **First Principles & Teori Mendalam (Riset: Alex Xu, *System Design Interview*):**
  - **Horizontal Scaling & Database Sharding:**
    - Master-Replica Replication: Master menangani mutasi `INSERT`/`UPDATE`, read replicas menangani query `SELECT`.
    - Sharding Strategies: Range-based vs Hash-based partitioning (menggunakan Consistent Hashing).
  - **Edge Caching & CDN:** Cloudflare / Fastly CDN edge distribution untuk file statis HTML/CSS/JS dan dynamic API caching.
  - **Disaster Recovery (DR):** RPO (Recovery Point Objective - toleransi kehilangan data) dan RTO (Recovery Time Objective - toleransi durasi downtime sistem).
* **Lab Praktik Nyata (Capstone):**
  - Menyusun cetak biru arsitektur lengkap sistem Fundamental Coding:
    1. Frontend: Semantic HTML5 + Blue CSS3 + SPA Router (0ms TTFB).
    2. Backend API: REST & gRPC endpoints dengan rate limiting dan distributed tracing OpenTelemetry.
    3. Database: Relational SQLite / PostgreSQL dengan replikasi, B+Tree covering index, dan Redis caching layer (XFetch).
    4. Infrastruktur: Kontainer Docker minimal multi-stage, reverse proxy Nginx SSL A+, dan pipeline CI/CD GitHub Actions.
* **Common Pitfalls & Anti-Patterns:**
  - Melakukan *premature optimization* berlebihan sebelum mengidentifikasi bottleneck nyata menggunakan empirical profiling data.
* **Definition of Done (DoD):** Dokumentasi arsitektur sistem lengkap (System Design Document) yang divalidasi dengan stress testing load benchmark, zero critical vulnerabilities, dan zero downtime deployment.

</details>

---

## 4. Rencana Jadwal Eksekusi & Tahapan Segera

<table width="100%">
  <thead>
    <tr style="background:#111C38; color:#F8FAFC;">
      <th width="15%">Milestone</th>
      <th width="25%">Fokus Pengerjaan</th>
      <th width="40%">Deliverables Utama</th>
      <th width="20%">Status</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Milestone 1</strong></td>
      <td><strong>Platform Foundation &amp; Interactive Plan</strong></td>
      <td>
        - Mengunci stack Pure Semantic HTML5 + Modern Blue CSS3 + ES6 JS<br>
        - Berkas master <code>PLAN.md</code> diperbarui lengkap dengan riset global<br>
        - Berkas web dashboard interaktif <code>plan.html</code> dibuat dan aktif
      </td>
      <td><span style="background:#065F46; color:#34D399; padding:2px 8px; border-radius:4px; font-weight:700;">SELESAI (Current)</span></td>
    </tr>
    <tr>
      <td><strong>Milestone 2</strong></td>
      <td><strong>Portal Roadmap &amp; Dynamic Navigation (Fase 1-3)</strong></td>
      <td>
        - Redesain <code>index.html</code> menjadi Dashboard Multi-Track 10 Track<br>
        - Implementasi <code>assets/nav-data.json</code> &amp; Dynamic Sidebar Accordion<br>
        - Standarisasi Component Library &amp; Callout Box Industri
      </td>
      <td><span style="background:#1E3260; color:#60A5FA; padding:2px 8px; border-radius:4px; font-weight:700;">BERIKUTNYA</span></td>
    </tr>
    <tr>
      <td><strong>Milestone 3</strong></td>
      <td><strong>Deep Database &amp; SQL Internals (Fase 4-6)</strong></td>
      <td>
        - Modul B-Tree, Slotted Pages, LSM-Tree, dan WAL<br>
        - Modul Indexing Optimization &amp; Bedah Query Plan<br>
        - Modul Concurrency Anomalies, MVCC &amp; 2PL Locking
      </td>
      <td><span style="background:#334155; color:#94A3B8; padding:2px 8px; border-radius:4px; font-weight:700;">TERENCANA</span></td>
    </tr>
    <tr>
      <td><strong>Milestone 4</strong></td>
      <td><strong>Frontend, Backend &amp; Architecture (Fase 7-16)</strong></td>
      <td>
        - Browser Pipeline, Event Loop &amp; Modern CSS Architecture<br>
        - HTTP/2, HTTP/3 QUIC, REST, GraphQL, gRPC &amp; OWASP Security<br>
        - Monorepo vs Polyrepo, Modular Monolith, Clean Arch &amp; DDD
      </td>
      <td><span style="background:#334155; color:#94A3B8; padding:2px 8px; border-radius:4px; font-weight:700;">TERENCANA</span></td>
    </tr>
    <tr>
      <td><strong>Milestone 5</strong></td>
      <td><strong>Linux, DevOps &amp; Git Internals (Fase 17-25)</strong></td>
      <td>
        - TCP/IP, CIDR Subnetting, Nginx Reverse Proxy &amp; SSL<br>
        - Linux Namespaces/cgroups, Docker Multi-stage &amp; CI/CD Actions<br>
        - Language Runtimes, Memory Management Heap/GC &amp; Git DAG Internals
      </td>
      <td><span style="background:#334155; color:#94A3B8; padding:2px 8px; border-radius:4px; font-weight:700;">TERENCANA</span></td>
    </tr>
    <tr>
      <td><strong>Milestone 6</strong></td>
      <td><strong>Testing, Observability, Caching &amp; Capstone (Fase 26-30)</strong></td>
      <td>
        - Testing Pyramid (Playwright E2E &amp; Pact Contract Testing)<br>
        - Observability OpenTelemetry (W3C traceparent, Prometheus, Grafana RED)<br>
        - SRE &amp; Circuit Breaker Resiliency, Distributed Caching Redis (XFetch)<br>
        - Capstone: 100K QPS Enterprise System Architecture Blueprints
      </td>
      <td><span style="background:#334155; color:#94A3B8; padding:2px 8px; border-radius:4px; font-weight:700;">TERENCANA</span></td>
    </tr>
  </tbody>
</table>

---

*Dokumen ini merupakan Single Source of Truth kurikulum Fundamental Coding (Velora). Semua perubahan materi dan fase implementasi harus merujuk pada prinsip pertama rekayasa perangkat lunak dan arsitektur industri nyata.*
