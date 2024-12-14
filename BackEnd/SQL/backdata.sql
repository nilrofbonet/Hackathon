-- Taula de pacients
CREATE TABLE Pacients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    edat INT NOT NULL,
    genere ENUM('Home', 'Dona', 'Altres') NOT NULL,
    telefon VARCHAR(15),
    diagnostics TEXT,
    medicacio_actual TEXT,
    limitacions TEXT,
    voluntats TEXT,
    data_creacio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    qr_code VARCHAR(255) UNIQUE NOT NULL
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

-- Taula de simptomes
CREATE TABLE Simptomes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    malaltia_id INT NOT NULL,
    simptoma TEXT NOT NULL,
    FOREIGN KEY (malaltia_id) REFERENCES Malaltia(id)
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

-- Funció de consulta per la taula Pacients segons el QR
DELIMITER //
CREATE PROCEDURE ConsultarPacientPerQR(IN qr_input VARCHAR(255))
BEGIN
    SELECT * FROM Pacients WHERE qr_code = qr_input;
END //
DELIMITER ;

-- Funció de consulta per la taula Malaltia segons el pacient
DELIMITER //
CREATE PROCEDURE ConsultarMalaltiaPerPacient(IN qr_input VARCHAR(255))
BEGIN
    SELECT m.* 
    FROM Malaltia m
    JOIN Pacients p ON m.pacient_id = p.id
    WHERE p.qr_code = qr_input;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ConsultarSimptomesPerMalaltia(IN malaltia_id_input INT)
BEGIN
    SELECT simptoma
    FROM Simptomes
    WHERE malaltia_id = malaltia_id_input;
END //
DELIMITER ;


-- Funció de consulta per la taula Suggeriments_Terapèutics segons el pacient
DELIMITER //
CREATE PROCEDURE ConsultarSuggerimentsPerPacient(IN qr_input VARCHAR(255))
BEGIN
    SELECT st.* 
    FROM Suggeriments_Terapèutics st
    JOIN Malaltia m ON st.malaltia_id = m.id
    JOIN Pacients p ON m.pacient_id = p.id
    WHERE p.qr_code = qr_input;
END //
DELIMITER ;

-- Funció de consulta per la taula Equips_Mèdics
DELIMITER //
CREATE PROCEDURE ConsultarEquipsMèdics()
BEGIN
    SELECT * FROM Equips_Mèdics;
END //
DELIMITER ;

-- Funció de consulta per la taula Historic segons el pacient
DELIMITER //
CREATE PROCEDURE ConsultarHistoricPerPacient(IN qr_input VARCHAR(255))
BEGIN
    SELECT h.* 
    FROM Historic h
    JOIN Pacients p ON h.pacient_id = p.id
    WHERE p.qr_code = qr_input;
END //
DELIMITER ;

-- Funció per inserir dades a la taula Pacients
DELIMITER //
CREATE PROCEDURE AfegirPacient(IN nom_input VARCHAR(100), IN edat_input INT, IN genere_input ENUM('Home', 'Dona', 'Altres'), IN telefon_input VARCHAR(15), IN diagnostics_input TEXT, IN medicacio_input TEXT, IN limitacions_input TEXT, IN voluntats_input TEXT, IN qr_code_input VARCHAR(255))
BEGIN
    INSERT INTO Pacients (nom, edat, genere, telefon, diagnostics, medicacio_actual, limitacions, voluntats, qr_code)
    VALUES (nom_input, edat_input, genere_input, telefon_input, diagnostics_input, medicacio_input, limitacions_input, voluntats_input, qr_code_input);
END //
DELIMITER ;

-- Funció per inserir dades a la taula Malaltia
DELIMITER //
CREATE PROCEDURE AfegirMalaltia(IN pacient_id_input INT, IN simptomes_input TEXT, IN gravetat_input ENUM('Lleu', 'Moderada', 'Greu'), IN data_aparicio_input TIMESTAMP, IN tractament_input TEXT, IN resultat_input TEXT)
BEGIN
    INSERT INTO Malaltia (pacient_id, simptomes, gravetat, data_aparicio, tractament_aplicat, resultat)
    VALUES (pacient_id_input, simptomes_input, gravetat_input, data_aparicio_input, tractament_input, resultat_input);
END //
DELIMITER ;

-- Funció per inserir un nou simptoma
DELIMITER //
CREATE PROCEDURE AfegirSimptoma(IN malaltia_id_input INT, IN simptoma_input TEXT)
BEGIN
    INSERT INTO Simptomes (malaltia_id, simptoma)
    VALUES (malaltia_id_input, simptoma_input);
END //
DELIMITER ;

-- Funció per editar un simptoma existent
DELIMITER //
CREATE PROCEDURE EditarSimptoma(IN id_input INT, IN simptoma_input TEXT)
BEGIN
    UPDATE Simptomes
    SET simptoma = simptoma_input
    WHERE id = id_input;
END //
DELIMITER ;


-- Funció per inserir dades a la taula Suggeriments_Terapèutics
DELIMITER //
CREATE PROCEDURE AfegirSuggeriment(IN malaltia_id_input INT, IN accions_recomanades_input TEXT, IN accions_evitar_input TEXT)
BEGIN
    INSERT INTO Suggeriments_Terapèutics (malaltia_id, accions_recomanades, accions_a_evitar)
    VALUES (malaltia_id_input, accions_recomanades_input, accions_evitar_input);
END //
DELIMITER ;

-- Funció per inserir dades a la taula Equips_Mèdics
DELIMITER //
CREATE PROCEDURE AfegirEquipMedic(IN nom_input VARCHAR(100), IN especialitat_input VARCHAR(100), IN contacte_input VARCHAR(100))
BEGIN
    INSERT INTO Equips_Mèdics (nom, especialitat, contacte)
    VALUES (nom_input, especialitat_input, contacte_input);
END //
DELIMITER ;

-- Funció per inserir dades a la taula Historic
DELIMITER //
CREATE PROCEDURE AfegirHistoric(IN pacient_id_input INT, IN malaltia_id_input INT)
BEGIN
    INSERT INTO Historic (pacient_id, malaltia_id)
    VALUES (pacient_id_input, malaltia_id_input);
END //
DELIMITER ;

-- Funció per editar dades a la taula Pacients
DELIMITER //
CREATE PROCEDURE EditarPacient(IN id_input INT, IN nom_input VARCHAR(100), IN edat_input INT, IN genere_input ENUM('Home', 'Dona', 'Altres'), IN telefon_input VARCHAR(15), IN diagnostics_input TEXT, IN medicacio_input TEXT, IN limitacions_input TEXT, IN voluntats_input TEXT)
BEGIN
    UPDATE Pacients
    SET nom = nom_input, edat = edat_input, genere = genere_input, telefon = telefon_input, diagnostics = diagnostics_input, medicacio_actual = medicacio_input, limitacions = limitacions_input, voluntats = voluntats_input
    WHERE id = id_input;
END //
DELIMITER ;

-- Funció per editar dades a la taula Malaltia
DELIMITER //
CREATE PROCEDURE EditarMalaltia(IN id_input INT, IN simptomes_input TEXT, IN gravetat_input ENUM('Lleu', 'Moderada', 'Greu'), IN data_aparicio_input TIMESTAMP, IN tractament_input TEXT, IN resultat_input TEXT)
BEGIN
    UPDATE Malaltia
    SET simptomes = simptomes_input, gravetat = gravetat_input, data_aparicio = data_aparicio_input, tractament_aplicat = tractament_input, resultat = resultat_input
    WHERE id = id_input;
END //
DELIMITER ;

-- Funció per editar dades a la taula Suggeriments_Terapèutics
DELIMITER //
CREATE PROCEDURE EditarSuggeriment(IN id_input INT, IN accions_recomanades_input TEXT, IN accions_evitar_input TEXT)
BEGIN
    UPDATE Suggeriments_Terapèutics
    SET accions_recomanades = accions_recomanades_input, accions_a_evitar = accions_evitar_input
    WHERE id = id_input;
END //
DELIMITER ;

-- Funció per editar dades a la taula Equips_Mèdics
DELIMITER //
CREATE PROCEDURE EditarEquipMedic(IN id_input INT, IN nom_input VARCHAR(100), IN especialitat_input VARCHAR(100), IN contacte_input VARCHAR(100))
BEGIN
    UPDATE Equips_Mèdics
    SET nom = nom_input, especialitat = especialitat_input, contacte = contacte_input
    WHERE id = id_input;
END //
DELIMITER ;

-- Funció per editar dades a la taula Historic
DELIMITER //
CREATE PROCEDURE EditarHistoric(IN id_input INT, IN pacient_id_input INT, IN malaltia_id_input INT)
BEGIN
    UPDATE Historic
    SET pacient_id = pacient_id_input, malaltia_id = malaltia_id_input
    WHERE id = id_input;
END //
DELIMITER ;
