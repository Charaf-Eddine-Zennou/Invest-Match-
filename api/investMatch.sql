-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 04 jan. 2025 à 00:24
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `investmatch`
--

-- --------------------------------------------------------

--
-- Structure de la table `domains`
--

CREATE TABLE `domains` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `label` varchar(255) NOT NULL,
  `code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `domains`
--

INSERT INTO `domains` (`id`, `label`, `code`) VALUES
(1, 'Restauration et hôtellerie', 1),
(2, 'Commerce de détail et spécialisé', 2),
(3, 'Commerce de gros', 3),
(4, 'Beauté et bien-être', 4),
(5, 'Construction et bricolage', 5),
(6, 'Transport', 6),
(7, 'Loisirs', 7),
(8, 'Services administratifs et juridiques', 8),
(9, 'Technologie et informatique', 9),
(10, 'Santé et Pharmacie', 10);

-- --------------------------------------------------------

--
-- Structure de la table `domain_similarity`
--

CREATE TABLE `domain_similarity` (
  `domain_1_code` int(11) NOT NULL,
  `domain_2_code` int(11) NOT NULL,
  `similarity_value` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `domain_similarity`
--

INSERT INTO `domain_similarity` (`domain_1_code`, `domain_2_code`, `similarity_value`) VALUES
(1, 1, 1),
(1, 2, 0.6),
(1, 3, 0.4),
(1, 4, 0.5),
(1, 5, 0.2),
(1, 6, 0.3),
(1, 7, 0.6),
(1, 8, 0.3),
(1, 9, 0.5),
(1, 10, 0.4),
(2, 1, 0.6),
(2, 2, 1),
(2, 3, 0.7),
(2, 4, 0.4),
(2, 5, 0.5),
(2, 6, 0.5),
(2, 7, 0.5),
(2, 8, 0.3),
(2, 9, 0.5),
(2, 10, 0.7),
(3, 1, 0.4),
(3, 2, 0.7),
(3, 3, 1),
(3, 4, 0.2),
(3, 5, 0.5),
(3, 6, 0.3),
(3, 7, 0.3),
(3, 8, 0.3),
(3, 9, 0.2),
(3, 10, 0.4),
(4, 1, 0.5),
(4, 2, 0.4),
(4, 3, 0.2),
(4, 4, 1),
(4, 5, 0.2),
(4, 6, 0.3),
(4, 7, 0.5),
(4, 8, 0.3),
(4, 9, 0.2),
(4, 10, 0.7),
(5, 1, 0.2),
(5, 2, 0.5),
(5, 3, 0.5),
(5, 4, 0.2),
(5, 5, 1),
(5, 6, 0.6),
(5, 7, 0.2),
(5, 8, 0.4),
(5, 9, 0.3),
(5, 10, 0.2),
(6, 1, 0.3),
(6, 2, 0.5),
(6, 3, 0.3),
(6, 4, 0.3),
(6, 5, 0.6),
(6, 6, 1),
(6, 7, 0.2),
(6, 8, 0.4),
(6, 9, 0.2),
(6, 10, 0.2),
(7, 1, 0.6),
(7, 2, 0.5),
(7, 3, 0.3),
(7, 4, 0.5),
(7, 5, 0.2),
(7, 6, 0.2),
(7, 7, 1),
(7, 8, 0.2),
(7, 9, 0.3),
(7, 10, 0.3),
(8, 1, 0.3),
(8, 2, 0.3),
(8, 3, 0.3),
(8, 4, 0.3),
(8, 5, 0.4),
(8, 6, 0.4),
(8, 7, 0.2),
(8, 8, 1),
(8, 9, 0.4),
(8, 10, 0.4),
(9, 1, 0.3),
(9, 2, 0.5),
(9, 3, 0.2),
(9, 4, 0.2),
(9, 5, 0.3),
(9, 6, 0.2),
(9, 7, 0.3),
(9, 8, 0.4),
(9, 9, 1),
(9, 10, 0.3),
(10, 1, 0.4),
(10, 2, 0.7),
(10, 3, 0.4),
(10, 4, 0.7),
(10, 5, 0.2),
(10, 6, 0.2),
(10, 7, 0.3),
(10, 8, 0.4),
(10, 9, 0.3),
(10, 10, 1);

-- --------------------------------------------------------

--
-- Structure de la table `entreprise`
--

CREATE TABLE `entreprise` (
  `id` char(36) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `valeur` decimal(15,2) DEFAULT NULL,
  `nombre_employes` int(11) DEFAULT NULL,
  `secteur_activite` varchar(255) DEFAULT NULL,
  `statut_seed` varchar(50) DEFAULT NULL,
  `chiffre_affaires` decimal(15,2) DEFAULT NULL,
  `date_creation` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `size` int(11) NOT NULL,
  `valorisation` int(11) NOT NULL,
  `modeleEconomique` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `entreprise`
--

INSERT INTO `entreprise` (`id`, `nom`, `valeur`, `nombre_employes`, `secteur_activite`, `statut_seed`, `chiffre_affaires`, `date_creation`, `description`, `size`, `valorisation`, `modeleEconomique`) VALUES
('a73378b8-89b0-11ef-9b95-507b9d141001', 'Tech Innovators', 500000.00, 50, 'Technologie', 'Seed', 300000.00, '2015-06-15', 'Une startup innovante dans le secteur des technologies.', 50, 800000, ''),
('a7a60db5-89b0-11ef-9b95-507b9d141001', 'Green Solutions', 690000.00, 150, 'Énergies renouvelables', 'Pre-seed', 900000.00, '2010-03-22', 'Société spécialisée dans les solutions d\'énergies vertes et durables.', 100, 200000, ''),
('a7ab275a-89b0-11ef-9b95-507b9d141001', 'HealthTech Solutions', 2000000.00, 300, 'Santé', 'Serie B', 1500000.00, '2008-11-05', 'Leader dans les solutions technologiques pour le secteur de la santé.', 60, 500000, ''),
('e15e6737-89b1-11ef-9b95-507b9d141001', 'tr Innovators', 690000.00, 50, 'Technologie', 'Serie A', 690000.00, '2015-06-15', 'Une startup innovante dans le secteur des technologies.', 120, 700000, '');

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(11) NOT NULL,
  `timestamp` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `timestamp`, `name`) VALUES
(1, 1681234567890, 'AddPhoneToUsersTable1681234567890'),
(2, 1727642263360, 'InsertDomain1727642263360'),
(3, 1728048403463, 'SectorSimilarity1728048403463');

-- --------------------------------------------------------

--
-- Structure de la table `price`
--

CREATE TABLE `price` (
  `id` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `price_range`
--

CREATE TABLE `price_range` (
  `id` int(11) NOT NULL,
  `experience_level` enum('BEGINNER','INTERMEDIATE','ADVANCED') NOT NULL,
  `min_price` decimal(15,2) NOT NULL,
  `max_price` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `price_range`
--

INSERT INTO `price_range` (`id`, `experience_level`, `min_price`, `max_price`) VALUES
(1, 'BEGINNER', 5000.00, 150000.00),
(2, 'INTERMEDIATE', 50000.00, 500000.00),
(3, 'ADVANCED', 200000.00, 2000000.00);

-- --------------------------------------------------------

--
-- Structure de la table `seed`
--

CREATE TABLE `seed` (
  `id` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `numberPhone` varchar(100) NOT NULL,
  `adresse` varchar(100) NOT NULL,
  `email` varchar(320) NOT NULL,
  `password` varchar(100) NOT NULL,
  `passwordConfirme` varchar(100) NOT NULL,
  `is_active` tinyint(4) NOT NULL,
  `roles` text NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `updated_at` datetime(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `emailToken` varchar(255) DEFAULT NULL,
  `isVerifiedEmail` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
  
--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `name`, `numberPhone`, `adresse`, `email`, `password`, `passwordConfirme`, `is_active`, `roles`, `created_at`, `updated_at`, `emailToken`, `isVerifiedEmail`) VALUES
(1, 'khalid zennou', '0699981587', 'Douar akdim Taghzoute Tinghir', 'khalid1zennou@gmail.com', '$2b$10$FyRi5LzhvkC3/qei6pegReq37cfX/a6BdKirNQX5E6AohMXxvX1D.', '$2b$10$iqeDfKksSbs0ic/TtZeywO3PNt5R9FYahbZ9luABRkC2JKVZ.sb.K', 1, 'user', '2024-09-10 19:26:30.100572', '2024-09-10 19:26:30.100572', NULL, 0),
(2, 'test', '06666666666', 'test', 'test@test.com', '$2b$10$PZE1tIwABAhkb9aTD/vsA.ZRgQsMhhFFXuyLUUbJh3IHxiTi6yG.m', '$2b$10$ft2BK5qTACtUVFGNQgqh4uyI50H.t1I34LS.fPPkiYkMu4HSkeMbu', 1, 'user', '2024-09-10 19:49:21.397447', '2024-09-10 19:49:21.397447', NULL, 0);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `domains`
--
ALTER TABLE `domains`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `domain_similarity`
--
ALTER TABLE `domain_similarity`
  ADD PRIMARY KEY (`domain_1_code`,`domain_2_code`);

--
-- Index pour la table `entreprise`
--
ALTER TABLE `entreprise`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `price`
--
ALTER TABLE `price`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `price_range`
--
ALTER TABLE `price_range`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `seed`
--
ALTER TABLE `seed`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `domains`
--
ALTER TABLE `domains`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `price`
--
ALTER TABLE `price`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `price_range`
--
ALTER TABLE `price_range`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `seed`
--
ALTER TABLE `seed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
