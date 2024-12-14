-- Taula de pacients
CREATE TABLE Pacients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nom TEXT NOT NULL,
    edat INTEGER NOT NULL,
    genere TEXT CHECK(genere IN ('Home', 'Dona', 'Altres')) NOT NULL,
    telefon TEXT,
    diagnostics TEXT,
    medicacio_actual TEXT,
    limitacions TEXT,
    voluntats TEXT,
    data_creacio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    qr_code TEXT UNIQUE NOT NULL
);

-- Taula de problemes aguts
CREATE TABLE Malaltia (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pacient_id INTEGER NOT NULL,
    simptomes TEXT NOT NULL,
    gravetat TEXT CHECK(gravetat IN ('Lleu', 'Moderada', 'Greu')) NOT NULL,
    data_aparicio TIMESTAMP NOT NULL,
    tractament_aplicat TEXT,
    resultat TEXT,
    FOREIGN KEY (pacient_id) REFERENCES Pacients(id)
);

-- Taula de simptomes
CREATE TABLE Simptomes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    malaltia_id INTEGER NOT NULL,
    simptoma TEXT NOT NULL,
    FOREIGN KEY (malaltia_id) REFERENCES Malaltia(id)
);

-- Taula de suggeriments terapèutics
CREATE TABLE Suggeriments_Terapèutics (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    malaltia_id INTEGER NOT NULL,
    accions_recomanades TEXT NOT NULL,
    accions_a_evitar TEXT,
    FOREIGN KEY (malaltia_id) REFERENCES Malaltia(id)
);

-- Taula d'equips mèdics
CREATE TABLE Equips_Mèdics (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nom TEXT NOT NULL,
    especialitat TEXT,
    contacte TEXT
);

-- Taula de registres històrics
CREATE TABLE Historic (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pacient_id INTEGER NOT NULL,
    malaltia_id INTEGER NOT NULL,
    data_registre TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pacient_id) REFERENCES Pacients(id),
    FOREIGN KEY (malaltia_id) REFERENCES Malaltia(id)
);

-- Inserción del paciente automáticamente
INSERT INTO Pacients (nom, edat, genere, telefon, diagnostics, medicacio_actual, limitacions, voluntats, qr_code)
VALUES 
('Antoni Rof Suquet', 63, 'Home', '666777888', 'Hipertensió', 'Lisinopril', 'Cap', 'Desitja ser donant d\'òrgans', 'ANTONI63QR');
