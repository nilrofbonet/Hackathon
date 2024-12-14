from flask import Flask, render_template
import sqlite3

app = Flask(__name__)

# Ruta principal que mostrará la página de usuario
@app.route('/')
def index():
    # Conectar a la base de datos SQLite (ruta absoluta si es necesario)
    conn = sqlite3.connect('BackEnd/SQL/hackaton.db')  # Ruta a la base de datos
    conn.row_factory = sqlite3.Row  # Esto hace que los resultados se devuelvan como diccionarios
    cursor = conn.cursor()

    # Obtener los datos del paciente
    cursor.execute("SELECT * FROM Pacients WHERE id = 1")  # Asumiendo que el paciente tiene id = 1
    pacient = cursor.fetchone()  # Obtener un solo registro del paciente

    # Cerrar la conexión a la base de datos
    conn.close()

    # Renderizar el HTML y pasar los datos del paciente
    return render_template('FrontEnd/Src/HTML/usuari.html', pacient=pacient)

if __name__ == '__main__':
    app.run(debug=True)
