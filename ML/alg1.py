import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OneHotEncoder
from sklearn.metrics import classification_report

# Exemple de dades (substitueix amb les teves dades reals)
# Cada fila correspon a un cas clínic: [historial, símptomes, malaltia, edat, sexe, medicació, medicació prohibida]
data = [
    [3, "dispnea severa", "fibrosi pulmonar", 70, "Home", "corticoides", "AINES", 1],  # Atenció immediata
    [1, "febre >38", "hipertensió arterial", 50, "Dona", "anticoagulants", "heparina", 0],  # Pot esperar
    [5, "dolor toràcic", "fibrosi pulmonar", 65, "Home", "oxigen", "benzodiazepines", 1],  # Atenció immediata
    [0, "cansament lleu", "diabetis", 40, "Dona", "insulina", "n/a", 0],  # Pot esperar
]

# Convertir dades en DataFrame
columns = ["historial", "simptomes", "malaltia", "edat", "sexe", "medicacio_actual", "medicacio_prohibida", "etiqueta"]
df = pd.DataFrame(data, columns=columns)

# Separar X (dades d'entrada) i y (etiquetes)
X = df.drop("etiqueta", axis=1)
y = df["etiqueta"]

# --- PREPROCESSAMENT DE DADES ---
# 1. One-Hot Encoding per a columnes categòriques (simptomes, malaltia, sexe, medicació...)
categorical_features = ["simptomes", "malaltia", "sexe", "medicacio_actual", "medicacio_prohibida"]
encoder = OneHotEncoder(sparse=False, handle_unknown="ignore")
X_encoded = encoder.fit_transform(X[categorical_features])

# 2. Afegir columnes numèriques (historial, edat)
X_numeric = X[["historial", "edat"]].to_numpy()

# Combinar columnes numèriques i categòriques processades
import numpy as np
X_processed = np.hstack((X_numeric, X_encoded))

# --- ENTRENAMENT DEL MODEL ---
# Dividir dades en entrenament i test
X_train, X_test, y_train, y_test = train_test_split(X_processed, y, test_size=0.3, random_state=42)

# Crear el model Random Forest
model = RandomForestClassifier(random_state=42)
model.fit(X_train, y_train)

# --- VALIDACIÓ ---
# Predir etiquetes per al conjunt de test
predictions = model.predict(X_test)

# Mostrar un informe de classificació
print(classification_report(y_test, predictions))
