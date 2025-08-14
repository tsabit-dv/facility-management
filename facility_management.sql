-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 14, 2025 at 01:50 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `facility_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `ad_hoc_forms`
--

CREATE TABLE `ad_hoc_forms` (
  `id` int(11) NOT NULL,
  `work_order_id` int(11) NOT NULL,
  `job_task` text DEFAULT NULL,
  `photo` blob NOT NULL,
  `photo_vector` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`photo_vector`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ad_hoc_forms`
--

INSERT INTO `ad_hoc_forms` (`id`, `work_order_id`, `job_task`, `photo`, `photo_vector`, `created_at`) VALUES
(1, 4, 'Mengganti lampu di tangga darurat', '', NULL, '2025-08-12 04:30:00'),
(2, 4, 'Membersihkan tumpahan di lobi', '', NULL, '2025-08-12 04:35:00');

-- --------------------------------------------------------

--
-- Table structure for table `clean_forms`
--

CREATE TABLE `clean_forms` (
  `id` int(11) NOT NULL,
  `work_order_id` int(11) NOT NULL,
  `location` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `tools_used` varchar(255) DEFAULT NULL,
  `cleaning_type` enum('Light','Deep','Special') NOT NULL,
  `duration_minutes` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clean_forms`
--

INSERT INTO `clean_forms` (`id`, `work_order_id`, `location`, `description`, `tools_used`, `cleaning_type`, `duration_minutes`, `created_at`) VALUES
(1, 1, 'Ruang Meeting', 'Membersihkan lantai, meja, dan kaca', 'Sapu, Kain Pel, Pembersih Kaca', 'Deep', 45, '2025-08-12 02:15:00'),
(2, 1, 'Kantin', 'Membersihkan meja dan lantai', 'Pel, Deterjen', 'Light', 30, '2025-08-12 02:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `control_forms`
--

CREATE TABLE `control_forms` (
  `id` int(11) NOT NULL,
  `work_order_id` int(11) NOT NULL,
  `system_checked` varchar(255) NOT NULL,
  `status_check` enum('Operational','MaintenanceRequired','Failed') NOT NULL,
  `last_maintenance_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `control_forms`
--

INSERT INTO `control_forms` (`id`, `work_order_id`, `system_checked`, `status_check`, `last_maintenance_date`, `notes`, `created_at`) VALUES
(1, 3, 'Sistem AC', 'Operational', '2025-07-15', 'AC berfungsi normal, suhu stabil', '2025-08-12 04:00:00'),
(2, 3, 'Sistem Listrik', 'MaintenanceRequired', '2025-06-20', 'Beberapa stop kontak perlu diperiksa', '2025-08-12 04:05:00');

-- --------------------------------------------------------

--
-- Table structure for table `inspection_forms`
--

CREATE TABLE `inspection_forms` (
  `id` int(11) NOT NULL,
  `work_order_id` int(11) NOT NULL,
  `area_inspected` varchar(255) NOT NULL,
  `is_clean` tinyint(1) NOT NULL,
  `is_safe` tinyint(1) NOT NULL,
  `equipment_condition` enum('Good','NeedsRepair','Neutral') NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inspection_forms`
--

INSERT INTO `inspection_forms` (`id`, `work_order_id`, `area_inspected`, `is_clean`, `is_safe`, `equipment_condition`, `notes`, `created_at`) VALUES
(1, 2, 'Lantai 3', 1, 0, 'NeedsRepair', 'Lantai bersih, tetapi ada kabel longgar di lorong', '2025-08-12 03:35:00'),
(2, 2, 'Ruang Server', 1, 1, 'Good', 'Semua peralatan berfungsi normal', '2025-08-12 03:40:00');

-- --------------------------------------------------------

--
-- Table structure for table `photo_after`
--

CREATE TABLE `photo_after` (
  `id` int(11) NOT NULL,
  `work_order_id` int(11) NOT NULL,
  `photo` blob NOT NULL,
  `photo_vector` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`photo_vector`)),
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `photo_after`
--

INSERT INTO `photo_after` (`id`, `work_order_id`, `photo`, `photo_vector`, `uploaded_at`) VALUES
(1, 1, 0xffd8ffe000104a46494600010100000100010000ffdb0043000101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101ffc0001108000100010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aaabacadaeafa0b2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffda000c03010002110311003f00fffe000c03010002110311003f00, '[253,2,2,129,65,33,17,9,5,3]', '2025-08-12 03:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `photo_before`
--

CREATE TABLE `photo_before` (
  `id` int(11) NOT NULL,
  `work_order_id` int(11) NOT NULL,
  `photo` blob NOT NULL,
  `photo_vector` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`photo_vector`)),
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `photo_before`
--

INSERT INTO `photo_before` (`id`, `work_order_id`, `photo`, `photo_vector`, `uploaded_at`) VALUES
(1, 1, 0xffd8ffe000104a46494600010100000100010000ffdb0043000101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101ffc0001108000100010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aaabacadaeafa0b2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffda000c03010002110311003f00fffe000c03010002110311003f00, '[254,0,0,128,64,32,16,8,4,2]', '2025-08-12 02:15:00'),
(2, 2, 0xffd8ffe000104a46494600010100000100010000ffdb0043000101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101ffc0001108000100010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aaabacadaeafa0b2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffda000c03010002110311003f00fffe000c03010002110311003f00, '[255,1,1,127,63,31,15,7,3,1]', '2025-08-12 03:35:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `role` enum('OfficeBoy','Supervisor','Admin') NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `name`, `role`, `password`, `created_at`) VALUES
(1, 'ob', 'John Doe', 'OfficeBoy', '123', '2025-08-12 02:00:00'),
(2, 'spv', 'Jane Smith', 'Supervisor', '456', '2025-08-12 02:00:00'),
(3, 'admin_user', 'Admin User', 'Admin', 'hashed_password_789', '2025-08-12 02:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `work_orders`
--

CREATE TABLE `work_orders` (
  `work_order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category` enum('Clean','Inspection','Control','AdHoc') NOT NULL,
  `status` enum('Pending','Ongoing','Finished') DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `started_at` timestamp NULL DEFAULT NULL,
  `finished_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `work_orders`
--

INSERT INTO `work_orders` (`work_order_id`, `user_id`, `category`, `status`, `created_at`, `started_at`, `finished_at`) VALUES
(1, 1, 'Clean', 'Finished', '2025-08-12 02:10:00', '2025-08-12 02:15:00', '2025-08-12 03:00:00'),
(2, 1, 'Inspection', 'Ongoing', '2025-08-12 03:30:00', '2025-08-12 03:35:00', NULL),
(3, 1, 'Control', 'Pending', '2025-08-12 04:00:00', NULL, NULL),
(4, 1, 'AdHoc', 'Pending', '2025-08-12 04:30:00', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ad_hoc_forms`
--
ALTER TABLE `ad_hoc_forms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `work_order_id` (`work_order_id`);

--
-- Indexes for table `clean_forms`
--
ALTER TABLE `clean_forms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `work_order_id` (`work_order_id`);

--
-- Indexes for table `control_forms`
--
ALTER TABLE `control_forms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `work_order_id` (`work_order_id`);

--
-- Indexes for table `inspection_forms`
--
ALTER TABLE `inspection_forms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `work_order_id` (`work_order_id`);

--
-- Indexes for table `photo_after`
--
ALTER TABLE `photo_after`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_work_order_id` (`work_order_id`);

--
-- Indexes for table `photo_before`
--
ALTER TABLE `photo_before`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_work_order_id` (`work_order_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `work_orders`
--
ALTER TABLE `work_orders`
  ADD PRIMARY KEY (`work_order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ad_hoc_forms`
--
ALTER TABLE `ad_hoc_forms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `clean_forms`
--
ALTER TABLE `clean_forms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `control_forms`
--
ALTER TABLE `control_forms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inspection_forms`
--
ALTER TABLE `inspection_forms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `photo_after`
--
ALTER TABLE `photo_after`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `photo_before`
--
ALTER TABLE `photo_before`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `work_orders`
--
ALTER TABLE `work_orders`
  MODIFY `work_order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ad_hoc_forms`
--
ALTER TABLE `ad_hoc_forms`
  ADD CONSTRAINT `ad_hoc_forms_ibfk_1` FOREIGN KEY (`work_order_id`) REFERENCES `work_orders` (`work_order_id`) ON DELETE CASCADE;

--
-- Constraints for table `clean_forms`
--
ALTER TABLE `clean_forms`
  ADD CONSTRAINT `clean_forms_ibfk_1` FOREIGN KEY (`work_order_id`) REFERENCES `work_orders` (`work_order_id`) ON DELETE CASCADE;

--
-- Constraints for table `control_forms`
--
ALTER TABLE `control_forms`
  ADD CONSTRAINT `control_forms_ibfk_1` FOREIGN KEY (`work_order_id`) REFERENCES `work_orders` (`work_order_id`) ON DELETE CASCADE;

--
-- Constraints for table `inspection_forms`
--
ALTER TABLE `inspection_forms`
  ADD CONSTRAINT `inspection_forms_ibfk_1` FOREIGN KEY (`work_order_id`) REFERENCES `work_orders` (`work_order_id`) ON DELETE CASCADE;

--
-- Constraints for table `photo_after`
--
ALTER TABLE `photo_after`
  ADD CONSTRAINT `photo_after_ibfk_1` FOREIGN KEY (`work_order_id`) REFERENCES `work_orders` (`work_order_id`) ON DELETE CASCADE;

--
-- Constraints for table `photo_before`
--
ALTER TABLE `photo_before`
  ADD CONSTRAINT `photo_before_ibfk_1` FOREIGN KEY (`work_order_id`) REFERENCES `work_orders` (`work_order_id`) ON DELETE CASCADE;

--
-- Constraints for table `work_orders`
--
ALTER TABLE `work_orders`
  ADD CONSTRAINT `work_orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
