-- gestione_film.attore definition

CREATE TABLE `attore` (
  `id_attore` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `anno_nascita` int(11) NOT NULL,
  `nazionalita` varchar(255) NOT NULL,
  PRIMARY KEY (`id_attore`)
);

-- gestione_film.film definition

CREATE TABLE `film` (
  `id_film` int(11) NOT NULL AUTO_INCREMENT,
  `titolo` varchar(255) NOT NULL,
  `anno_produzione` int(11) NOT NULL,
  `nazionalita` varchar(255) NOT NULL,
  `regista` varchar(255) NOT NULL,
  `genere` varchar(255) NOT NULL,
  `durata` int(11) NOT NULL,
  PRIMARY KEY (`id_film`)
);

-- gestione_film.attore_film definition

CREATE TABLE `attore_film` (
  `id_attore` int(11) NOT NULL,
  `id_film` int(11) NOT NULL,
  PRIMARY KEY (`id_attore`,`id_film`),
  KEY `id_film` (`id_film`),
  CONSTRAINT `1` FOREIGN KEY (`id_attore`) REFERENCES `attore` (`id_attore`),
  CONSTRAINT `2` FOREIGN KEY (`id_film`) REFERENCES `film` (`id_film`)
);

-- gestione_film.sala definition

CREATE TABLE `sala` (
  `id_sala` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `citta` varchar(255) NOT NULL,
  `posti` int(11) NOT NULL,
  PRIMARY KEY (`id_sala`)
);

-- gestione_film.proiezione definition

CREATE TABLE `proiezione` (
  `id_proiezione` int(11) NOT NULL AUTO_INCREMENT,
  `id_film` int(11) NOT NULL,
  `id_sala` int(11) NOT NULL,
  `incasso` decimal(10,0) NOT NULL,
  `data_proiezione` date NOT NULL,
  PRIMARY KEY (`id_proiezione`),
  KEY `id_film` (`id_film`),
  KEY `id_sala` (`id_sala`),
  CONSTRAINT `1` FOREIGN KEY (`id_film`) REFERENCES `film` (`id_film`),
  CONSTRAINT `2` FOREIGN KEY (`id_sala`) REFERENCES `sala` (`id_sala`)
);