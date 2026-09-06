const { DatabaseSync } = require('node:sqlite');
const fs = require('node:fs');
const path = require('node:path');

const dbPath = path.resolve(__dirname, 'ecommerce.db');
const schemaPath = path.resolve(__dirname, 'schema.sql');

console.log('--- RESET & SEED ECOMMERCE.DB ---');

// 1. Re-create clean database from schema.sql
if (fs.existsSync(dbPath)) {
  fs.unlinkSync(dbPath);
}

const db = new DatabaseSync(dbPath);
const schemaSql = fs.readFileSync(schemaPath, 'utf8');
db.exec(schemaSql);
console.log('Schema DDL executed successfully. 20 tables created.');

// Turn on foreign keys
db.exec('PRAGMA foreign_keys = ON;');

// Helper for random integers
function randInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function randChoice(arr) {
  return arr[Math.floor(Math.random() * arr.length)];
}

// -------------------------------------------------------------
// 1. KATEGORI & 2. SUBKATEGORI
// -------------------------------------------------------------
const categories = [
  {
    nama: 'Elektronik & Gadget',
    slug: 'elektronik-gadget',
    subs: ['Smartphone & Aksesoris', 'Laptop & PC', 'Audio & Headphone', 'Kamera & Optik', 'Perangkat Pintar (Smart Home)']
  },
  {
    nama: 'Fashion Pria',
    slug: 'fashion-pria',
    subs: ['Kaos & Poloshirt', 'Kemeja Formal & Casual', 'Celana Jeans & Chino', 'Jaket & Hoodie', 'Sepatu & Sandal Pria']
  },
  {
    nama: 'Fashion Wanita',
    slug: 'fashion-wanita',
    subs: ['Blouse & Tunik', 'Gaun & Dress', 'Hijab & Busana Muslim', 'Tas Wanita', 'Sepatu & Heels']
  },
  {
    nama: 'Kesehatan & Kecantikan',
    slug: 'kesehatan-kecantikan',
    subs: ['Perawatan Wajah (Skincare)', 'Makeup & Kosmetik', 'Perawatan Tubuh & Rambut', 'Suplemen & Vitamin']
  },
  {
    nama: 'Peralatan Rumah Tangga',
    slug: 'peralatan-rumah-tangga',
    subs: ['Peralatan Dapur & Masak', 'Dekorasi & Furniture', 'Penyimpanan & Organizer', 'Alat Kebersihan']
  },
  {
    nama: 'Makanan & Minuman',
    slug: 'makanan-minuman',
    subs: ['Kopi & Teh Nusantara', 'Camilan & Makanan Ringan', 'Bumbu Dapur & Bahan Pokok', 'Minuman Sehat']
  },
  {
    nama: 'Olahraga & Outdoor',
    slug: 'olahraga-outdoor',
    subs: ['Pakaian Olahraga', 'Sepatu Lari & Gym', 'Peralatan Camping & Gunung', 'Aksesoris Fitness']
  },
  {
    nama: 'Otomotif & Aksesoris',
    slug: 'otomotif-aksesoris',
    subs: ['Helm & Apparel Motor', 'Oli & Cairan Perawatan', 'Aksesoris Interior Mobil', 'Sparepart Motor & Mobil']
  }
];

const insertKategori = db.prepare('INSERT INTO kategori (nama_kategori, slug) VALUES (?, ?)');
const insertSubkategori = db.prepare('INSERT INTO subkategori (kategori_id, nama_subkategori) VALUES (?, ?)');

const subkategoriMap = []; // { id, kategoriId, name }

db.exec('BEGIN TRANSACTION;');
for (const cat of categories) {
  insertKategori.run(cat.nama, cat.slug);
  const catId = db.prepare('SELECT last_insert_rowid() as id').get().id;
  for (const sub of cat.subs) {
    insertSubkategori.run(catId, sub);
    const subId = db.prepare('SELECT last_insert_rowid() as id').get().id;
    subkategoriMap.push({ id: subId, kategoriId: catId, name: sub, catName: cat.nama });
  }
}
db.exec('COMMIT;');
console.log(`Kategori & Subkategori seeded: ${categories.length} kategori, ${subkategoriMap.length} subkategori.`);

// -------------------------------------------------------------
// 3. MEREK
// -------------------------------------------------------------
const brandsData = [
  ['Samsung', 'Korea Selatan'],
  ['Apple', 'Amerika Serikat'],
  ['Xiaomi', 'Tiongkok'],
  ['ASUS', 'Taiwan'],
  ['Logitech', 'Swiss'],
  ['Sony', 'Jepang'],
  ['Erigo', 'Indonesia'],
  ['Eiger Adventure', 'Indonesia'],
  ['Brodo', 'Indonesia'],
  ['Cottonink', 'Indonesia'],
  ['Wardah', 'Indonesia'],
  ['Somethinc', 'Indonesia'],
  ['Philips', 'Belanda'],
  ['Miyako', 'Indonesia'],
  ['Oxone', 'Indonesia'],
  ['Kapal Api', 'Indonesia'],
  ['Indomie', 'Indonesia'],
  ['Kopi Kenangan', 'Indonesia'],
  ['Specs', 'Indonesia'],
  ['KYT', 'Indonesia'],
  ['Arai', 'Jepang'],
  ['Pertamina Lubricants', 'Indonesia']
];

const insertMerek = db.prepare('INSERT INTO merek (nama_merek, negara_asal) VALUES (?, ?)');
db.exec('BEGIN TRANSACTION;');
for (const b of brandsData) {
  insertMerek.run(b[0], b[1]);
}
db.exec('COMMIT;');
console.log(`Merek seeded: ${brandsData.length} merek.`);

// -------------------------------------------------------------
// 4. SUPPLIER
// -------------------------------------------------------------
const suppliersData = [
  ['PT Nusantara Mega Distribusi', 'Budi Hartono', '08119876543', 'Jakarta Pusat'],
  ['CV Mitra Mandiri Pratama', 'Hendra Kusuma', '08123456789', 'Surabaya'],
  ['PT Sinergi Abadi Sentosa', 'Dewi Sartika', '08134567890', 'Bandung'],
  ['PT Surya Graha Perkasa', 'Ahmad Rizal', '08145678901', 'Semarang'],
  ['CV Sukses Logistik Niaga', 'Wayan Sudarta', '08156789012', 'Denpasar'],
  ['PT Tri Tunggal Sejahtera', 'Faisal Lubis', '08167890123', 'Medan'],
  ['CV Borneo Sumber Rezeki', 'Agus Salim', '08178901234', 'Balikpapan'],
  ['PT Celebes Global Logistik', 'Irfan Syamsuddin', '08189012345', 'Makassar'],
  ['PT Banten Niaga Cipta', 'Siti Maryam', '08190123456', 'Tangerang'],
  ['CV Jogja Kreatif Logistik', 'Sri Rahayu', '08211234567', 'Yogyakarta']
];

const insertSupplier = db.prepare('INSERT INTO supplier (nama_supplier, kontak_person, no_telepon, kota) VALUES (?, ?, ?, ?)');
db.exec('BEGIN TRANSACTION;');
for (const s of suppliersData) {
  insertSupplier.run(s[0], s[1], s[2], s[3]);
}
db.exec('COMMIT;');
console.log(`Supplier seeded: ${suppliersData.length} supplier.`);

// -------------------------------------------------------------
// 5. GUDANG
// -------------------------------------------------------------
const warehousesData = [
  ['Gudang Utama Cakung Hub', 'Jakarta Timur', 150000],
  ['Gudang Regional Rungkut', 'Surabaya', 90000],
  ['Gudang Cimahi Distribution Center', 'Bandung', 65000],
  ['Gudang Hub Tanjung Morawa', 'Medan', 50000],
  ['Gudang Gateway Daya', 'Makassar', 40000]
];

const insertGudang = db.prepare('INSERT INTO gudang (nama_gudang, kota, kapasitas_unit) VALUES (?, ?, ?)');
db.exec('BEGIN TRANSACTION;');
for (const g of warehousesData) {
  insertGudang.run(g[0], g[1], g[2]);
}
db.exec('COMMIT;');
console.log(`Gudang seeded: ${warehousesData.length} gudang.`);

// -------------------------------------------------------------
// 6. KURIR EKSPEDISI
// -------------------------------------------------------------
const couriersData = [
  ['JNE Express', 'Reguler (2-3 Hari)', 10000],
  ['JNE Express', 'YES - Yakin Esok Sampai', 20000],
  ['SiCepat Express', 'SiUntung Reguler', 9500],
  ['SiCepat Express', 'BEST - Besok Sampai Tujuan', 18500],
  ['J&T Express', 'EZ Standard Service', 11000],
  ['Anteraja', 'Reguler Next-Day', 10500],
  ['GoSend', 'Instant Courier (Max 3 Jam)', 30000],
  ['GrabExpress', 'Sameday Delivery (Max 6 Jam)', 22000]
];

const insertKurir = db.prepare('INSERT INTO kurir_ekspedisi (nama_kurir, layanan, tarif_per_kg) VALUES (?, ?, ?)');
db.exec('BEGIN TRANSACTION;');
for (const c of couriersData) {
  insertKurir.run(c[0], c[1], c[2]);
}
db.exec('COMMIT;');
console.log(`Kurir seeded: ${couriersData.length} layanan kurir.`);

// -------------------------------------------------------------
// 7. METODE PEMBAYARAN
// -------------------------------------------------------------
const paymentMethodsData = [
  ['BCA Virtual Account', 'Virtual Account', 2000],
  ['Mandiri Virtual Account', 'Virtual Account', 2000],
  ['BRI Virtual Account (BRIVA)', 'Virtual Account', 1500],
  ['BNI Virtual Account', 'Virtual Account', 1500],
  ['QRIS Nasional (Semua Bank / e-Wallet)', 'E-Wallet / QRIS', 1000],
  ['GoPay Indonesia', 'E-Wallet', 1000],
  ['OVO Cash', 'E-Wallet', 1000],
  ['ShopeePay Digital', 'E-Wallet', 1000],
  ['Kartu Kredit / Debit Online Visa/Mastercard', 'Credit Card', 5000],
  ['COD (Bayar Tunai di Tempat)', 'Cash On Delivery', 2500]
];

const insertMetode = db.prepare('INSERT INTO metode_pembayaran (nama_metode, tipe, biaya_admin) VALUES (?, ?, ?)');
db.exec('BEGIN TRANSACTION;');
for (const m of paymentMethodsData) {
  insertMetode.run(m[0], m[1], m[2]);
}
db.exec('COMMIT;');
console.log(`Metode Pembayaran seeded: ${paymentMethodsData.length} metode.`);

// -------------------------------------------------------------
// 8. VOUCHER PROMO
// -------------------------------------------------------------
const vouchersData = [
  ['GAJIANHEMAT50', 'Nominal', 50000, 300000, 1000],
  ['DISKONMEMBER25', 'Nominal', 25000, 150000, 2500],
  ['ONGKIRGRATIS15', 'Nominal', 15000, 100000, 5000],
  ['ELEKTRONIK100K', 'Nominal', 100000, 1000000, 800],
  ['FASHIONFEST20', 'Persen', 20, 200000, 1500],
  ['BEAUTYGLOW15', 'Persen', 15, 120000, 2000],
  ['KEMERDEKAAN79', 'Nominal', 79000, 500000, 790],
  ['SUPERDEAL35K', 'Nominal', 35000, 250000, 1200]
];

const insertVoucher = db.prepare('INSERT INTO voucher_promo (kode_voucher, tipe_diskon, nilai_diskon, minimal_belanja, kuota_pemakaian) VALUES (?, ?, ?, ?, ?)');
db.exec('BEGIN TRANSACTION;');
for (const v of vouchersData) {
  insertVoucher.run(v[0], v[1], v[2], v[3], v[4]);
}
db.exec('COMMIT;');
console.log(`Voucher seeded: ${vouchersData.length} voucher.`);

// -------------------------------------------------------------
// 9. PELANGGAN & 10. ALAMAT PELANGGAN
// -------------------------------------------------------------
const firstNamesM = ['Ahmad', 'Budi', 'Dedi', 'Eko', 'Fajar', 'Gunawan', 'Hendra', 'Irfan', 'Joko', 'Kurniawan', 'Lukman', 'Mahin', 'Naufal', 'Oki', 'Prasetyo', 'Rizky', 'Surya', 'Taufik', 'Umar', 'Wahyu', 'Yoga', 'Zainal'];
const firstNamesF = ['Annisa', 'Bella', 'Citra', 'Dewi', 'Endang', 'Fitri', 'Gita', 'Hani', 'Indah', 'Jelita', 'Kartika', 'Lestari', 'Maya', 'Nurul', 'Putri', 'Rani', 'Siti', 'Tri', 'Utami', 'Vina', 'Wulandari', 'Yuni'];
const lastNames = ['Pratama', 'Santoso', 'Wijaya', 'Saputra', 'Kusuma', 'Hidayat', 'Nugroho', 'Wibowo', 'Siregar', 'Lubis', 'Nasution', 'Pasaribu', 'Simanjuntak', 'Setiawan', 'Kurniawan', 'Ramadhan', 'Utomo', 'Subagyo', 'Nawawi', 'Wardhana', 'Syahputra', 'Mahendra'];

const citiesData = [
  { kota: 'Jakarta Selatan', prov: 'DKI Jakarta', pos: '12190' },
  { kota: 'Jakarta Pusat', prov: 'DKI Jakarta', pos: '10110' },
  { kota: 'Jakarta Barat', prov: 'DKI Jakarta', pos: '11460' },
  { kota: 'Jakarta Timur', prov: 'DKI Jakarta', pos: '13330' },
  { kota: 'Jakarta Utara', prov: 'DKI Jakarta', pos: '14240' },
  { kota: 'Surabaya', prov: 'Jawa Timur', pos: '60271' },
  { kota: 'Malang', prov: 'Jawa Timur', pos: '65111' },
  { kota: 'Sidoarjo', prov: 'Jawa Timur', pos: '61219' },
  { kota: 'Bandung', prov: 'Jawa Barat', pos: '40115' },
  { kota: 'Bekasi', prov: 'Jawa Barat', pos: '17148' },
  { kota: 'Depok', prov: 'Jawa Barat', pos: '16424' },
  { kota: 'Bogor', prov: 'Jawa Barat', pos: '16122' },
  { kota: 'Tangerang', prov: 'Banten', pos: '15111' },
  { kota: 'Tangerang Selatan', prov: 'Banten', pos: '15411' },
  { kota: 'Semarang', prov: 'Jawa Tengah', pos: '50134' },
  { kota: 'Surakarta (Solo)', prov: 'Jawa Tengah', pos: '57126' },
  { kota: 'Yogyakarta', prov: 'DI Yogyakarta', pos: '55224' },
  { kota: 'Sleman', prov: 'DI Yogyakarta', pos: '55281' },
  { kota: 'Medan', prov: 'Sumatera Utara', pos: '20112' },
  { kota: 'Palembang', prov: 'Sumatera Selatan', pos: '30129' },
  { kota: 'Pekanbaru', prov: 'Riau', pos: '28111' },
  { kota: 'Bandar Lampung', prov: 'Lampung', pos: '35111' },
  { kota: 'Denpasar', prov: 'Bali', pos: '80232' },
  { kota: 'Badung', prov: 'Bali', pos: '80361' },
  { kota: 'Makassar', prov: 'Sulawesi Selatan', pos: '90111' },
  { kota: 'Balikpapan', prov: 'Kalimantan Timur', pos: '76111' },
  { kota: 'Samarinda', prov: 'Kalimantan Timur', pos: '75111' },
  { kota: 'Banjarmasin', prov: 'Kalimantan Selatan', pos: '70111' }
];

const streetNames = [
  'Jl. Sudirman No. ',
  'Jl. M.H. Thamrin Kav. ',
  'Jl. Gatot Subroto No. ',
  'Jl. Rasuna Said Blok ',
  'Jl. Asia Afrika No. ',
  'Jl. Diponegoro No. ',
  'Jl. Malioboro No. ',
  'Jl. Basuki Rahmat No. ',
  'Jl. Ahmad Yani No. ',
  'Jl. Pemuda No. ',
  'Jl. Gajah Mada No. ',
  'Jl. Hayam Wuruk No. ',
  'Jl. Raya Darmo No. ',
  'Jl. R.E. Martadinata No. ',
  'Jl. Dago Asri No. '
];

const TOTAL_CUSTOMERS = 1200;
const customers = [];
const customerAddresses = []; // { id, custId, kota, prov }

const insertPelanggan = db.prepare(`
  INSERT INTO pelanggan (nama_lengkap, email, no_hp, gender, tanggal_lahir, tanggal_daftar)
  VALUES (?, ?, ?, ?, ?, ?)
`);

const insertAlamat = db.prepare(`
  INSERT INTO alamat_pelanggan (pelanggan_id, label_alamat, alamat_jalan, kota, provinsi, kode_pos, is_utama)
  VALUES (?, ?, ?, ?, ?, ?, ?)
`);

db.exec('BEGIN TRANSACTION;');

for (let i = 1; i <= TOTAL_CUSTOMERS; i++) {
  const isMale = Math.random() > 0.48;
  const gender = isMale ? 'Pria' : 'Wanita';
  const first = isMale ? randChoice(firstNamesM) : randChoice(firstNamesF);
  const last = randChoice(lastNames);
  const fullName = `${first} ${last}`;
  
  const emailNum = i > 400 ? `${i}` : `${randInt(10, 999)}`;
  const emailDomain = randChoice(['gmail.com', 'yahoo.com', 'hotmail.com', 'icloud.com', 'outlook.com']);
  const email = `${first.toLowerCase()}.${last.toLowerCase()}${emailNum}@${emailDomain}`;
  
  const prefixes = ['0812', '0813', '0821', '0852', '0877', '0878', '0896', '0857', '0818'];
  const phone = `${randChoice(prefixes)}${randInt(1000000, 9999999)}`;
  
  const birthYear = randInt(1980, 2005);
  const birthMonth = String(randInt(1, 12)).padStart(2, '0');
  const birthDay = String(randInt(1, 28)).padStart(2, '0');
  const birthDate = `${birthYear}-${birthMonth}-${birthDay}`;
  
  const regYear = randChoice([2023, 2024]);
  const regMonth = String(randInt(1, 12)).padStart(2, '0');
  const regDay = String(randInt(1, 28)).padStart(2, '0');
  const regDate = `${regYear}-${regMonth}-${regDay}`;

  insertPelanggan.run(fullName, email, phone, gender, birthDate, regDate);
  customers.push({ id: i, name: fullName, email, regDate });

  // Primary address
  const addrCity = randChoice(citiesData);
  const street = `${randChoice(streetNames)}${randInt(1, 199)}`;
  insertAlamat.run(i, 'Rumah', street, addrCity.kota, addrCity.prov, addrCity.pos, 1);
  const addrId = db.prepare('SELECT last_insert_rowid() as id').get().id;
  customerAddresses.push({ id: addrId, custId: i, kota: addrCity.kota, prov: addrCity.prov });

  if (Math.random() < 0.3) {
    const kantorCity = Math.random() < 0.7 ? addrCity : randChoice(citiesData);
    const officeStreet = `Gedung Perkantoran Menara ${randChoice(['Graha', 'Mandiri', 'Sentra', 'Plaza', 'Wisma'])}, ${randChoice(streetNames)}${randInt(1, 99)}`;
    insertAlamat.run(i, 'Kantor', officeStreet, kantorCity.kota, kantorCity.prov, kantorCity.pos, 0);
    const kantorAddrId = db.prepare('SELECT last_insert_rowid() as id').get().id;
    customerAddresses.push({ id: kantorAddrId, custId: i, kota: kantorCity.kota, prov: kantorCity.prov });
  }
}

db.exec('COMMIT;');
console.log(`Pelanggan seeded: ${customers.length} orang, Alamat seeded: ${customerAddresses.length} alamat.`);

// -------------------------------------------------------------
// 11. PRODUK & 12. VARIASI PRODUK (SKU) & 13. STOK GUDANG
// -------------------------------------------------------------
const rawProducts = [
  // Gadget / Elektronik (includes Samsung, Wireless, etc.)
  { name: 'Samsung Galaxy S24 Ultra 5G Smartphone', sub: 'Smartphone & Aksesoris', brand: 'Samsung', supp: 1, weight: 450, desc: 'Flagship smartphone Snapdragon 8 Gen 3 dengan kamera 200MP dan S-Pen bawaan.', skus: [
    { sku: 'SAM-S24U-BLK-256', warna: 'Titanium Black', ukuran: '256GB', modal: 16500000, jual: 19999000 },
    { sku: 'SAM-S24U-GRY-512', warna: 'Titanium Gray', ukuran: '512GB', modal: 18500000, jual: 21999000 }
  ]},
  { name: 'Samsung Galaxy Z Flip5 Smartphone Foldable', sub: 'Smartphone & Aksesoris', brand: 'Samsung', supp: 1, weight: 380, desc: 'Ponsel lipat compact modern dengan Flex Window 3.4 inci.', skus: [
    { sku: 'SAM-ZFL5-MNT-256', warna: 'Mint Green', ukuran: '256GB', modal: 11500000, jual: 14499000 },
    { sku: 'SAM-ZFL5-GRA-512', warna: 'Graphite', ukuran: '512GB', modal: 13000000, jual: 16499000 }
  ]},
  { name: 'Apple iPhone 15 Pro Max Garansi Resmi', sub: 'Smartphone & Aksesoris', brand: 'Apple', supp: 1, weight: 420, desc: 'Titanium aerospace-grade dengan Chip A17 Pro dan Action button.', skus: [
    { sku: 'APL-IP15PM-NT-256', warna: 'Natural Titanium', ukuran: '256GB', modal: 20000000, jual: 23999000 },
    { sku: 'APL-IP15PM-BL-512', warna: 'Blue Titanium', ukuran: '512GB', modal: 23000000, jual: 27499000 }
  ]},
  { name: 'Xiaomi Redmi Note 13 Pro 4G NFC', sub: 'Smartphone & Aksesoris', brand: 'Xiaomi', supp: 2, weight: 400, desc: 'Mid-range champion 200MP OIS kamera dan 67W Turbo Charge.', skus: [
    { sku: 'XIA-RN13P-BLK-128', warna: 'Midnight Black', ukuran: '8GB/128GB', modal: 3100000, jual: 3799000 },
    { sku: 'XIA-RN13P-BLU-256', warna: 'Ocean Blue', ukuran: '12GB/256GB', modal: 3600000, jual: 4399000 }
  ]},
  { name: 'ASUS ROG Zephyrus G14 Gaming Laptop', sub: 'Laptop & PC', brand: 'ASUS', supp: 3, weight: 2800, desc: 'Laptop gaming ultra-ringkas AMD Ryzen 9 dan NVIDIA RTX 4070.', skus: [
    { sku: 'ASU-ROG-G14-WHT', warna: 'Moonlight White', ukuran: '14 Inch 16GB/1TB', modal: 25000000, jual: 29999000 },
    { sku: 'ASU-ROG-G14-GRY', warna: 'Eclipse Gray', ukuran: '14 Inch 32GB/1TB', modal: 28500000, jual: 33999000 }
  ]},
  { name: 'Logitech MX Master 3S Wireless Performance Mouse', sub: 'Smartphone & Aksesoris', brand: 'Logitech', supp: 4, weight: 320, desc: 'Wireless mouse ergonomis dengan Quiet Clicks dan sensor 8000 DPI MagSpeed.', skus: [
    { sku: 'LOG-MXM3S-GRA', warna: 'Graphite', ukuran: 'Standard', modal: 1250000, jual: 1689000 },
    { sku: 'LOG-MXM3S-PGR', warna: 'Pale Gray', ukuran: 'Standard', modal: 1250000, jual: 1689000 }
  ]},
  { name: 'Logitech G PRO X Wireless Mechanical Gaming Keyboard', sub: 'Smartphone & Aksesoris', brand: 'Logitech', supp: 4, weight: 1100, desc: 'Wireless mechanical gaming keyboard Lightspeed pro-grade.', skus: [
    { sku: 'LOG-GPRO-KB-BLK', warna: 'Hitam', ukuran: 'TKL (Tenkeyless)', modal: 1900000, jual: 2499000 }
  ]},
  { name: 'Sony WH-1000XM5 Wireless Noise Cancelling Headphone', sub: 'Audio & Headphone', brand: 'Sony', supp: 4, weight: 750, desc: 'Industri-leading noise canceling headphone dengan 8 mikrofon dan prosesor V1.', skus: [
    { sku: 'SNY-WH5-BLK', warna: 'Black Matte', ukuran: 'Over-Ear', modal: 4400000, jual: 5499000 },
    { sku: 'SNY-WH5-SLV', warna: 'Silver Platinum', ukuran: 'Over-Ear', modal: 4400000, jual: 5499000 }
  ]},
  { name: 'Xiaomi Wireless Earbuds Redmi Buds 5 Pro', sub: 'Audio & Headphone', brand: 'Xiaomi', supp: 2, weight: 150, desc: 'True Wireless Stereo dengan 52dB Active Noise Cancellation.', skus: [
    { sku: 'XIA-BUDS5P-WHT', warna: 'Putih Glossy', ukuran: 'Standard', modal: 580000, jual: 799000 }
  ]},

  // Fashion Pria (includes Kaos, Kemeja)
  { name: 'Erigo T-Shirt Basic Kaos Polos Katun Combed 30s', sub: 'Kaos & Poloshirt', brand: 'Erigo', supp: 3, weight: 220, desc: 'Kaos harian berbahan katun combed 30s sejuk dan menyerap keringat.', skus: [
    { sku: 'ERG-TS-BLK-M', warna: 'Hitam', ukuran: 'M', modal: 45000, jual: 95000 },
    { sku: 'ERG-TS-BLK-L', warna: 'Hitam', ukuran: 'L', modal: 45000, jual: 95000 },
    { sku: 'ERG-TS-NVY-M', warna: 'Navy Blue', ukuran: 'M', modal: 45000, jual: 95000 },
    { sku: 'ERG-TS-WHT-L', warna: 'Putih', ukuran: 'L', modal: 45000, jual: 95000 }
  ]},
  { name: 'Erigo Kemeja Flanel Casual Pria Long Sleeve', sub: 'Kemeja Formal & Casual', brand: 'Erigo', supp: 3, weight: 350, desc: 'Kemeja flanel motif kotak-kotak premium untuk hangout dan kerja santai.', skus: [
    { sku: 'ERG-KFL-RED-M', warna: 'Merah Kotak', ukuran: 'M', modal: 95000, jual: 175000 },
    { sku: 'ERG-KFL-RED-L', warna: 'Merah Kotak', ukuran: 'L', modal: 95000, jual: 175000 },
    { sku: 'ERG-KFL-GRN-XL', warna: 'Hijau Army', ukuran: 'XL', modal: 95000, jual: 175000 }
  ]},
  { name: 'Brodo Sepatu Sneaker Pria Signore Leather', sub: 'Sepatu & Sandal Pria', brand: 'Brodo', supp: 3, weight: 1200, desc: 'Sepatu kulit pria bergaya vintage dengan konstruksi Blake Stitch kokoh.', skus: [
    { sku: 'BRD-SGN-BRN-41', warna: 'Vintage Brown', ukuran: '41', modal: 380000, jual: 649000 },
    { sku: 'BRD-SGN-BRN-42', warna: 'Vintage Brown', ukuran: '42', modal: 380000, jual: 649000 },
    { sku: 'BRD-SGN-BLK-42', warna: 'Classic Black', ukuran: '42', modal: 380000, jual: 649000 }
  ]},
  { name: 'Eiger Jaket Windproof Hiking Tracker', sub: 'Jaket & Hoodie', brand: 'Eiger Adventure', supp: 3, weight: 650, desc: 'Jaket gunung tahan angin dan percikan air untuk pendakian.', skus: [
    { sku: 'EGR-JKT-BLK-L', warna: 'Hitam Solid', ukuran: 'L', modal: 320000, jual: 589000 },
    { sku: 'EGR-JKT-BLU-XL', warna: 'Biru Navy', ukuran: 'XL', modal: 320000, jual: 589000 }
  ]},

  // Fashion Wanita
  { name: 'Cottonink Blouse Lengan Balon Casual Wanita', sub: 'Blouse & Tunik', brand: 'Cottonink', supp: 3, weight: 260, desc: 'Blouse wanita elegan beraksen balon pada pergelangan tangan.', skus: [
    { sku: 'CTN-BLS-BEG-S', warna: 'Beige', ukuran: 'S/M', modal: 140000, jual: 279000 },
    { sku: 'CTN-BLS-TER-L', warna: 'Terracotta', ukuran: 'L/XL', modal: 140000, jual: 279000 }
  ]},
  { name: 'Cottonink Celana Kulot Linen High Waist', sub: 'Gaun & Dress', brand: 'Cottonink', supp: 3, weight: 340, desc: 'Celana kulot berbahan linen natural bernapas ramah lingkungan.', skus: [
    { sku: 'CTN-KLT-OLV-M', warna: 'Olive Green', ukuran: 'M', modal: 160000, jual: 319000 }
  ]},

  // Skincare & Kosmetik
  { name: 'Wardah Lightening Serum Ampoule Niacinamide 30ml', sub: 'Perawatan Wajah (Skincare)', brand: 'Wardah', supp: 9, weight: 120, desc: 'Serum pencerah wajah dengan 10x Advanced Niacinamide murni.', skus: [
    { sku: 'WRD-LSA-30ML', warna: 'Bening', ukuran: '30ml', modal: 48000, jual: 82000 }
  ]},
  { name: 'Somethinc Ceramic Skin Saviour Moisturizer Gel', sub: 'Perawatan Wajah (Skincare)', brand: 'Somethinc', supp: 9, weight: 180, desc: 'Pelembap gel 10x Ceramide mengunci kelembapan 24 jam penuh.', skus: [
    { sku: 'SMT-CSM-50G', warna: 'Clear', ukuran: '50 gram', modal: 110000, jual: 179000 }
  ]},
  { name: 'Wardah Colorfit Velvet Lip Mousse Matte', sub: 'Makeup & Kosmetik', brand: 'Wardah', supp: 9, weight: 60, desc: 'Lip velvet matte ringan di bibir tanpa membuat pecah-pecah.', skus: [
    { sku: 'WRD-CLM-03', warna: 'Chic Rose', ukuran: '4 gram', modal: 42000, jual: 74000 },
    { sku: 'WRD-CLM-08', warna: 'Brown Creator', ukuran: '4 gram', modal: 42000, jual: 74000 }
  ]},

  // Rumah Tangga
  { name: 'Philips Air Fryer Digital HD9252 Touchscreen', sub: 'Peralatan Dapur & Masak', brand: 'Philips', supp: 1, weight: 4800, desc: 'Penggoreng tanpa minyak Rapid Air technology kapasitas 4.1 Liter.', skus: [
    { sku: 'PHL-AF-HD9252', warna: 'Hitam Glossy', ukuran: '4.1L 1400W', modal: 850000, jual: 1249000 }
  ]},
  { name: 'Miyako Rice Cooker Magic Com MCM-508 SBC', sub: 'Peralatan Dapur & Masak', brand: 'Miyako', supp: 1, weight: 3200, desc: 'Penanak nasi serbaguna anti lengket kapasitas 1.8 Liter.', skus: [
    { sku: 'MYK-RC-508-SLV', warna: 'Silver Motif', ukuran: '1.8L 395W', modal: 190000, jual: 285000 }
  ]},
  { name: 'Oxone Pisau Dapur Stainless Set 6 Pcs', sub: 'Peralatan Dapur & Masak', brand: 'Oxone', supp: 1, weight: 1400, desc: 'Set pisau dapur marmer stainless tajam anti karat higienis.', skus: [
    { sku: 'OXN-KNF-SET6', warna: 'Marble Black', ukuran: 'Set 6 Pcs', modal: 145000, jual: 245000 }
  ]},

  // Makanan & Minuman
  { name: 'Kopi Kenangan Mantan Biji Kopi Arabika Robusta 500g', sub: 'Kopi & Teh Nusantara', brand: 'Kopi Kenangan', supp: 2, weight: 550, desc: 'Blend signature Kopi Kenangan rasa karamel dan cokelat lembut.', skus: [
    { sku: 'KPN-BJK-500G', warna: 'Roasted Dark', ukuran: '500 gram', modal: 65000, jual: 99000 }
  ]},
  { name: 'Kapal Api Kopi Bubuk Spesial Mix 10 Sachet Pack', sub: 'Kopi & Teh Nusantara', brand: 'Kapal Api', supp: 2, weight: 300, desc: 'Kopi hitam manis aroma mantap dari biji pilihan Indonesia.', skus: [
    { sku: 'KPA-MIX-10S', warna: 'Original', ukuran: '10 x 25g', modal: 14000, jual: 19500 }
  ]},
  { name: 'Indomie Mi Instan Goreng Rasa Spesial 1 Dus (40 Pcs)', sub: 'Bumbu Dapur & Bahan Pokok', brand: 'Indomie', supp: 2, weight: 3600, desc: 'Mi goreng legendaris Indonesia dengan bumbu gurih nikmat.', skus: [
    { sku: 'IDM-MGR-KRT40', warna: 'Kemasan Standar', ukuran: '1 Dus (40 Bungkus)', modal: 115000, jual: 142000 }
  ]},

  // Olahraga & Otomotif
  { name: 'Specs Sepatu Futsal Accelerator Lightspeed Reborn', sub: 'Sepatu Lari & Gym', brand: 'Specs', supp: 4, weight: 900, desc: 'Sepatu futsal bobot ringan dengan sol karet cengkeram tinggi.', skus: [
    { sku: 'SPC-FT-ACC-41', warna: 'Cyan / White', ukuran: '41', modal: 310000, jual: 499000 },
    { sku: 'SPC-FT-ACC-42', warna: 'Cyan / White', ukuran: '42', modal: 310000, jual: 499000 }
  ]},
  { name: 'KYT Helm Full Face TT Course Grand Prix Edition', sub: 'Helm & Apparel Motor', brand: 'KYT', supp: 5, weight: 2100, desc: 'Helm balap berstandar SNI dan DOT dengan visor anti-scratch.', skus: [
    { sku: 'KYT-TTC-GP-L', warna: 'Matt Black Graphic', ukuran: 'L', modal: 850000, jual: 1250000 },
    { sku: 'KYT-TTC-GP-XL', warna: 'Matt Black Graphic', ukuran: 'XL', modal: 850000, jual: 1250000 }
  ]},
  { name: 'Pertamina Enduro 4T Racing Matic Oli Motor 1 Liter', sub: 'Oli & Cairan Perawatan', brand: 'Pertamina Lubricants', supp: 5, weight: 1050, desc: 'Oli sintetik motor matic dengan proteksi mesin maksimal.', skus: [
    { sku: 'PRT-END-4T-1L', warna: 'Biru Botol', ukuran: '1 Liter', modal: 48000, jual: 67000 }
  ]}
];

function getSubkategoriId(name) {
  const found = subkategoriMap.find(s => s.name === name);
  return found ? found.id : 1;
}

const merekRows = db.prepare('SELECT merek_id, nama_merek FROM merek').all();
function getMerekId(name) {
  const found = merekRows.find(m => m.nama_merek === name);
  return found ? found.merek_id : 1;
}

const insertProduk = db.prepare(`
  INSERT INTO produk (subkategori_id, merek_id, supplier_id, nama_produk, deskripsi, berat_gram)
  VALUES (?, ?, ?, ?, ?, ?)
`);

const insertVariasi = db.prepare(`
  INSERT INTO variasi_produk (produk_id, sku, warna, ukuran, harga_modal, harga_jual)
  VALUES (?, ?, ?, ?, ?, ?)
`);

const insertStok = db.prepare(`
  INSERT INTO stok_gudang (gudang_id, variasi_id, jumlah_stok)
  VALUES (?, ?, ?)
`);

const allProducts = [];
const allSkus = [];

db.exec('BEGIN TRANSACTION;');

for (const p of rawProducts) {
  const subId = getSubkategoriId(p.sub);
  const brandId = getMerekId(p.brand);
  insertProduk.run(subId, brandId, p.supp, p.name, p.desc, p.weight);
  const pId = db.prepare('SELECT last_insert_rowid() as id').get().id;
  allProducts.push({ id: pId, name: p.name, weight: p.weight, subId, brandId });

  for (const s of p.skus) {
    insertVariasi.run(pId, s.sku, s.warna, s.ukuran, s.modal, s.jual);
    const vId = db.prepare('SELECT last_insert_rowid() as id').get().id;
    allSkus.push({
      variasiId: vId,
      produkId: pId,
      sku: s.sku,
      warna: s.warna,
      ukuran: s.ukuran,
      hargaModal: s.modal,
      hargaJual: s.jual,
      beratGram: p.weight,
      name: p.name
    });

    for (let gId = 1; gId <= warehousesData.length; gId++) {
      const stock = Math.random() < 0.12 ? randInt(2, 8) : randInt(25, 450);
      insertStok.run(gId, vId, stock);
    }
  }
}

db.exec('COMMIT;');
console.log(`Produk seeded: ${allProducts.length} produk, Variasi SKU: ${allSkus.length} variasi.`);

// -------------------------------------------------------------
// 14. PESANAN & 15. RINCIAN PESANAN (TARGET: 5.631 BARIS RINCIAN!)
// -------------------------------------------------------------
console.log('Generating orders and exactly 5.631 order item rows...');

const TARGET_ORDER_ITEMS = 5631;
let currentItemCount = 0;
let orderIndex = 1;

// Leave customers with id > 1150 WITHOUT any orders (Anti-Join churn demo: 50 customers)
const activeCustomerMax = 1150;

const insertPesanan = db.prepare(`
  INSERT INTO pesanan (
    nomor_invoice, pelanggan_id, alamat_kirim_id, kurir_id, metode_id, voucher_id,
    tanggal_pesanan, status_pesanan, total_berat_gram, ongkos_kirim, potongan_diskon, total_bayar
  ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
`);

const insertRincian = db.prepare(`
  INSERT INTO rincian_pesanan (pesanan_id, variasi_id, jumlah, harga_satuan, subtotal)
  VALUES (?, ?, ?, ?, ?)
`);

const insertRiwayatBayar = db.prepare(`
  INSERT INTO riwayat_pembayaran (pesanan_id, tanggal_bayar, jumlah_dibayar, nomor_referensi, status_pembayaran)
  VALUES (?, ?, ?, ?, ?)
`);

const insertStatusKirim = db.prepare(`
  INSERT INTO status_pengiriman (pesanan_id, nomor_resi, waktu_update, status_lokasi, keterangan)
  VALUES (?, ?, ?, ?, ?)
`);

const insertUlasan = db.prepare(`
  INSERT INTO ulasan_produk (produk_id, pelanggan_id, pesanan_id, rating, komentar, tanggal_ulasan)
  VALUES (?, ?, ?, ?, ?, ?)
`);

const sampleReviews = [
  'Barang original 100%, pengiriman super kilat! Recomended seller.',
  'Kualitas bahan sangat bagus, jahitan rapi, ukuran pas di badan.',
  'Packing aman sekali dengan bubble wrap tebal dan kardus tebal.',
  'Fungsi normal semua, garansi resmi terdaftar aman.',
  'Harga bersaing dibanding toko sebelah, respon admin cepat dan ramah.',
  'Produk sesuai ekspektasi dan deskripsi, puas belanja di sini.',
  'Bintang 5! Sangat memuaskan, repeat order kedua kalinya.',
  'Cepat sampai, kemarin pesan sore tadi siang sudah tiba.',
  'Barang berfungsi dengan baik tanpa ada lecet sama sekali.',
  'Keren banget, warna dan modelnya elegan.'
];

db.exec('BEGIN TRANSACTION;');

while (currentItemCount < TARGET_ORDER_ITEMS) {
  const custId = randInt(1, activeCustomerMax);
  const custAddrs = customerAddresses.filter(a => a.custId === custId);
  const addr = custAddrs.length > 0 ? randChoice(custAddrs) : customerAddresses[0];

  const kurirId = randInt(1, couriersData.length);
  const kurirTarif = couriersData[kurirId - 1][2];
  const metodeId = randInt(1, paymentMethodsData.length);

  const statusRoll = Math.random();
  let statusPesanan = 'Selesai';
  if (statusRoll < 0.06) statusPesanan = 'Dibatalkan';
  else if (statusRoll < 0.14) statusPesanan = 'Diproses';
  else if (statusRoll < 0.20) statusPesanan = 'Dikirim';

  const monthWeights = [1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8];
  const chosenMonth = randChoice(monthWeights);
  const day = randInt(1, 28);
  const hour = String(randInt(8, 22)).padStart(2, '0');
  const minute = String(randInt(0, 59)).padStart(2, '0');
  const second = String(randInt(0, 59)).padStart(2, '0');
  const orderDate = `2024-${String(chosenMonth).padStart(2, '0')}-${String(day).padStart(2, '0')} ${hour}:${minute}:${second}`;

  const remaining = TARGET_ORDER_ITEMS - currentItemCount;
  let itemsInOrder = randInt(1, 3);
  if (remaining < itemsInOrder) {
    itemsInOrder = remaining;
  }

  const orderSkus = [];
  for (let k = 0; k < itemsInOrder; k++) {
    const sku = randChoice(allSkus);
    const qty = randInt(1, 2);
    orderSkus.push({ ...sku, qty });
  }

  let totalBerat = 0;
  let subtotalPesanan = 0;
  for (const it of orderSkus) {
    totalBerat += it.beratGram * it.qty;
    subtotalPesanan += it.hargaJual * it.qty;
  }

  const beratKg = Math.max(1, Math.ceil(totalBerat / 1000));
  const ongkosKirim = beratKg * kurirTarif;

  let voucherId = null;
  let diskon = 0;
  if (Math.random() < 0.45 && subtotalPesanan >= 150000) {
    voucherId = randInt(1, vouchersData.length);
    const v = vouchersData[voucherId - 1];
    if (v[1] === 'Nominal') {
      diskon = v[2];
    } else {
      diskon = Math.round((subtotalPesanan * v[2]) / 100);
      if (diskon > 50000) diskon = 50000;
    }
  }

  const totalBayar = Math.max(10000, subtotalPesanan + ongkosKirim - diskon);
  const invoiceNum = `INV/2024${String(chosenMonth).padStart(2, '0')}${String(day).padStart(2, '0')}/${String(orderIndex).padStart(5, '0')}`;

  insertPesanan.run(
    invoiceNum,
    custId,
    addr.id,
    kurirId,
    metodeId,
    voucherId,
    orderDate,
    statusPesanan,
    totalBerat,
    ongkosKirim,
    diskon,
    totalBayar
  );
  const pId = db.prepare('SELECT last_insert_rowid() as id').get().id;

  for (const it of orderSkus) {
    const itemSubtotal = it.hargaJual * it.qty;
    insertRincian.run(pId, it.variasiId, it.qty, it.hargaJual, itemSubtotal);
    currentItemCount++;

    if (statusPesanan === 'Selesai' && Math.random() < 0.25) {
      const rating = randChoice([4, 5, 5, 5, 4, 3, 5]);
      const comment = randChoice(sampleReviews);
      insertUlasan.run(it.produkId, custId, pId, rating, comment, orderDate);
    }
  }

  let paymentStatus = 'Berhasil';
  if (statusPesanan === 'Dibatalkan') paymentStatus = 'Gagal';
  else if (statusPesanan === 'Diproses') paymentStatus = 'Pending';
  
  insertRiwayatBayar.run(
    pId,
    orderDate,
    totalBayar,
    `PAY-${invoiceNum.replace(/\//g, '-')}`,
    paymentStatus
  );

  if (statusPesanan === 'Selesai' || statusPesanan === 'Dikirim') {
    const resi = `JP${randInt(100000000, 999999999)}ID`;
    insertStatusKirim.run(
      pId,
      resi,
      orderDate,
      addr.kota,
      statusPesanan === 'Selesai' ? 'Paket telah berhasil diterima oleh penerima.' : 'Paket sedang dibawa kurir menuju alamat tujuan.'
    );
  }

  orderIndex++;
}

db.exec('COMMIT;');
console.log(`Pesanan seeded: ${orderIndex - 1} pesanan.`);
console.log(`Rincian pesanan seeded: ${currentItemCount} baris.`);

// -------------------------------------------------------------
// 19. KERANJANG BELANJA & 20. WISHLIST PRODUK
// -------------------------------------------------------------
const insertKeranjang = db.prepare(`
  INSERT INTO keranjang_belanja (pelanggan_id, variasi_id, jumlah, tanggal_ditambahkan)
  VALUES (?, ?, ?, ?)
`);

const insertWishlist = db.prepare(`
  INSERT INTO wishlist_produk (pelanggan_id, produk_id, tanggal_simpan)
  VALUES (?, ?, ?)
`);

db.exec('BEGIN TRANSACTION;');

for (let i = 0; i < 350; i++) {
  const custId = randInt(1, TOTAL_CUSTOMERS);
  const sku = randChoice(allSkus);
  insertKeranjang.run(custId, sku.variasiId, randInt(1, 3), '2024-12-15 14:30:00');
}

for (let i = 0; i < 450; i++) {
  const custId = randInt(1, TOTAL_CUSTOMERS);
  const prod = randChoice(allProducts);
  insertWishlist.run(custId, prod.id, '2024-12-10 10:15:00');
}

db.exec('COMMIT;');
console.log('Keranjang belanja (350) dan Wishlist produk (450) seeded.');

// -------------------------------------------------------------
// SUMMARY & ROW COUNT AUDIT
// -------------------------------------------------------------
console.log('\n--- VERIFIKASI ROW COUNT SELURUH 20 TABEL ---');
const tables = db.prepare("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name").all();
let grandTotalRows = 0;

for (const t of tables) {
  const count = db.prepare(`SELECT COUNT(*) as cnt FROM "${t.name}"`).get().cnt;
  console.log(`- ${t.name.padEnd(22)}: ${count.toLocaleString('id-ID')} baris`);
  grandTotalRows += count;
}

console.log(`\nGrand Total Seluruh Baris Data: ${grandTotalRows.toLocaleString('id-ID')} baris`);
console.log('SEEDED COMPLETED SUCCESSFULLY!');
