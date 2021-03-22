-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.22 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for solutech_store
DROP DATABASE IF EXISTS `solutech_store`;
CREATE DATABASE IF NOT EXISTS `solutech_store` /*!40100 DEFAULT CHARACTER SET armscii8 COLLATE armscii8_bin */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `solutech_store`;

-- Dumping structure for table solutech_store.menus
DROP TABLE IF EXISTS `menus`;
CREATE TABLE IF NOT EXISTS `menus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `path` varchar(200) DEFAULT NULL,
  `iconCls` varchar(200) DEFAULT NULL,
  `level` int NOT NULL DEFAULT '0',
  `parent_id` int DEFAULT '0',
  `order_no` int DEFAULT NULL,
  `is_disabled` int NOT NULL DEFAULT '0',
  `is_menu` int NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

-- Dumping data for table solutech_store.menus: ~5 rows (approximately)
DELETE FROM `menus`;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` (`id`, `name`, `path`, `iconCls`, `level`, `parent_id`, `order_no`, `is_disabled`, `is_menu`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
	(1, 'Code Challenge', NULL, 'fa fa-code', 1, 0, 5, 0, 1, '2021-03-21 15:27:00', 4, '2021-03-21 15:36:21', 4),
	(2, 'Suppliers', 'suppliers', NULL, 2, 1, 1, 0, 1, '2021-03-21 15:27:58', 4, '2021-03-21 15:43:56', 4),
	(3, 'Products', 'products', NULL, 2, 1, 2, 0, 1, '2021-03-21 15:28:36', 4, '2021-03-21 15:44:05', 4),
	(4, 'Orders', 'orders', NULL, 2, 1, 3, 0, 1, '2021-03-21 15:28:47', 4, '2021-03-21 15:44:14', 4),
	(5, 'Supplier Products', 'supplierproducts', NULL, 2, 1, 4, 0, 1, '2021-03-21 18:22:17', 4, NULL, NULL);
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;

-- Dumping structure for table solutech_store.oauth_access_tokens
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `client_id` bigint unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table solutech_store.oauth_access_tokens: ~49 rows (approximately)
DELETE FROM `oauth_access_tokens`;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
	('03fc334fe8c29cb24e3180e6bf330379be7b6feec7f916a91e8803edd89ea098a152c505bf1891b1', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-06-30 22:44:22', '2020-06-30 22:44:22', '2021-06-30 21:44:22'),
	('088c828ae22a07fe18036f66d4d7a66369d942770f44cd8d9619e2a77e3b34ea5e0d6786ae996c53', 2, 7, NULL, '[]', 0, '2020-06-11 13:53:45', '2020-06-11 13:53:45', '2020-06-26 12:53:45'),
	('0b1da47c258952804c0237ee7cef1fe019f677cf36b8701e48ef982fd4e6bfb72b83e6a84b34289b', NULL, 8, NULL, '[]', 0, '2020-07-09 13:12:36', '2020-07-09 13:12:36', '2020-07-24 12:12:36'),
	('0ccacbbda85ea45a9276e4f6525ac93388368ec1e9804b707882a15159677621d49787174393cc17', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-07-01 18:32:52', '2020-07-01 18:32:52', '2021-07-01 17:32:52'),
	('11f9f0e2c19f8a7349c18a88f4690aa0cdbf1028337a8ca8c1855bad19dea0ea3992a583ae2ae9c2', NULL, 8, NULL, '[]', 0, '2020-06-11 13:35:37', '2020-06-11 13:35:37', '2020-06-26 12:35:37'),
	('1afef680e0609e523fa8914d6d0e620ed3fb10d76d78a430eeb6b9b19307a8f57989b9f2651b1496', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-09-16 14:46:35', '2020-09-16 14:46:35', '2021-09-16 14:46:35'),
	('1c8cfc43aa0e39e2933418770564765af21fca48b2e0394ecc16dad5aae2db9c49928863ab61e061', 2, 4, NULL, '["read-users"]', 0, '2020-07-09 12:59:54', '2020-07-09 12:59:54', '2020-07-24 11:59:53'),
	('20f2aad8c6776b9759f2fec157a5696bba870e50d137e45032b69b66575c163eddaba0ca97bc7710', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-06-11 13:42:15', '2020-06-11 13:42:15', '2021-06-11 12:42:15'),
	('24541925444e4beff7046ec56bafc66d9b218a5050f7c4c1fc739e05fbc8b4d177c98f469b503789', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-09-17 09:33:21', '2020-09-17 09:33:21', '2021-09-17 09:33:21'),
	('293773f1e6fb5f7ffc73fb8fb3e9a639ed2ac54ee627dcd6aa1ec7232df3927c497aabb60dbfc545', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-11-29 11:07:13', '2020-11-29 11:07:13', '2021-11-29 11:07:13'),
	('3feeecdc7ad933467a2ec46e0f5f223b7d41495a0151b5a5d21f64125bdc921a5c9a5578e8bee0e6', 2, 10, 'Personal Access Client1', '[]', 0, '2020-06-11 11:57:03', '2020-06-11 11:57:03', '2021-06-11 10:57:03'),
	('4f3774966e2072aff3aff9301b22a9aae3a54af09fa0636058204655fdccdf73c52c91089ac6d32b', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-07-01 18:35:06', '2020-07-01 18:35:06', '2021-07-01 17:35:06'),
	('51fa0dfb64fcea5ff41d4bd1fed61e0d5e2f04bfd07f62595306cd37235c09b549b1f281fe2057e6', NULL, 8, NULL, '[]', 0, '2020-07-09 13:13:27', '2020-07-09 13:13:27', '2020-07-24 12:13:27'),
	('53f4e41d2886a07849ffd644fbf139d4b1ef7011cc68ce372db1a5642608e1b8a9404e48b66ff8ea', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-09-16 14:46:30', '2020-09-16 14:46:30', '2021-09-16 14:46:30'),
	('5a36a71ed1e0c867f7cfba36de569614b862de352c3212c07bbe0dcf25b883cd6e38e3d77a4646b2', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-11-29 18:16:36', '2020-11-29 18:16:36', '2021-11-29 18:16:36'),
	('5fd4805491d0feb4d8d414d0171082e48106033d9fc7b95b932d75ae4338c9e08faaf024f2cdee5b', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-09-16 14:46:30', '2020-09-16 14:46:30', '2021-09-16 14:46:30'),
	('638b8408267243295a89626fb71481d13cae484022748cde0d8dc07e3c56bfb0aaff6aeaaae7aadd', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-11-29 11:42:54', '2020-11-29 11:42:54', '2021-11-29 11:42:54'),
	('663019be138b903fa9b45f412f49f42310ba14d21e2ff0f130ecb577bbf5aee00eff70a23893b27a', 2, 4, NULL, '["read-users"]', 0, '2020-06-11 13:29:43', '2020-06-11 13:29:43', '2020-06-26 12:29:43'),
	('6a854570fed9a983d68973cec9c8c3a3cf55bbc267df28008b54a1cf777612d0e33b1c0f761a7327', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-06-11 11:55:35', '2020-06-11 11:55:35', '2021-06-11 10:55:35'),
	('6e09062bac2ca65d04b1473e686e02327da20149147aea2aa235091027211c04187e93bbf80fac4d', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-11-29 18:07:21', '2020-11-29 18:07:21', '2021-11-29 18:07:21'),
	('72ab3a65bec8b003e08ce33f32d4ce0ce2d762e91859ecc27562e3b456cf72169241f33b378ef2ba', 1, 10, 'Solutech', '["create-supplier","read-suppliers","update-supplier","delete-supplier"]', 0, '2021-03-22 14:42:09', '2021-03-22 14:42:09', '2022-03-22 14:42:09'),
	('77c4c8eff1a044b33abf5ef0342a94625355279cabae297ab4f8febd06c46eb85f459c7f33fdb8db', 2, 10, 'Personal Access Client1', '["create-user","read-users","update-user","delete-user"]', 0, '2020-11-29 11:34:46', '2020-11-29 11:34:46', '2021-11-29 11:34:46'),
	('838ad72d295e5b2a3587cf5e70b2ce3ede3ef838c9008fc6267721c903d998b5015065676cec5217', 2, 12, NULL, '[]', 0, '2020-06-11 13:48:48', '2020-06-11 13:48:48', '2020-06-26 12:48:48'),
	('8afede6041b1b8add6e184262fbbe704deb8addcfe009695dfcc8876d86cbc214d2e7d7a0889bfb8', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-09-16 14:46:30', '2020-09-16 14:46:30', '2021-09-16 14:46:30'),
	('8c6de9425fd0f03958362193ae38ab6b56d6289831dcbbf847d57bd9fafe1d271d663459d8634c18', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-07-01 10:41:13', '2020-07-01 10:41:13', '2021-07-01 09:41:13'),
	('905278652724836d5ecfde0a61517ab66cb6df40ec931f0c6fbaaf367f4e35d4f0bbcaf5580f59b8', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2021-03-22 11:38:57', '2021-03-22 11:38:57', '2022-03-22 11:38:57'),
	('916331e6cdfacf6dfd72d445117d43919b10fea974cef1694d29e6bab3c98ce93217cbf0f3ef4365', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-09-16 14:46:30', '2020-09-16 14:46:30', '2021-09-16 14:46:30'),
	('976fe56e1ecbad2255313c3aef67b3f3ac5997fa849ab76c1d354bc22b4c607178426ed6d7ca0a99', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-09-16 14:46:30', '2020-09-16 14:46:30', '2021-09-16 14:46:30'),
	('a90ec55cbd808f69742af59b5b8d5d4e8f8846698980c59c877aea9fc551a143079b147e1d2b405f', 2, 4, NULL, '["read-users"]', 0, '2020-06-08 23:24:12', '2020-06-08 23:24:12', '2020-06-23 22:24:12'),
	('ab5805860a1fdc9d0a80f3823a7a964739f73a8ce7f25d2b4a1dd981ebb0a9bc73178071af511a26', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-11-29 11:31:05', '2020-11-29 11:31:05', '2021-11-29 11:31:05'),
	('afbbbe9882d06a4fa72e4c636ac394384c080ff8a495c03b782d30a0f046a19d43cba0d0874c4dc8', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-06-30 22:37:56', '2020-06-30 22:37:56', '2021-06-30 21:37:56'),
	('b989a6b1a5945a80e9af1e91277f61c0065f6e320e65031ed056317994e3be6856a5a401d2b71ca1', 2, 10, 'Personal Access Client1', '["create-user","read-users","update-user","delete-user"]', 0, '2020-06-11 11:59:21', '2020-06-11 11:59:21', '2021-06-11 10:59:21'),
	('c0db8bd94ec4cfd5192e66845df806af117822b6294dfbe6f43ce8aa97b8ae3fcc1b3c00abe56b8c', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2021-03-21 15:03:23', '2021-03-21 15:03:23', '2022-03-21 15:03:23'),
	('c4bdf675a148c04ee0e81772f8b53862f0596e242ab1facc39e7740571f4214d47cc945e0f97d819', 2, 4, NULL, '["read-users"]', 0, '2020-07-09 11:07:12', '2020-07-09 11:07:12', '2020-07-24 10:07:10'),
	('c7fd7beff138ad66b30e09edd9e02133fccde5ce1eb9665c53ed144f85e0bfb8cce1c162422a6187', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-09-17 09:32:36', '2020-09-17 09:32:36', '2021-09-17 09:32:36'),
	('c9511917b3795692fff8127315f6fcbb2e8133843e416b428ab2e7ff88059e088025dd9ed30ccb52', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-11-30 17:36:28', '2020-11-30 17:36:28', '2021-11-30 17:36:28'),
	('cddfa540ececfbc7bc5fd63eafd27b525d61c2970a4119a8600f7ca5f59a26702efeae8ed29bd4f4', NULL, 8, NULL, '[]', 0, '2020-07-09 19:11:55', '2020-07-09 19:11:55', '2020-07-24 18:11:54'),
	('ce5beb45107ff4f7d7c6fa279392ddada94157167ccb599123342dfd22933f6c40a950913e863bf9', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-09-16 14:46:30', '2020-09-16 14:46:30', '2021-09-16 14:46:30'),
	('d0c4ec02d546e45403eb85376a053ad0510c48c4ec16f1ad18dfa0ec45520abdc8a6f3ad1f8640b6', NULL, 8, NULL, '[]', 0, '2020-07-09 13:11:31', '2020-07-09 13:11:31', '2020-07-24 12:11:31'),
	('d1aa5937df79031f75382cad0863eae0ed71f9e95f97650c5a767995a1fa7f4f9a0b707a3b773679', 2, 3, 'Laravel_VueJS Personal Access Client', '["create-user","read-users","update-user","delete-user"]', 0, '2020-06-08 23:25:34', '2020-06-08 23:25:34', '2021-06-08 22:25:34'),
	('d7be63c62a3041f4e6fe48fe07dca61d4c9eb4671b094302fe1cb339bb7ce2afe873da7fd550b990', 2, 4, NULL, '["read-users"]', 0, '2020-06-11 12:01:09', '2020-06-11 12:01:09', '2020-06-26 11:01:09'),
	('d911fbf0a4ecd07da6274b2d3941171aef827b3b8d6258a6788a59edeb3affd227aa6535dcc5642b', NULL, 8, NULL, '[]', 0, '2020-07-09 13:14:08', '2020-07-09 13:14:08', '2020-07-24 12:14:08'),
	('da7e3a058b642c1891da11adfbe6fbd11e5bab96478d7eaab0a633577e8bf5d06a39c2ce8ce0610d', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-09-16 16:28:48', '2020-09-16 16:28:48', '2021-09-16 16:28:48'),
	('dc37501d628e1fe32a12c2ae951bc29e17eddf38af486e45fdcbec5337bbed1c874eb557aa5f142b', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-06-11 13:11:43', '2020-06-11 13:11:43', '2021-06-11 12:11:43'),
	('e24cb65c62a232e62d978343ef1ce401d7bf031b0c05e3c4eaa7cc6a276079fdd3c3605b8c3e0c6f', 2, 3, 'Laravel_VueJS Personal Access Client', '["create-user","read-users","update-user","delete-user"]', 0, '2020-06-11 09:58:46', '2020-06-11 09:58:46', '2021-06-11 08:58:46'),
	('e35e738d7946f02c832f8fdb6828244effadc50bb9b4c73b5bc99a2e8263c4eb52c1e326e3b31f09', 2, 10, 'Personal Access Client1', '["create-user","read-users","update-user","delete-user"]', 0, '2020-06-11 13:19:30', '2020-06-11 13:19:30', '2021-06-11 12:19:30'),
	('ef068f87a045327c849d659145ed67a30da61c97e972afd91fab72d4634af1fef39bb5d9629a909a', 1, 10, 'Solutech', '["create-supplier","read-suppliers","update-supplier","delete-supplier"]', 0, '2021-03-22 14:42:38', '2021-03-22 14:42:38', '2022-03-22 14:42:38'),
	('f885c8639396bf0f1759787ab0aa2e396ce27f062de619a2fd45fd3575e85a58a6b0cde37eb8027b', 1, 10, 'Solutech', '["create-supplier","read-suppliers","update-supplier","delete-supplier"]', 0, '2021-03-22 14:56:16', '2021-03-22 14:56:16', '2022-03-22 14:56:16'),
	('ff40b21310897160a3edcfd23f8c1e247154b024a20f56f9d40a33748d40f59688ffec08ad785008', 2, 10, 'API Portal', '["create-user","read-users","update-user","delete-user"]', 0, '2020-06-30 22:37:56', '2020-06-30 22:37:56', '2021-06-30 21:37:56');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;

-- Dumping structure for table solutech_store.oauth_auth_codes
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `client_id` bigint unsigned NOT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table solutech_store.oauth_auth_codes: ~3 rows (approximately)
DELETE FROM `oauth_auth_codes`;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
INSERT INTO `oauth_auth_codes` (`id`, `user_id`, `client_id`, `scopes`, `revoked`, `expires_at`) VALUES
	('07bcde73fa8526ce61a8a66a7cc4dae129ba9bbacc2b1954c63d7f8ad8fee595c4e13f2f4afcca75', 2, 12, '[]', 0, '2020-06-11 12:58:08'),
	('68e1d5cc8dc3e28feca3b9b7f4b80d179c87cd6cbd3ac4bd6f50220c4df42de70657f012ba028ff4', 2, 12, '[]', 0, '2020-06-11 12:57:57'),
	('e1c0271f977070b354df45d553f83f8d5876f8b26ad907c39f8d782e3d93f08872656b07e0db351b', 2, 12, '[]', 1, '2020-06-11 12:58:46');
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;

-- Dumping structure for table solutech_store.oauth_clients
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `first_party` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table solutech_store.oauth_clients: ~13 rows (approximately)
DELETE FROM `oauth_clients`;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `first_party`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'Laravel_VueJS Personal Access Client', '9tIjFxlbI8L9bVeJJOi1BihcuKxwB5kRR47pOWE3', 'http://localhost', 1, 0, 0, 1, '2020-05-05 14:35:58', '2020-05-05 14:35:58'),
	(2, NULL, 'Laravel_VueJS Password Grant Client', 'bsQygcbtUvUsSxwIYQEk3KiFUTTiBRykjFd1j30b', 'http://localhost', 0, 1, 0, 1, '2020-05-05 14:35:59', '2020-05-05 14:35:59'),
	(3, NULL, 'Personal Access Client1', 'jYZbzV3uatSy79wKAvq33CILoLxJ78HRQ3B6c6br', 'http://localhost', 1, 0, 0, 1, '2020-05-27 18:36:42', '2020-05-27 18:36:42'),
	(4, NULL, 'Password Access Client1', 'gcrgpP7lNTx4dO4s01NSUQAupDhkGef4cKZm0erh', 'http://localhost', 0, 1, 0, 1, '2020-05-28 13:31:00', '2020-05-28 13:31:00'),
	(5, 2, 'SLAMS Software', 'rYel6218ZRmXdNAAZWb0SttQRuuVv9c32xEfERui', 'http://localhost:91/api_consumer/callback', 0, 0, 0, 1, '2020-06-01 19:00:42', '2020-06-01 19:00:42'),
	(6, 2, 'GL', 'kqOaXG9CaXbStd0qkoqkZIRR6YgknLqXmiamLC4d', 'http://localhost:91/api_consumer/callback', 0, 0, 0, 1, '2020-06-02 12:45:40', '2020-06-02 12:45:40'),
	(7, 2, 'GB', 'WnzWpG5jOipYHbbCoqR510HOFGPYH0oJRMHiWTiq', 'http://localhost:91/api_consumer/callbackImplicitGrant', 0, 0, 0, 0, '2020-06-02 23:26:54', '2020-06-02 23:26:54'),
	(8, NULL, 'Client Credentials1', 'aNd66Q5jiFttJe2sHljIL7HXBcAUjKrwC2kgTBVu', '', 0, 0, 0, 1, '2020-06-03 21:20:28', '2020-06-03 21:20:28'),
	(9, 2, 'AuthCode with PKCE1', NULL, 'http://localhost:91/api_consumer/callbackPKCE', 0, 0, 0, 1, '2020-06-03 22:33:06', '2020-06-03 22:33:06'),
	(10, NULL, 'API Portal', 'qvOp4k8cES7olU8SpUaiYBY51nXRTqLXT2CwH2ys', 'http://localhost', 1, 0, 0, 1, '2020-06-11 11:54:30', '2020-06-11 11:54:30'),
	(11, NULL, 'Laravel_VueJS Password Grant Client', 'oqrIpzz6nL42WpGIEomk584CXXmvRF630XT0dCiM', 'http://localhost', 0, 1, 0, 1, '2020-06-11 13:25:01', '2020-06-11 13:25:01'),
	(12, 2, 'Demo', 'MhBYAZaBlQ5ht0lF8fLBUyez5i2vGXDzJ0WgfsfA', 'http://localhost:91/api_consumer/callback', 0, 0, 0, 1, '2020-06-11 13:44:29', '2020-06-11 13:44:29'),
	(13, 2, 'Test', 'ebrCUeoTB9JjPlE0yYlJa3Hl0ijGxl5BWeX3nFAL', 'http://localhost:91/api_consumer/callbackImplicitGrant', 0, 0, 0, 1, '2020-07-01 11:31:32', '2020-07-01 18:46:05');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;

-- Dumping structure for table solutech_store.oauth_personal_access_clients
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table solutech_store.oauth_personal_access_clients: ~3 rows (approximately)
DELETE FROM `oauth_personal_access_clients`;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
	(1, 1, '2020-05-05 14:35:58', '2020-05-05 14:35:58'),
	(2, 3, '2020-05-27 18:36:43', '2020-05-27 18:36:43'),
	(3, 10, '2020-06-11 11:54:30', '2020-06-11 11:54:30');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;

-- Dumping structure for table solutech_store.oauth_refresh_tokens
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table solutech_store.oauth_refresh_tokens: ~6 rows (approximately)
DELETE FROM `oauth_refresh_tokens`;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
INSERT INTO `oauth_refresh_tokens` (`id`, `access_token_id`, `revoked`, `expires_at`) VALUES
	('04fc4ff064e04b7205a1186349405e28caed586fbfbb7bff12f0a9340b497d06c8f3eb6e2bdf616c', 'c4bdf675a148c04ee0e81772f8b53862f0596e242ab1facc39e7740571f4214d47cc945e0f97d819', 0, '2020-08-08 10:07:11'),
	('34be4cc334e08d4ca4567d61dbbc4f3002496d7d76e57b01d2b7d80a1c1f91d15c7af71bd733e67c', 'a90ec55cbd808f69742af59b5b8d5d4e8f8846698980c59c877aea9fc551a143079b147e1d2b405f', 0, '2020-07-08 22:24:12'),
	('3921c8cafd3f67f9d56759fbe418fda36903aba8b36785890c8f0b30c953533056346f69c6e953b7', 'd7be63c62a3041f4e6fe48fe07dca61d4c9eb4671b094302fe1cb339bb7ce2afe873da7fd550b990', 0, '2020-07-11 11:01:09'),
	('9492e66644fb3be204da80c49475be6a8a1d0aa53ce6215c5efcfb944825576faa567b48373e3ffa', '1c8cfc43aa0e39e2933418770564765af21fca48b2e0394ecc16dad5aae2db9c49928863ab61e061', 0, '2020-08-08 11:59:54'),
	('b22fd4ef2fa5ba804f4b5c1dbc25c887127d592891d3230f5d0463470b391283a1b7a30568e4915c', '838ad72d295e5b2a3587cf5e70b2ce3ede3ef838c9008fc6267721c903d998b5015065676cec5217', 0, '2020-07-11 12:48:48'),
	('df504a4312db689bcc0f2067c3be66e4a05b8312b18192731861a3bb8eda9a08342f70f89ab20b17', '663019be138b903fa9b45f412f49f42310ba14d21e2ff0f130ecb577bbf5aee00eff70a23893b27a', 0, '2020-07-11 12:29:43');
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;

-- Dumping structure for table solutech_store.orders
DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_number` varchar(45) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table solutech_store.orders: ~37 rows (approximately)
DELETE FROM `orders`;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`id`, `order_number`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(4, '20271', '2021-03-21 20:03:14', '2021-03-21 20:03:14', NULL),
	(40, '697940', '2021-03-22 13:12:22', '2021-03-22 13:12:22', NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- Dumping structure for table solutech_store.order_details
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE IF NOT EXISTS `order_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_order_details_orders` (`order_id`),
  KEY `FK_order_details_products` (`product_id`),
  CONSTRAINT `FK_order_details_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_order_details_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table solutech_store.order_details: ~3 rows (approximately)
DELETE FROM `order_details`;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(3, 4, 2, '2021-03-22 15:33:56', NULL, NULL),
	(4, 40, 2, '2021-03-22 16:18:30', NULL, NULL),
	(5, 40, 1, '2021-03-22 16:18:30', NULL, NULL);
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;

-- Dumping structure for table solutech_store.password_resets
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table solutech_store.password_resets: ~0 rows (approximately)
DELETE FROM `password_resets`;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Dumping structure for table solutech_store.products
DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `description` varchar(45) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `quantity` varchar(45) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table solutech_store.products: ~2 rows (approximately)
DELETE FROM `products`;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`, `name`, `description`, `quantity`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Dell', 'Dell Laptops', '20', '2021-03-21 17:46:40', '2021-03-21 17:48:40', NULL),
	(2, 'HP', 'HP Laptops', '30', '2021-03-21 19:30:20', '2021-03-21 19:30:20', NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

-- Dumping structure for table solutech_store.suppliers
DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE IF NOT EXISTS `suppliers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table solutech_store.suppliers: ~2 rows (approximately)
DELETE FROM `suppliers`;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Solutech Solutions', '2021-03-21 17:19:15', '2021-03-21 17:23:14', NULL),
	(2, 'Pedaca', '2021-03-21 17:43:11', '2021-03-21 20:45:55', NULL);
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;

-- Dumping structure for table solutech_store.supplier_products
DROP TABLE IF EXISTS `supplier_products`;
CREATE TABLE IF NOT EXISTS `supplier_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `supplier_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `supplier_id` (`supplier_id`,`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table solutech_store.supplier_products: ~3 rows (approximately)
DELETE FROM `supplier_products`;
/*!40000 ALTER TABLE `supplier_products` DISABLE KEYS */;
INSERT INTO `supplier_products` (`id`, `supplier_id`, `product_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 2, 1, '2021-03-21 19:28:49', NULL, NULL),
	(3, 1, 1, '2021-03-21 19:29:30', NULL, NULL),
	(4, 2, 2, '2021-03-21 19:30:30', NULL, NULL);
/*!40000 ALTER TABLE `supplier_products` ENABLE KEYS */;

-- Dumping structure for table solutech_store.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table solutech_store.users: ~3 rows (approximately)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `type`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'John Doe', 'johndoe@gmail.com', NULL, '$2y$10$Fwvi5f8Cz.EqmGknVlj4a.GbMywpSM3nViJB9IncUHast9E9JQMUS', '', NULL, '2021-03-22 13:49:04', '2021-03-22 16:50:10'),
	(2, 'Kipngetich Hillary Ronoh', 'kip@gmail.com', NULL, '$2y$10$Vnyg9TUlXfgO7hNVLFAh5u8KT9BFFzRl9PoBXRiLFTrwFAZU.Y26e', '', NULL, '2020-05-31 17:04:24', '2020-05-31 17:04:25'),
	(6, 'John Doe', 'johndoe@gmail.com1', NULL, '$2y$10$Fwvi5f8Cz.EqmGknVlj4a.GbMywpSM3nViJB9IncUHast9E9JQMUS', NULL, NULL, '2021-03-22 13:49:04', '2021-03-22 16:49:48');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
