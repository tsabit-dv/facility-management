CREATE DATABASE facility_management;
USE facility_management;

-- Tabel untuk menyimpan informasi pengguna
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    role ENUM('OfficeBoy', 'Supervisor', 'Admin') NOT NULL,
    password VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel untuk menyimpan work orders
CREATE TABLE work_orders (
    work_order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    category ENUM('Clean', 'Inspection', 'Control', 'AdHoc') NOT NULL, -- Tambah AdHoc
    status ENUM('Pending', 'Ongoing', 'Finished') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    started_at TIMESTAMP NULL,
    finished_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Tabel untuk form Clean (tugas cleaning service)
CREATE TABLE clean_forms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    work_order_id INT NOT NULL,
    location VARCHAR(255) NOT NULL, -- Lokasi pembersihan (misalnya Ruang Meeting)
    description TEXT, -- Deskripsi tugas pembersihan
    tools_used VARCHAR(255), -- Alat yang digunakan (misalnya Sapu, Kain Pel)
    cleaning_type ENUM('Light', 'Deep', 'Special') NOT NULL, -- Jenis pembersihan
    duration_minutes INT, -- Estimasi durasi pembersihan dalam menit
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (work_order_id) REFERENCES work_orders(work_order_id) ON DELETE CASCADE
);

-- Tabel untuk form Inspection (fokus pada boolean dan keterangan)
CREATE TABLE inspection_forms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    work_order_id INT NOT NULL,
    area_inspected VARCHAR(255) NOT NULL, -- Area yang diperiksa
    is_clean BOOLEAN NOT NULL, -- Apakah area bersih? (Ya/Tidak)
    is_safe BOOLEAN NOT NULL, -- Apakah area aman? (Ya/Tidak)
    equipment_condition ENUM('Good', 'NeedsRepair', 'Neutral') NOT NULL, -- Kondisi peralatan
    notes TEXT, -- Keterangan tambahan
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (work_order_id) REFERENCES work_orders(work_order_id) ON DELETE CASCADE
);

-- Tabel untuk form Control (tugas pengendalian gedung)
CREATE TABLE control_forms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    work_order_id INT NOT NULL,
    system_checked VARCHAR(255) NOT NULL, -- Sistem yang diperiksa (misalnya AC, Listrik)
    status_check ENUM('Operational', 'MaintenanceRequired', 'Failed') NOT NULL, -- Status sistem
    last_maintenance_date DATE, -- Tanggal perawatan terakhir
    notes TEXT, -- Catatan tambahan
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (work_order_id) REFERENCES work_orders(work_order_id) ON DELETE CASCADE
);

-- Tabel untuk form Ad-Hoc (hanya foto dan text area)
CREATE TABLE ad_hoc_forms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    work_order_id INT NOT NULL,
    description TEXT, -- Text area untuk deskripsi
    photo_path VARCHAR(255), -- Path ke file foto
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (work_order_id) REFERENCES work_orders(work_order_id) ON DELETE CASCADE
);

-- Tabel untuk menyimpan foto before
CREATE TABLE photo_before (
    id INT AUTO_INCREMENT PRIMARY KEY,
    work_order_id INT NOT NULL,
    photo_path VARCHAR(255) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (work_order_id) REFERENCES work_orders(work_order_id) ON DELETE CASCADE
);

-- Tabel untuk menyimpan foto after
CREATE TABLE photo_after (
    id INT AUTO_INCREMENT PRIMARY KEY,
    work_order_id INT NOT NULL,
    photo_path VARCHAR(255) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (work_order_id) REFERENCES work_orders(work_order_id) ON DELETE CASCADE
);

ALTER TABLE ad_hoc_forms
  DROP COLUMN photo_path,
  ADD COLUMN photo BLOB NOT NULL AFTER job_task,
  ADD COLUMN photo_vector JSON NULL AFTER photo;
