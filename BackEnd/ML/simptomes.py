import mysql.connector

# Funció per a la connexió a la base de dades
def connect_to_db():
    try:
        # Conectar-se a la base de dades
        conn = mysql.connector.connect(
            host="localhost",            # Adapta-ho amb la teva configuració (per exemple, localhost o IP del servidor)
            user="root",                 # El teu usuari de la base de dades
            password="password",         # La teva contrasenya
            database="nom_de_la_base_dades"  # El nom de la base de dades on tens les taules
        )
        return conn
    except mysql.connector.Error as err:
        print(f"Error de connexió: {err}")
        return None

# Funció per consultar els símptomes d'una malaltia per l'ID
def consultar_simptomes_per_malaltia(malaltia_id):
    # Connexió a la base de dades
    conn = connect_to_db()
    
    if conn is None:
        return "No s'ha pogut establir connexió amb la base de dades."
    
    try:
        # Crear un cursor per executar la consulta
        cursor = conn.cursor()

        # Cridar la funció ConsultarSimptomesPerMalaltia
        cursor.callproc('ConsultarSimptomesPerMalaltia', [malaltia_id])

        # Recollir els resultats de la funció
        for result in cursor.stored_results():
            simptomes = result.fetchall()
        
        # Tancar la connexió
        conn.close()
        
        # Retornar els símptomes obtinguts
        return simptomes
    except mysql.connector.Error as err:
        print(f"Error en l'execució de la consulta: {err}")
        conn.close()
        return None

# Exemple d'ús
malaltia_id = 1  # Exemple d'ID de malaltia
simptomes = consultar_simptomes_per_malaltia(malaltia_id)

if simptomes:
    for simptoma in simptomes:
        print(simptoma)
