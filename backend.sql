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
CREATE TABLE Malaltia (
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
    malaltia_id INT NOT NULL,
    accions_recomanades TEXT NOT NULL,
    accions_a_evitar TEXT,
    FOREIGN KEY (malaltia_id) REFERENCES Malaltia(id)
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
    malaltia_id INT NOT NULL,
    data_registre TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pacient_id) REFERENCES Pacients(id),
    FOREIGN KEY (malaltia_id) REFERENCES Malaltia(id)
);

