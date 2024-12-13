-- Taula de pacients
CREATE TABLE Pacients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    edat INT NOT NULL,
    genere ENUM('Home', 'Dona', 'Altres') NOT NULL,
    diagnostics TEXT,
    medicacio_actual TEXT,
    limitacions TEXT,
    voluntats TEXT,
    data_creacio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Taula de problemes aguts
CREATE TABLE Problemes_Aguts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pacient_id INT NOT NULL,
    simptomes TEXT NOT NULL,
    gravetat ENUM('Lleu', 'Moderada', 'Greu') NOT NULL,
    data_aparicio TIMESTAMP NOT NULL,
    tractament_aplicat TEXT,
    resultat TEXT,
    FOREIGN KEY (pacient_id) REFERENCES Pacients(id)
);

-- Taula de suggeriments terapèutics
CREATE TABLE Suggeriments_Terapèutics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    problema_id INT NOT NULL,
    accions_recomanades TEXT NOT NULL,
    accions_a_evitar TEXT,
    FOREIGN KEY (problema_id) REFERENCES Problemes_Aguts(id)
);

-- Taula d'equips mèdics
CREATE TABLE Equips_Mèdics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    especialitat VARCHAR(100),
    contacte VARCHAR(100)
);

-- Taula de registres històrics
CREATE TABLE Historic (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pacient_id INT NOT NULL,
    problema_id INT NOT NULL,
    data_registre TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pacient_id) REFERENCES Pacients(id),
    FOREIGN KEY (problema_id) REFERENCES Problemes_Aguts(id)
);
