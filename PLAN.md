# MASTER IMPLEMENTATION PLAN: FUNDAMENTAL CODING
> **Platform Edukasi Rekayasa Perangkat Lunak, Full-Stack, Database, Arsitektur & Infrastruktur**
> **Dikembangkan oleh:** Velora | **Disusun oleh:** Mahin Utsman Nawawi, S.H  
> **Repository:** `https://github.com/velora-1d/Data-Analyst.git` (Folder: `Fundamental` / `Test`)

---

## 1. Visi & Filosofi Arsitektur Platform

### A. Visi Platform
**Fundamental Coding** bukan sekadar tutorial sintaks pemula (*hello world*). Platform ini dirancang sebagai **ensiklopedia dan kurikulum interaktif rekayasa perangkat lunak pragmatis**, membedah teknologi dari prinsip pertama (*first principles*) hingga tingkat arsitektur sistem industri nyata:
- **Frontend (FE):** Dari rendering pipeline browser hingga state architecture.
- **Backend (BE):** Dari protokol HTTP/TCP hingga arsitektur API terdistribusi.
- **Database (DB):** Dari query relasional SQL 20 tabel e-commerce hingga struktur storage engine (B-Tree, WAL).
- **Arsitektur Sistem:** Bedah mendalam Monorepo vs Polyrepo, Monolith vs Microservices, DDD, dan Clean Architecture.
- **Jaringan & Server:** Model OSI, TCP/IP, DNS, Subnetting, Nginx reverse proxy, dan keamanan server.
- **DevOps:** Docker internals, container orchestration, CI/CD pipeline.
- **Bahasa Pemrograman:** Analisis komparatif memory management, runtime, dan paradigma (Go, Rust, Python, TypeScript, Java, PHP).
- **Git & Engineering Workflow:** DAG internals, rebase vs merge, trunk-based development.

### B. Keputusan Teknologi: Static HTML + Modern Modular JS vs Next.js
| Kriteria | Static HTML + Modern JS (Pilihan Rekomendasi) | Next.js (App Router) |
| :--- | :--- | :--- |
| **Kecepatan Buka / TTFB** | **0ms (Instan)** tanpa loading tab browser | Membutuhkan hydration JS React (~200ms-1s) |
| **Biaya Hosting** | **100% Gratis Selamanya** (GitHub Pages / CDN) | Membutuhkan server Node.js / Vercel Pro |
| **Overhead & Build Time** | **Nol build step**, file langsung dibuka di browser | Waktu compile `next build` membesar seiring jumlah bab |
| **Penyelarasan Sidebar** | Menggunakan **JSON-Driven Sidebar Component** | File-based routing |
| **Aksesibilitas Belajar** | Siswa bisa inspect element kode asli tanpa terdistraksi framework | Terbungkus abstraksi rumit React Framework |

**Keputusan Arsitektur:**
Kita menggunakan arsitektur **Modular HTML5 + Modern Blue CSS3 + Instant SPA Router + JSON-Driven Multi-Track Navigation**. Seluruh konten materi dapat ditulis dalam format HTML semantik atau dikompilasi dari Markdown, dengan performa instan 0ms tanpa loading tab browser.

---

## 2. Struktur Direktori Baru Platform

```text
Fundamental/
├── assets/
│   ├── script.js             # Instant SPA Router, Prefetcher, & Theme Engine
│   ├── style.css              # Modern Blue Design System, High Contrast Dark/Light
│   └── nav-data.json          # Single Source of Truth untuk Struktur Seluruh Track & Bab
├── index.html                 # Main Learning Portal & Interactive Roadmap Directory
├── PLAN.md                    # Dokumen Master Roadmap 25 Fase
├── README.md                  # Dokumentasi Proyek
├── package.json               # Konfigurasi Proyek
├── database/
│   ├── ecommerce.db           # SQLite DB Utama (20 Tabel, 5.600+ Baris Data)
│   └── schema.sql             # Skema DDL 20 Tabel Relasional
├── sql/                       # Kumpulan Query SQL Latihan per Bab
│   ├── 01_tipe_data.sql
│   ├── 02_query_dasar.sql
│   └── ...
├── tracks/                    # Folder Pembagian Track Pembelajaran
│   ├── 01_database_sql/       # 7 Modul SQL E-Commerce (Yang sudah berjalan!)
│   ├── 02_frontend/           # Track Frontend Engineering
│   ├── 03_backend/            # Track Backend Engineering
│   ├── 04_arsitektur_sistem/  # Track Arsitektur, Monorepo vs Polyrepo
│   ├── 05_jaringan_server/    # Track IP, Subnetting, DNS, Nginx, Linux
│   ├── 06_devops_docker/      # Track Docker, Container, CI/CD
│   ├── 07_bahasa_pemrograman/ # Track Komparasi Bahasa & Memory Management
│   └── 08_git_workflow/       # Track Git Internals & Engineering Workflow
```

---

## 3. Rincian Roadmap 25 Fase Eksekusi

### 🏛️ BAGIAN I: FONDASI PLATFORM & NAVIGASI MULTI-TRACK (Fase 1 - 3)

#### **Fase 1: Redesain Halaman Utama (Beranda Portal Roadmap)**
- **Tujuan:** Mengubah `index.html` dari tampilan daftar modul SQL tunggal menjadi **Dashboard Kurikulum Rekayasa Perangkat Lunak Multi-Track**.
- **Komponen:**
  - Hero Interaktif: *"Fundamental Coding: From Computing First Principles to Production Architecture"*.
  - Track Overview Grid: 8 Track Utama (Frontend, Backend, Database, Arsitektur, Server/IP, Docker/DevOps, Bahasa, Git).
  - Learning Progress Tracker & Filter Tingkat Kesulitan (Dasar, Menengah, Mahir).
  - Pencarian Cepat Materi (*Instant Search Bar* lokal di memori).

#### **Fase 2: Navigasi Sidebar Modular (JSON-Driven Multi-Track Accordion)**
- **Tujuan:** Membuat sidebar yang fleksibel menampung puluhan modul tanpa perlu copy-paste ribuan baris HTML di setiap file.
- **Komponen:**
  - File `assets/nav-data.json` sebagai pusat data silabus semua track.
  - Render menu accordion otomatis: Track aktif terbuka, track lain dapat di-expand/collapse.
  - Indikator bab aktif & status checklist kelulusan materi.

#### **Fase 3: Standarisasi Template Materi & Component Library**
- **Tujuan:** Menyediakan komponen visual seragam untuk pembelajaran teknis mendalam.
- **Komponen:**
  - Box Studi Kasus Industri (*Production Realities*).
  - Box Analisis Trade-off (*Kelebihan vs Kekurangan*).
  - Box Jebakan & Anti-Pattern (*Common Pitfalls*).
  - Diagram Interaktif berbasis SVG murni (koneksi kabel data, topologi jaringan, arsitektur microservices).

---

### 🗄️ BAGIAN II: TRACK DATABASE & SQL INTERNALS (Fase 4 - 6)
*(Pengembangan dari 7 Modul SQL yang sudah aktif)*

#### **Fase 4: Database Storage Engine & Struktur B-Tree (Deep Dive)**
- **Materi:**
  - Bagaimana data disimpan di disk: Halaman (Page 4KB), Header, Row Pointer.
  - Algoritma B-Tree vs B+Tree vs LSM-Tree (Log-Structured Merge Tree pada NoSQL).
  - Write-Ahead Logging (WAL) dan proteksi *Crash Recovery* (ACID durability).

#### **Fase 5: Strategi Indexing & Anatomi Execution Plan**
- **Materi:**
  - Single Column Index vs Composite/Compound Index (Aturan *Leftmost Prefix*).
  - Index Scan vs Table Scan vs Index Only Scan (Covering Index).
  - Cara membaca `EXPLAIN QUERY PLAN` di database relasional untuk mengidentifikasi bottleneck query lambat.

#### **Fase 6: Transaksi, Level Isolasi & Transaksi Terdistribusi**
- **Materi:**
  - Masalah konkurensi: Dirty Read, Non-Repeatable Read, Phantom Read.
  - 4 Level Isolasi ANSI SQL: Read Uncommitted, Read Committed, Repeatable Read, Serializable.
  - Pessimistic Locking (`SELECT ... FOR UPDATE`) vs Optimistic Locking (Version Number).
  - Pengantar Two-Phase Commit (2PC) & Saga Pattern pada sistem terdistribusi.

---

### 🌐 BAGIAN III: TRACK FRONTEND ENGINEERING (Fase 7 - 9)

#### **Fase 7: Fondasi Web, DOM & Browser Rendering Pipeline**
- **Materi:**
  - Siklus Hidup Request: HTML Parsing -> DOM Tree -> CSSOM Tree -> Render Tree -> Layout (Reflow) -> Paint (Repaint) -> Composite.
  - JavaScript Engine & Event Loop: Call Stack, Web APIs, Task Queue (Macrotasks), Microtask Queue (Promises).
  - Optimasi Core Web Vitals (LCP, INP, CLS) dan teknik `requestAnimationFrame` vs Web Workers.

#### **Fase 8: Modern CSS Architecture & Responsive Design Systems**
- **Materi:**
  - Filosofi Layout: Modern Flexbox vs 2D CSS Grid.
  - CSS Custom Properties (Design Tokens, Dark/Light theme switching tanpa flicker).
  - Arsitektur CSS berskala besar: BEM, Utility-First (Tailwind), CSS Modules, CSS-in-JS (Trade-off performa runtime).

#### **Fase 9: Paradigma Frontend Framework & State Management**
- **Materi:**
  - Virtual DOM (React) vs Svelte Compiler (No Virtual DOM) vs Fine-Grained Reactivity (Solid.js / Vue Signals).
  - Model Rendering Modern: Client-Side Rendering (CSR), Server-Side Rendering (SSR), Static Site Generation (SSG), Incremental Static Regeneration (ISR).
  - Arsitektur State: Local State vs Global Store (Redux Toolkit, Zustand, Context API) & Server Cache Sync (TanStack Query / SWR).

---

### ⚙️ BAGIAN IV: TRACK BACKEND ENGINEERING (Fase 10 - 12)

#### **Fase 10: Protokol Komunikasi & Anatomi HTTP/TCP**
- **Materi:**
  - Anatomi Paket HTTP: Headers, Methods (Idempotent vs Non-Idempotent), Status Codes, Body Payloads.
  - Evolusi Protokol: HTTP/1.1 (Pipelining & Head-of-Line Blocking) -> HTTP/2 (Multiplexing & Binary Framing) -> HTTP/3 (QUIC / UDP).
  - Real-time Web: Polling vs Long Polling vs Server-Sent Events (SSE) vs WebSocket.

#### **Fase 11: Arsitektur API: REST vs GraphQL vs gRPC**
- **Materi:**
  - Desain RESTful API standar industri (Resource-oriented, HATEOAS, Versioning, Pagination Cursor vs Offset).
  - GraphQL: Solusi *Over-fetching* & *Under-fetching*, N+1 Problem & DataLoader pattern.
  - gRPC & Protocol Buffers: Komunikasi antar-layanan microservices berkecepatan tinggi via binary serialization.

#### **Fase 12: Autentikasi, Otorisasi & Keamanan API**
- **Materi:**
  - Statefull Session (Cookie-based, Session Store Redis) vs Stateless Token (JWT: Header, Payload, Signature).
  - Alur Protokol OAuth 2.0 & OpenID Connect (Authorization Code Grant with PKCE untuk SPA/Mobile).
  - Pertahanan Keamanan OWASP Top 10 API: SQL Injection, XSS, CSRF (SameSite Cookies), Rate Limiting, CORS Policy.

---

### 🏗️ BAGIAN V: TRACK ARSITEKTUR SISTEM & REPOSITORY (Fase 13 - 16)

#### **Fase 13: Diskusi Mendalam: Monorepo vs Polyrepo (Multi-Repo)**
- **Materi:**
  - **Definisi:** Mengelola semua modul dalam 1 repositori raksasa (Monorepo) vs memecah per layanan dalam repositori terpisah (Polyrepo).
  - **Tabel Analisis Trade-off Menyeluruh:**
    - Kecepatan refactoring atomik multi-package.
    - Manajemen dependensi bersama (*shared libraries* & DTO contracts).
    - Kompleksitas CI/CD & tooling (Turborepo, Nx, Bazel).
    - Hak akses granular per tim vs visibilitas kode universal.
  - Studi Kasus Nyata: Mengapa Google/Meta memilih Monorepo, dan kapan startup sebaiknya mulai dengan Monorepo vs Polyrepo.

#### **Fase 14: Monolith vs Modular Monolith vs Microservices**
- **Materi:**
  - Ilusi Microservices: Kompleksitas jaringan, distributed tracing, latensi IPC, dan kegagalan parsial (*partial failure*).
  - Paradigma **Modular Monolith**: Membangun batasan modul yang ketat (*clean boundaries*) dalam satu deployable artifact sebelum terburu-buru memecah service.
  - Kapan dan bagaimana memecah service: Menggunakan *Strangler Fig Pattern*.

#### **Fase 15: Clean Architecture, Hexagonal & Onion Architecture**
- **Materi:**
  - Dependency Inversion Principle: Lapisan bisnis (Domain) tidak boleh bergantung pada framework atau database.
  - Struktur Lapisan: Domain Entities -> Use Cases (Application) -> Interface Adapters (Controllers, Presenters) -> Frameworks & Drivers (DB, HTTP Server).
  - Implementasi nyata kode Clean Architecture: Repository Pattern, Dependency Injection.

#### **Fase 16: Domain-Driven Design (DDD) & Event-Driven Architecture**
- **Materi:**
  - Strategic Design: Bounded Context, Ubiquitous Language, Context Mapping.
  - Tactical Design: Value Objects, Entities, Aggregates, Domain Events.
  - Event-Driven Architecture: Event Sourcing vs CQRS (Command Query Responsibility Segregation).

---

### 🐧 BAGIAN VI: TRACK LINUX, SERVER & JARINGAN (Fase 17 - 19)

#### **Fase 17: Dasar Jaringan Komputer, Model OSI & TCP/IP**
- **Materi:**
  - Perjalanan sebuah paket data dari browser hingga server (7 Lapisan OSI vs 4 Lapisan TCP/IP).
  - TCP 3-Way Handshake (SYN, SYN-ACK, ACK) dan TCP Teardown.
  - TCP (Reliable, Connection-oriented) vs UDP (Fast, Connectionless).

#### **Fase 18: IP Addressing, CIDR, Subnetting & Routing**
- **Materi:**
  - Struktur IPv4 (32-bit) vs IPv6 (128-bit).
  - Notasi CIDR (misal: `/24`, `/16`, `/32`) dan cara menghitung rentang IP serta netmask.
  - Perbedaan IP Publik vs IP Privat (RFC 1918: `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) dan peran NAT (*Network Address Translation*).

#### **Fase 19: DNS, Web Server Nginx & Reverse Proxy**
- **Materi:**
  - Anatomi Resolusi DNS: Root Server -> TLD Server -> Authoritative Nameserver -> Record A, CNAME, AAAA, MX.
  - Konfigurasi Nginx Reverse Proxy, Load Balancer (Round Robin, Least Connections, IP Hash).
  - Terminasi SSL/TLS, sertifikat Let's Encrypt, dan HTTP strict transport security (HSTS).

---

### 🐳 BAGIAN VII: TRACK DEVOPS, DOCKER & CI/CD (Fase 20 - 22)

#### **Fase 20: Kontainerisasi Dasar & Arsitektur Docker**
- **Materi:**
  - Perbedaan Mendasar Container vs Virtual Machine (Shared OS Kernel via cgroups & namespaces vs Hypervisor).
  - Arsitektur Docker: Client, Daemon, Registries, Images, Containers.
  - Best Practice Menulis `Dockerfile`: Multi-stage builds untuk memperkecil ukuran image dari 1GB menjadi 20MB.

#### **Fase 21: Jaringan, Volume & Multi-Container dengan Docker Compose**
- **Materi:**
  - Docker Storage: Bind Mounts vs Named Volumes (Preservasi data database).
  - Docker Networking: Bridge, Host, Overlay, None (Komunikasi internal antar-service via service name DNS).
  - Menjalankan Fullstack App (Frontend + Backend API + Database + Redis) dalam satu file `docker-compose.yml`.

#### **Fase 22: Otomasi CI/CD & Deployment Pipeline**
- **Materi:**
  - Anatomi Continuous Integration (CI): Linting, Typecheck, Automated Unit & Integration Testing.
  - Anatomi Continuous Deployment (CD): Automated Build Image, Zero-Downtime Deployment (Blue-Green vs Rolling Update).
  - Scripting GitHub Actions workflow production-ready.

---

### 🔤 BAGIAN VIII: TRACK BAHASA PEMROGRAMAN & GIT ADVANCED (Fase 23 - 25)

#### **Fase 23: Paradigma Bahasa & Komparasi Ekosistem**
- **Materi:**
  - Dynamic vs Static Typing, Weak vs Strong Typing.
  - Kompilasi Native (C/Go/Rust) vs Bytecode VM (Java/JVM, C#/.NET) vs JIT Interpreted (JavaScript/V8, Python).
  - Kapan memilih: Go (Concurrency & Backend Network), Python (Data & AI), Rust (Systems & Zero-Cost Abstractions), TypeScript (Universal Full-Stack).

#### **Fase 24: Manajemen Memori & Garbage Collection Internals**
- **Materi:**
  - Alokasi Memori: Stack (Cepat, Otomatis) vs Heap (Dinamis, Fleksibel).
  - Tiga Pendekatan Pengelolaan Memori di Industri:
    1. Manual Management (`malloc` / `free` di C/C++).
    2. Tracing Garbage Collector (Mark-and-Sweep, Generational GC di Java/Go/V8).
    3. Ownership & Borrow Checker (Tanpa GC & Tanpa Bocor Memori di Rust).

#### **Fase 25: Git Internals & Engineering Collaboration Workflow**
- **Materi:**
  - Struktur Data Git: Directed Acyclic Graph (DAG), Objek Commit, Tree, Blob, dan Tag.
  - Rebase vs Merge: Memilih antara linear commit history bersih vs preserving history cabang paralel.
  - Branching Strategy: Mengapa industri beralih dari GitFlow rumit ke **Trunk-Based Development** dengan Feature Flags.
  - Teknik darurat: `git reflog`, `git cherry-pick`, dan `git bisect` untuk mencari baris bug otomatis.

---

## 4. Rencana Jadwal Eksekusi Segera

1. **Langkah 1 (Saat Ini):**
   - Buat file `PLAN.md` di root proyek.
   - Buat akses direktori `C:\Pak-Hakim\Project\Fundamental` (selesai melalui NTFS junction tanpa merusak workspace aktif).
2. **Langkah 2 (Fase 1 Mulai Dikerjakan):**
   - Perbarui tampilan beranda `index.html` menjadi Roadmap Dashboard modern yang menampilkan seluruh 8 Track di atas secara interaktif.
   - Siapkan data silabus di `assets/nav-data.json`.
3. **Langkah 3 (Eksekusi Bertahap per Fase):**
   - Menulis materi dan interaktivitas tiap fase secara terukur dengan TDD, empirical verification, dan checkpoint git commit lokal.
