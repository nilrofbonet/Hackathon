<?php
// Include the database connection
include 'db_config.php';

// Example: Fetch the patient's data using a static patient ID
$patient_id = 1;  // Hardcoding a patient ID for now

// Query the database for patient information using the provided patient ID
$sql = "SELECT * FROM Pacients WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $patient_id);  // Use "i" because patient_id is an integer
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $patient = $result->fetch_assoc();  // Fetch the patient's data
} else {
    echo "Patient not found.";
    exit;
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QResp</title>
    <link rel="stylesheet" href="/FrontEnd/Src/Styles/usuari.css">
</head>
<body>
    <div class="finestra">
        <div class="cap">
            <div class="text">
                <?php echo htmlspecialchars($patient['nom']) . " (" . htmlspecialchars($patient['edat']) . ")"; ?>  
            </div>
            <div class="perfil">
                <a href="usuari.html">
                    <button class="usuari-btn">
                        <img src="/FrontEnd/img/login.png" alt="usuari" class="imgusuari">
                    </button>
                </a>
            </div>
        </div>
        <div class="linia-div"></div>
        <div class="titol">DADES PERSONALS</div>

        <div class="informacio">
            <div class="nom">
                Nom:
                <div class="introduir-nom">
                    <?php echo htmlspecialchars($patient['nom']); ?>
                </div>
            </div> 
            <div class="cognom">Cognoms:
                <div class="introduir-cognom">
                    <?php echo htmlspecialchars($patient['cognoms']); ?>
                </div>
            </div>
            <div class="naixament">Data de naixament:
                <div class="introduir-naixament">
                    <?php echo htmlspecialchars($patient['data_naixament']); ?>
                </div>
            </div>

            <div class="sexe">Sexe:
                <div class="introduir-sexe">
                    <?php echo htmlspecialchars($patient['genere']); ?>
                </div>
            </div>

            <div class="telefons">
                <div class="telefon-personal"> Telèfon personal:
                    <div class="introduir-telf-personal">
                        <?php echo htmlspecialchars($patient['telefon']); ?>
                    </div>
                </div>

                <div class="telefon-familiar">Telèfon d'un familiar:
                    <div class="introduir-telf-fam">
                        <?php echo htmlspecialchars($patient['telefon_familiar']); ?>
                    </div>
                </div>
            </div>
            <div class="metge-responsable">Metge responsable:
                <div class="introduir-metge">
                    
                <?php echo htmlspecialchars($patient['metge_responsable']); ?>
                </div>
            </div>
            <div class="hospital">Hospital de referència: 
                <div class="introduir-hospital">
                    <?php echo htmlspecialchars($patient['hospital']); ?>
                </div>
            </div>
            <div class="malaltia">
                <div class="nom-malaltia">Diagnòstic:
                    <div class="introduir-malaltia">
                        <?php echo htmlspecialchars($patient['diagnostics']); ?>
                    </div>
                </div>
                <div class="medicaments">Medicaments actuals: 
                    <div class="introduir-medicaments">
                        <?php echo htmlspecialchars($patient['medicacio_actual']); ?>
                    </div>
                </div>
                <div class="informacio-malaltia">Informació malaltia:
                    <div class="introduir-info">
                        <?php echo htmlspecialchars($patient['informacio_malaltia']); ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
