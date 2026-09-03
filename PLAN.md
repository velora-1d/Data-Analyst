# MASTER IMPLEMENTATION PLAN: FUNDAMENTAL CODING (10 MACRO-PHASES)
> **Platform Edukasi Rekayasa Perangkat Lunak, Full-Stack, Database, Arsitektur & Infrastruktur**  
> **Dikembangkan oleh:** Velora | **Disusun oleh:** Mahin Utsman Nawawi, S.H  
> **Repository:** `https://github.com/velora-1d/Data-Analyst.git` (Folder: `Fundamental`)  
> **Roadmap Interaktif (Web App):** <a href="plan.html"><code>plan.html</code> (Buka dashboard interaktif di peramban)</a>

---

<div align="center">
  <span style="background: #2563EB; color: #FFFFFF; padding: 4px 12px; border-radius: 9999px; font-weight: 700; font-size: 13px;">MODEL: 10 FASE TERFOKUS (MACRO-MILESTONES)</span>
  <span style="background: #1E3260; color: #60A5FA; padding: 4px 12px; border-radius: 9999px; font-weight: 600; font-size: 13px;">STACK: PURE SEMANTIC HTML5 + BLUE CSS3 + MODULAR ES6 JS</span>
  <span style="background: #065F46; color: #34D399; padding: 4px 12px; border-radius: 9999px; font-weight: 600; font-size: 13px;">CAKUPAN: 8 DOMAIN REKAYASA SISTEM LENGKAP</span>
</div>

<br>

---

## 1. Visi, Filosofi & Keputusan Arsitektur

### A. Mengapa Memilih Model 10 Fase Terfokus?
Pendekatan **10 Fase Terfokus (*Macro-Milestones*)** dipilih untuk memastikan setiap fase memiliki **target keluaran (*deliverable*) yang nyata, berdampak, dan terukur**, tanpa membuat pengembang atau pembelajar merasa terbebani (*overwhelmed*) oleh daftar mikro puluhan checklist:
- **Tiap Fase Memiliki Output Nyata:** Bukan sekadar teori terpisah, melainkan gabungan konsep *first principles* yang langsung dibuktikan dengan lab praktis industri.
- **Rasional & Berkelanjutan:** 10 fase memberikan ritme eksekusi yang ideal untuk diselesaikan secara bertahap dan sistematis.
- **Standar Industri Global:** Mengintegrasikan riset dari *Database Internals* (Alex Petrov), *System Design Primer*, *Linux Kernel Primitives*, *Chrome Rendering Pipeline*, dan *Git DAG Internals*.

---

### B. Keputusan Teknologi: Pure HTML5 + Blue CSS3 + Modular JS (Zero Framework Overhead)

> <p><strong>KEPUTUSAN FINAL ARSITEKTUR:</strong><br>
> <em>"Udah, pakai HTML aja!"</em> — Seluruh keraguan terhadap penggunaan framework berat (Next.js / React / Nuxt) resmi dihentikan. Platform dibangun <strong>100% menggunakan Semantic HTML5 murni, Modern Blue CSS3 Design System, dan Modular ES6 JavaScript</strong>.</p>

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
      <td><strong>0ms (Instan)</strong>. Langsung dibuka dari filesystem atau static CDN tanpa cold start server.</td>
      <td>Membutuhkan server Node.js aktif atau waktu hydration bundle JavaScript React (~200ms - 1s).</td>
    </tr>
    <tr>
      <td><strong>Overhead &amp; Build Time</strong></td>
      <td><strong>Nol Build Step</strong>. Simpan file <code>.html</code> dan langsung refresh di browser. Zero compilation lock.</td>
      <td>Waktu kompilasi <code>next build</code> melonjak seiring bertambahnya materi.</td>
    </tr>
    <tr>
      <td><strong>Biaya Hosting &amp; Portabilitas</strong></td>
      <td><strong>100% Gratis Selamanya</strong>. Bisa di-hosting di GitHub Pages, Cloudflare Pages, atau flashdisk offline.</td>
      <td>Ketergantungan pada hosting Vercel Pro atau server VPS Node.js yang membutuhkan biaya berkala.</td>
    </tr>
    <tr>
      <td><strong>Pengalaman Belajar Siswa</strong></td>
      <td><strong>Transparan &amp; Nyata</strong>. Siswa bisa melakukan <em>Right-Click -&gt; Inspect Element</em> untuk melihat kode asli tanpa terbungkus bundler sintetis.</td>
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

## 2. Struktur Direktori Proyek

```text
Fundamental/
├── assets/
│   ├── script.js             # Instant SPA Router, Prefetcher, & Theme Engine (Local Memory)
│   ├── style.css              # Modern Blue Design System (#2563EB, #1E3260, #0B132B)
│   └── nav-data.json          # Single Source of Truth silabus 10 Fase Terfokus
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
└── modul/                     # Modul Pembelajaran Aktif (HTML Semantik Murni)
    ├── 01_tipe_data.html s/d 07_analisis_nyata.html
```

---

## 3. Rincian Silabus 10 Fase Terfokus (Macro-Milestones)

<details open>
<summary><strong>🚀 FASE 01: Fondasi Platform, Dynamic Navigation &amp; Instant Search</strong></summary>
<br>

* **Cakupan Topik:** Redesain Beranda Multi-Track (`index.html`), JSON-Driven Sidebar Accordion (`assets/nav-data.json`), Single Page Navigation, dan Standarisasi Component Library.
* **First Principles & Teori:**
  - *Cognitive Load Reduction (Hick's Law):* Menstrukturkan navigasi puluhan bab ke dalam modul berjenjang yang tidak membingungkan pembelajar.
  - *Single Source of Truth (SSOT):* Seluruh struktur kurikulum dikontrol oleh satu file `nav-data.json` tanpa duplikasi kode HTML di puluhan berkas.
  - *DOM Rendering Efficiency:* Pemanfaatan `DocumentFragment` untuk injeksi menu accordion secara efisien (hanya memicu 1 kali reflow DOM).
  - *In-Memory Fuzzy Search:* Pencarian cepat berbasis client-side JavaScript yang menyaring judul, deskripsi, dan tag kompetensi dalam hitungan milidetik.
* **Lab Praktik Nyata:**
  - Transformasi `index.html` menjadi dashboard kurikulum multi-track interaktif.
  - Implementasi komponen visual modular: `.callout-production` (kisah kegagalan produksi), `.callout-tradeoff` (analisis kelebihan vs kekurangan), dan `.callout-pitfall` (jebakan kode).
* **Common Pitfalls & Anti-Patterns:**
  - Melakukan duplikasi baris kode menu sidebar secara manual di setiap file HTML (mengakibatkan maintenance nightmare saat ada bab baru).
  - Melakukan manipulasi DOM satu per satu di dalam perulangan (`innerHTML += ...`) yang memicu *reflow thrashing*.
* **Definition of Done (DoD):** Siswa dapat menavigasi kurikulum dari beranda `index.html` dan sidebar otomatis menyala sesuai bab aktif dengan waktu muat 0ms.

</details>

<br>

<details open>
<summary><strong>🗄️ FASE 02: Database Storage Engine, B+Tree &amp; Indexing Optimization</strong></summary>
<br>

* **Cakupan Topik:** On-Disk Page Layout (4KB Slotted Pages), Struktur B-Tree vs B+Tree vs LSM-Tree, Compound Indexing (Leftmost Prefix Rule), dan Bedah `EXPLAIN QUERY PLAN`.
* **First Principles & Teori (Riset: Alex Petrov, *Database Internals*):**
  - *Slotted Page Structure:* Page Header (100 byte), Cell Pointers Array, Free Space Gap, dan Row Payload Data.
  - *B+Tree vs LSM-Tree:*
    - B+Tree: Seluruh data baris berada di leaf nodes yang saling terhubung dalam doubly linked list. Sangat optimal untuk OLTP read-heavy dan sequential range scans.
    - LSM-Tree (Log-Structured Merge-Tree): MemTable di RAM, Write-Ahead Log (WAL) sequential append, SSTables bertingkat di disk, Compaction (Size-Tiered vs Leveled), dan Bloom Filters untuk write-heavy workloads.
  - *Compound Index & Leftmost Prefix:* Indeks komposit `(status, created_at, total)` hanya berguna jika query memfilter kolom paling kiri (`status`).
  - *Akses Data:* Table Scan vs Index Scan vs Covering Index (Index Only Scan tanpa biaya table lookup).
* **Lab Praktik Nyata:**
  - Inspeksi biner header halaman 100-byte pada file `database/ecommerce.db`.
  - Mendiagnosis query lambat pada 5.600+ baris tabel `pesanan` dan mengonversinya dari `SCAN TABLE` menjadi `SEARCH TABLE USING COVERING INDEX`.
* **Common Pitfalls & Anti-Patterns:**
  - Membungkus kolom filter dengan fungsi kalkulasi (misal: `WHERE strftime('%Y', tanggal) = '2024'`) yang secara otomatis mematikan fungsi B-Tree indeks.
  - *Over-indexing:* Membuat indeks pada semua kolom yang justru memperlambat operasi `INSERT`/`UPDATE` karena overhead penulisan ulang pohon B-Tree.
* **Definition of Done (DoD):** Siswa mampu mentransformasikan kueri berstatus `SCAN TABLE` menjadi `SEARCH TABLE USING COVERING INDEX` dan mendokumentasikan penurunan latensinya.

</details>

<br>

<details open>
<summary><strong>🔒 FASE 03: Transaksi Database, Konkurensi &amp; Transaksi Terdistribusi</strong></summary>
<br>

* **Cakupan Topik:** 4 Anomali ANSI SQL, 4 Level Isolasi, Kontrol Konkurensi (2PL vs MVCC vs Optimistic), dan Pola Transaksi Terdistribusi (2PC vs Saga Pattern).
* **First Principles & Teori:**
  - *4 Anomali Data ANSI:* Dirty Read, Non-Repeatable Read, Phantom Read, dan Serialization Anomaly.
  - *4 Level Isolasi Standar:* Read Uncommitted, Read Committed, Repeatable Read, dan Serializable.
  - *Mekanisme Locking:*
    - Two-Phase Locking (2PL): Pessimistic locking via `SELECT ... FOR UPDATE` atau `BEGIN IMMEDIATE`.
    - Multi-Version Concurrency Control (MVCC): Pembaca tidak memblokir penulis, dan penulis tidak memblokir pembaca melalui snapshot isolasi.
    - Optimistic Concurrency Control (OCC): Verifikasi nomor versi baris (`version = ?`) sebelum commit.
  - *Transaksi Terdistribusi:* Keterbatasan Two-Phase Commit (2PC) sebagai blocking protocol; Solusi modern menggunakan **Saga Pattern** (Choreography berbasis Event vs Orchestration terpusat) dengan transaksi kompensasi (*compensating actions*).
* **Lab Praktik Nyata:**
  - Simulasi kasus *Flash Sale Checkout*: Dua koneksi konkuren mencoba membeli barang dengan `stok = 1`. Demonstrasi bug *Double Spending* tanpa lock vs proteksi pesimistik menggunakan lock transaksi.
* **Common Pitfalls & Anti-Patterns:**
  - Membuka transaksi terlalu lama (*long-running transactions*) yang memicu *lock contention* dan kehabisan memori undo-log.
* **Definition of Done (DoD):** Siswa mampu memetakan matriks level isolasi vs 4 anomali data serta menulis alur transaksi checkout yang bebas dari *deadlock*.

</details>

<br>

<details open>
<summary><strong>⚡ FASE 04: Browser Rendering Pipeline, Event Loop &amp; Web Performance (60 FPS)</strong></summary>
<br>

* **Cakupan Topik:** Critical Rendering Path (CRP), Perhitungan Geometri Layout (Reflow), Paint (Rasterization), GPU Compositing, Budget Frame 16.6ms (60 FPS), dan Arsitektur Event Loop.
* **First Principles & Teori (Riset: W3C & Chromium Architecture):**
  - *The Critical Rendering Path:* Bytes -> Characters -> Tokens -> Nodes -> DOM Tree + CSSOM Tree -> Render Tree -> Layout -> Paint -> Composite.
  - *Biaya Properti CSS:*
    - Pemicu Full Reflow (Mahal): `width`, `height`, `margin`, `top`, `left`, `fontSize`.
    - Pemicu Paint: `color`, `background-color`, `box-shadow`.
    - Khusus GPU Composite (Performa 60 FPS tanpa jank): `transform: translate3d()` dan `opacity`.
  - *The JavaScript Event Loop:*
    - Call Stack (Single thread).
    - Macrotask Queue (`setTimeout`, I/O).
    - Microtask Queue (`Promise.then()`, `queueMicrotask` - diproses habis sebelum render).
    - Render Phase: Eksekusi callback `requestAnimationFrame` tepat sebelum browser melukis layar.
* **Lab Praktik Nyata:**
  - Melakukan profiling performa menggunakan tab *Performance* Chrome DevTools: Mengidentifikasi *jank*, mendeteksi *Layout Thrashing*, dan mengoptimalkan animasi DOM.
* **Common Pitfalls & Anti-Patterns:**
  - *Forced Synchronous Layout / Layout Thrashing:* Membaca properti layout (`offsetHeight`) kemudian langsung menulis style DOM di dalam perulangan yang sama.
* **Definition of Done (DoD):** Siswa mampu menghilangkan layout thrashing pada antarmuka web dan menghasilkan animasi mulus 60 FPS menggunakan GPU compositing.

</details>

<br>

<details open>
<summary><strong>🎨 FASE 05: Modern CSS Architecture, Responsive Grid &amp; Design Tokens</strong></summary>
<br>

* **Cakupan Topik:** Algoritma 1D Flexbox vs 2D CSS Grid, CSS Custom Properties (Design Tokens), Implementasi Dark Mode Tanpa Flicker, dan Arsitektur CSS (BEM vs Utility-first vs CSS-in-JS).
* **First Principles & Teori:**
  - *Algoritma Layout:* Matematika ruang fleksibel Flexbox (`flex-grow`, `flex-shrink`, `flex-basis`) vs sistem koordinat 2 dimensi CSS Grid (`grid-template-columns`, `minmax()`, `fr` units).
  - *Design Tokens:* Sentralisasi palet warna, tipografi, dan radius menggunakan variabel CSS cascading (`:root`).
  - *Zero-Flicker Dark Mode:* Mengontrol tema via atribut `data-theme` pada tag `<html>` yang sinkron dengan `localStorage` sebelum browser melakukan render pertama.
  - *Komparasi CSS Industri:* BEM (struktur jelas, spesifisitas rendah) vs Utility-First Tailwind (zero unused CSS) vs CSS-in-JS (biaya runtime serialization JavaScript yang memperlambat INP).
* **Lab Praktik Nyata:**
  - Membangun layout grid katalog responsif menggunakan CSS murni `repeat(auto-fit, minmax(280px, 1fr))` tanpa membutuhkan satupun baris `@media query`.
* **Common Pitfalls & Anti-Patterns:**
  - Menggunakan `!important` untuk mengatasi masalah spesifisitas, yang merusak prinsip dasar pewarisan cascading CSS.
* **Definition of Done (DoD):** Seluruh antarmuka web platform menggunakan token warna biru modern modular dengan zero layout shift (CLS = 0).

</details>

<br>

<details open>
<summary><strong>🧩 FASE 06: Paradigma Framework Frontend &amp; Arsitektur State Management</strong></summary>
<br>

* **Cakupan Topik:** Virtual DOM Reconciliation (React) vs Compile-Time Reactivity (Svelte) vs Fine-Grained Signals (Solid/Vue), Model Rendering (CSR, SSR, SSG, ISR, Islands), Client State vs Server Cache Sync.
* **First Principles & Teori:**
  - *3 Paradigma Reaktivitas Framework:*
    1. Virtual DOM (React): Tree reconciliation dengan heuristik O(N), re-render subtree kecuali di-memoize.
    2. Compile-Time (Svelte): Tanpa VDOM. Mengubah assignment state langsung menjadi manipulasi DOM imperatif yang sangat hemat memori.
    3. Fine-Grained Signals (Solid/Vue): Observer pattern berbasis dependency graph. Hanya node DOM spesifik yang terkait signal yang di-update.
  - *Model Rendering Web Modern:* CSR (Client-Side Rendering) vs SSR (Server-Side Rendering) vs SSG (Static Generation) vs Islands Architecture.
  - *Arsitektur State:* Pemisahan tegas antara UI State Lokal dengan Server Cache State (caching, deduping, background refetch via TanStack Query/SWR pattern).
* **Lab Praktik Nyata:**
  - Membangun mini reactivity engine menggunakan JavaScript `Proxy` murni untuk auto-update elemen DOM saat properti objek dimutasi.
* **Common Pitfalls & Anti-Patterns:**
  - Memasukkan seluruh respons API backend ke dalam global Redux/Zustand store tanpa mekanisme invalidasi cache dan penanganan loading state yang benar.
* **Definition of Done (DoD):** Siswa memahami kapan sebuah proyek membutuhkan framework dan mampu membedah kelebihan serta kekurangan Virtual DOM vs Signals.

</details>

<br>

<details open>
<summary><strong>🌐 FASE 07: Protokol Jaringan, Evolusi HTTP/3 &amp; Arsitektur API</strong></summary>
<br>

* **Cakupan Topik:** Evolusi HTTP/1.1 -> HTTP/2 -> HTTP/3 QUIC, Real-Time Web (SSE vs WebSocket), Kontrak API (REST Richardson Maturity Model vs GraphQL AST &amp; DataLoader vs gRPC Protobuf).
* **First Principles & Teori:**
  - *Evolusi Protokol Transport & Aplikasi:*
    - HTTP/1.1: Head-of-Line (HoL) Blocking pada level HTTP request.
    - HTTP/2: Binary framing, multiplexing paralel dalam 1 koneksi TCP, kompresi header HPACK. Masalah: TCP packet-loss HoL blocking.
    - HTTP/3: Menggantikan TCP dengan **QUIC (UDP)**. Zero HoL blocking, 0-RTT connection handshake, dan seamless connection migration (transisi Wi-Fi ke 4G/5G tanpa putus).
  - *Real-time Web:* Kapan menggunakan Server-Sent Events (SSE: unidirectional streaming, hemat baterai/sumber daya) vs WebSocket (bidirectional full-duplex).
  - *Arsitektur API:*
    - REST: Resource-oriented, Cursor-based pagination (`WHERE id > last_id LIMIT 10`) vs Offset-based pagination.
    - GraphQL: Menghilangkan over/under-fetching; Memecahkan N+1 Query Problem menggunakan pola *DataLoader batching & caching*.
    - gRPC: Binary protocol buffers, streaming RPCs, efisiensi bandwidth 5x-10x lebih tinggi dibanding JSON untuk IPC microservices.
* **Lab Praktik Nyata:**
  - Menulis file `ecommerce.proto`, mengompilasinya menjadi stubs biner, dan membandingkan latensi serta ukuran paket binary Protobuf vs JSON payload.
* **Common Pitfalls & Anti-Patterns:**
  - Menggunakan WebSocket untuk feed data searah (seperti harga pasar atau notifikasi) yang sebenarnya jauh lebih stabil dan hemat jika memakai SSE.
* **Definition of Done (DoD):** Siswa mampu mendemonstrasikan efisiensi serialisasi binary Protobuf vs JSON dan menganalisis frame binary HTTP/2 di Wireshark.

</details>

<br>

<details open>
<summary><strong>🛡️ FASE 08: Autentikasi Modern, Otorisasi &amp; Pertahanan Keamanan API (OWASP)</strong></summary>
<br>

* **Cakupan Topik:** Stateful Session (Redis Store) vs Stateless JWT (Refresh Token Rotation), OAuth 2.0 PKCE, Pertahanan OWASP Top 10 API Security (BOLA, Rate Limiting, CORS, CSRF SameSite).
* **First Principles & Teori:**
  - *Stateful vs Stateless Authentication:*
    - Session Cookie: ID acak di cookie HTTP-only, validasi state di Redis cluster. Sangat mudah di-revoke instan.
    - JWT: Token mandiri (Header, Payload, Signature). Bebas query DB untuk verifikasi, namun rawan jika dicuri sebelum masa kedaluwarsa habis (wajib rotasi refresh token).
  - *OAuth 2.0 & OIDC:* Alur *Authorization Code Flow with PKCE* untuk Single Page Application (SPA) dan mobile clients.
  - *Pertahanan OWASP Top 10 API:*
    - BOLA (Broken Object Level Authorization): Validasi kepemilikan data tingkat baris (Row-Level Authorization).
    - Rate Limiting: Algoritma *Token Bucket* dan *Sliding Window Counter* menggunakan Redis.
    - CORS & Cookie Flags: SameSite (`Strict`/`Lax`), `HttpOnly`, `Secure` flags untuk mematikan ancaman XSS & CSRF.
* **Lab Praktik Nyata:**
  - Simulasi celah BOLA/IDOR pada endpoint transaksi dan menulis middleware otorisasi serta rate limiter berbasis sliding window.
* **Common Pitfalls & Anti-Patterns:**
  - Menyimpan token akses JWT di `localStorage` peramban yang rentan diekstraksi oleh skrip XSS jahat.
* **Definition of Done (DoD):** Siswa mampu membangun alur login aman berbasis HTTP-only cookies dengan mekanisme refresh token rotation dan proteksi brute-force.

</details>

<br>

<details open>
<summary><strong>🏛️ FASE 09: Arsitektur Sistem Skala Besar (Monorepo, Modular Monolith, Clean Arch &amp; DDD)</strong></summary>
<br>

* **Cakupan Topik:** Monorepo vs Polyrepo Trade-offs, Monolith vs Modular Monolith vs Microservices, Clean Architecture &amp; Hexagonal (DIP, Ports &amp; Adapters), Domain-Driven Design (DDD) &amp; Transactional Outbox Pattern.
* **First Principles & Teori:**
  - *Monorepo vs Polyrepo:*
    - Monorepo: Refactoring atomik multi-package, zero version drift, namun membutuhkan build tool graph canggih (Turborepo, Nx, Bazel).
    - Polyrepo: Otonomi repositori independen, namun rawan terjebak *dependency hell*.
  - *Evolusi Arsitektur:*
    - Monolith -> **Modular Monolith** (batas modul in-memory yang ketat tanpa network overhead) -> Microservices via pola *Strangler Fig Pattern*.
  - *Clean & Hexagonal Architecture:*
    - Prinsip Dependency Inversion: Logika bisnis murni (Domain) tidak boleh bergantung pada database atau web framework.
    - Ports & Adapters: Driving adapters (HTTP, CLI) memicu domain use-case; Driven adapters (DB, Message Broker) diimplementasikan di lapisan luar.
  - *Domain-Driven Design (DDD):*
    - Bounded Context, Ubiquitous Language, Aggregates & Value Objects.
    - *Transactional Outbox Pattern:* Menjamin konsistensi transaksi data database dan publikasi event message broker tanpa risiko data hilang.
* **Lab Praktik Nyata:**
  - Menulis use-case pesanan Clean Architecture di mana unit test dapat berjalan 100% menggunakan Mock Repository di memori dalam 2 milidetik.
* **Common Pitfalls & Anti-Patterns:**
  - Terburu-buru memecah aplikasi menjadi microservices sebelum batasan domain bisnis stabil, yang menghasilkan bencana *Distributed Monolith*.
* **Definition of Done (DoD):** Siswa mampu mendesain arsitektur Modular Monolith dengan *package boundary enforcement* dan repository pattern murni.

</details>

<br>

<details open>
<summary><strong>🐧 FASE 10: Linux Kernel Primitives, Kontainerisasi Docker, CI/CD &amp; Git Internals</strong></summary>
<br>

* **Cakupan Topik:** Linux Namespaces &amp; cgroups v2, Docker Multi-Stage Builds, Docker Compose Multi-Container, Zero-Downtime Deployment (Rolling/Blue-Green), Git Internals DAG (Blob, Tree, Commit, Tag), dan Trunk-Based Development.
* **First Principles & Teori (Riset OCI & Git Internals):**
  - *Linux Kernel Primitives:*
    - Namespaces (Membatasi apa yang DILIHAT proses): PID, NET, MNT, IPC, UTS, USER.
    - Control Groups / cgroups (Membatasi apa yang DIGUNAKAN proses): CPU quota, memory limits (mencegah OOM Killer), I/O throttle.
    - Storage Layered: OverlayFS (Upper writable layer + Lower read-only image layers).
  - *Docker Optimization:* Multi-stage builds memisahkan build SDK besar dari runtime minimal (`alpine` / `scratch`), memangkas image dari 1GB menjadi 20MB.
  - *Zero-Downtime Deployment:* Rolling Update vs Blue-Green vs Canary Releases.
  - *Git Internals DAG:*
    - Content-Addressable Storage berbasis SHA-1 / SHA-256.
    - 4 Tipe Objek Git: Blob (content), Tree (directory), Commit (snapshot pointer), Tag.
    - Perintah Plumbing (`hash-object`, `cat-file`, `commit-tree`) vs Porcelain (`git add`, `git commit`).
    - Trunk-Based Development dengan Feature Flags menggantikan alur rumit GitFlow.
* **Lab Praktik Nyata:**
  - Menjalankan multi-service fullstack (Web + API + DB + Redis) via `docker-compose.yml` dengan healthchecks.
  - Membuat commit Git dari nol tanpa perintah `git add` atau `git commit` murni menggunakan perintah plumbing di terminal.
* **Common Pitfalls & Anti-Patterns:**
  - Menjalankan kontainer sebagai user `root` (risiko keamanan fatal breakout ke kernel host).
  - Melakukan `git push --force` yang menghancurkan histori DAG kolaborasi tim.
* **Definition of Done (DoD):** Siswa mampu membuat image kontainer Docker minimal yang aman serta menjelaskan struktur internal direktori `.git/objects`.

</details>

---

## 4. Matriks Ringkasan 10 Fase & Deliverables

<table width="100%">
  <thead>
    <tr style="background:#111C38; color:#F8FAFC;">
      <th width="10%">Fase</th>
      <th width="25%">Nama Macro-Milestone</th>
      <th width="40%">Keluaran Praktik Nyata (Deliverables)</th>
      <th width="15%">Domain</th>
      <th width="10%">Status</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Fase 01</strong></td>
      <td><strong>Platform Foundation &amp; Navigation</strong></td>
      <td>Portal Roadmap <code>index.html</code>, JSON-driven sidebar, fuzzy search, callouts</td>
      <td>Fondasi</td>
      <td><span style="background:#065F46; color:#34D399; padding:2px 8px; border-radius:4px; font-weight:700;">AKTIF</span></td>
    </tr>
    <tr>
      <td><strong>Fase 02</strong></td>
      <td><strong>DB Storage Engine &amp; Indexing</strong></td>
      <td>Inspeksi Slotted Pages 4KB, B+Tree vs LSM, Covering Index optimasi query</td>
      <td>Database</td>
      <td><span style="background:#1E3260; color:#60A5FA; padding:2px 8px; border-radius:4px; font-weight:700;">BERIKUTNYA</span></td>
    </tr>
    <tr>
      <td><strong>Fase 03</strong></td>
      <td><strong>Transaksi &amp; Distributed Concurrency</strong></td>
      <td>Simulasi Flash Sale Checkout, MVCC vs 2PL locking, Saga pattern</td>
      <td>Database</td>
      <td><span style="background:#334155; color:#94A3B8; padding:2px 8px; border-radius:4px; font-weight:700;">TERENCANA</span></td>
    </tr>
    <tr>
      <td><strong>Fase 04</strong></td>
      <td><strong>Browser Pipeline &amp; Performance</strong></td>
      <td>Profiling DevTools, eliminasi Layout Thrashing, animasi 60 FPS GPU composite</td>
      <td>Frontend</td>
      <td><span style="background:#334155; color:#94A3B8; padding:2px 8px; border-radius:4px; font-weight:700;">TERENCANA</span></td>
    </tr>
    <tr>
      <td><strong>Fase 05</strong></td>
      <td><strong>CSS Architecture &amp; Design Tokens</strong></td>
      <td>CSS Grid auto-fit tanpa media query, zero CLS, palet biru modern tokens</td>
      <td>Frontend</td>
      <td><span style="background:#334155; color:#94A3B8; padding:2px 8px; border-radius:4px; font-weight:700;">TERENCANA</span></td>
    </tr>
    <tr>
      <td><strong>Fase 06</strong></td>
      <td><strong>Frontend Frameworks &amp; State</strong></td>
      <td>Mini reactive store via JS Proxy, CSR vs SSR, cache sync TanStack pattern</td>
      <td>Frontend</td>
      <td><span style="background:#334155; color:#94A3B8; padding:2px 8px; border-radius:4px; font-weight:700;">TERENCANA</span></td>
    </tr>
    <tr>
      <td><strong>Fase 07</strong></td>
      <td><strong>Network Protocols &amp; API Architecture</strong></td>
      <td>SSE real-time stream, Protobuf vs JSON benchmark, REST &amp; GraphQL DataLoader</td>
      <td>Backend</td>
      <td><span style="background:#334155; color:#94A3B8; padding:2px 8px; border-radius:4px; font-weight:700;">TERENCANA</span></td>
    </tr>
    <tr>
      <td><strong>Fase 08</strong></td>
      <td><strong>Authentication &amp; OWASP Security</strong></td>
      <td>Auth HTTP-only cookie + Refresh Token Rotation, OAuth PKCE, Row-Level Auth</td>
      <td>Backend</td>
      <td><span style="background:#334155; color:#94A3B8; padding:2px 8px; border-radius:4px; font-weight:700;">TERENCANA</span></td>
    </tr>
    <tr>
      <td><strong>Fase 09</strong></td>
      <td><strong>System Architecture, Clean Arch &amp; DDD</strong></td>
      <td>Modular Monolith e-commerce, Clean Architecture testable use-case, Outbox pattern</td>
      <td>Arsitektur</td>
      <td><span style="background:#334155; color:#94A3B8; padding:2px 8px; border-radius:4px; font-weight:700;">TERENCANA</span></td>
    </tr>
    <tr>
      <td><strong>Fase 10</strong></td>
      <td><strong>Linux, Docker, CI/CD &amp; Git Internals</strong></td>
      <td>Docker multi-stage 25MB, compose multi-service, CI/CD pipeline, Git plumbing</td>
      <td>DevOps &amp; Git</td>
      <td><span style="background:#334155; color:#94A3B8; padding:2px 8px; border-radius:4px; font-weight:700;">TERENCANA</span></td>
    </tr>
  </tbody>
</table>

---

*Dokumen ini merupakan Single Source of Truth kurikulum Fundamental Coding (Velora). Semua implementasi materi harus mengacu pada prinsip pertama rekayasa perangkat lunak dan arsitektur industri nyata.*
