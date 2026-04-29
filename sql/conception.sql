DROP DATABASE IF EXISTS 'matiere';
CReATE DATABASE 'matiere' CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE 'matiere';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `note`;
DROP TABLE IF EXISTS `matiere_semestre`;
DROP TABLE IF EXISTS `matiere_option`;
DROP TABLE IF EXISTS `inscription`;
DROP TABLE IF EXISTS `semestre`;
DROP TABLE IF EXISTS `matiere`;
DROP TABLE IF EXISTS `option`;
DROP TABLE IF EXISTS `etudiant`;
DROP TABLE IF EXISTS `annee`;

CREATE TABLE `annee` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `libelle` VARCHAR(3) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_annee_libelle` (`libelle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `etudiant` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `etu` VARCHAR(20) NOT NULL,
    `nom` VARCHAR(20) NOT NULL,
    `prenom` VARCHAR(20) NOT NULL,
    `date_naissance` DATE NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_etudiant_etu` (`etu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `option` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `libelle` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_option_libelle` (`libelle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `matiere` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `libelle` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_matiere_libelle` (`libelle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `semestre` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `libelle` VARCHAR(20) NOT NULL,
    `idAnnee` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_semestre_libelle_annee` (`libelle`, `idAnnee`),
    KEY `idx_semestre_annee` (`idAnnee`),
    CONSTRAINT `fk_semestre_annee`
        FOREIGN KEY (`idAnnee`) REFERENCES `annee` (`id`)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `inscription` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `idEtudiant` INT UNSIGNED NOT NULL,
    `idSemestre` INT UNSIGNED NOT NULL,
    `dtInscription` DATE NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_inscription_etudiant_semestre` (`idEtudiant`, `idSemestre`),
    KEY `idx_inscription_semestre` (`idSemestre`),
    CONSTRAINT `fk_inscription_etudiant`
        FOREIGN KEY (`idEtudiant`) REFERENCES `etudiant` (`id`)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT `fk_inscription_semestre`
        FOREIGN KEY (`idSemestre`) REFERENCES `semestre` (`id`)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `matiere_option` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `idMatiere` INT UNSIGNED NOT NULL,
    `idOption` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_matiere_option` (`idMatiere`, `idOption`),
    KEY `idx_matiere_option_option` (`idOption`),
    CONSTRAINT `fk_matiere_option_matiere`
        FOREIGN KEY (`idMatiere`) REFERENCES `matiere` (`id`)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT `fk_matiere_option_option`
        FOREIGN KEY (`idOption`) REFERENCES `option` (`id`)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `matiere_semestre` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `coefficients` DECIMAL(6,0) NOT NULL,
    `idMatiere_option` INT UNSIGNED NOT NULL,
    `idSemestre` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_matiere_semestre` (`idMatiere_option`, `idSemestre`),
    KEY `idx_matiere_semestre_semestre` (`idSemestre`),
    CONSTRAINT `fk_matiere_semestre_matiere_option`
        FOREIGN KEY (`idMatiere_option`) REFERENCES `matiere_option` (`id`)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT `fk_matiere_semestre_semestre`
        FOREIGN KEY (`idSemestre`) REFERENCES `semestre` (`id`)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `note` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `idInscription` INT UNSIGNED NOT NULL,
    `idMatiere_semestre` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_note_inscription_matiere_semestre` (`idInscription`, `idMatiere_semestre`),
    KEY `idx_note_matiere_semestre` (`idMatiere_semestre`),
    CONSTRAINT `fk_note_inscription`
        FOREIGN KEY (`idInscription`) REFERENCES `inscription` (`id`)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT `fk_note_matiere_semestre`
        FOREIGN KEY (`idMatiere_semestre`) REFERENCES `matiere_semestre` (`id`)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
