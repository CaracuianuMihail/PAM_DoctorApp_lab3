# 🩺 Doctor Appointment App (PAM Lab 3)

Acest proiect a fost realizat în cadrul **Laboratorului 3** la disciplina **Programarea aplicațiilor mobile (PAM)**, având ca scop dezvoltarea unei aplicații Flutter care permite utilizatorilor să vizualizeze medici specialiști, detalii despre aceștia și să efectueze programări.

---

## 📱 Descriere generală

Aplicația oferă o interfață modernă și intuitivă pentru gestionarea consultațiilor medicale.  
Utilizatorii pot:
- Vizualiza o listă de **specialități medicale** (Cardiolog, Dentist etc.);
- Consulta o listă de **medici disponibili** pentru fiecare specialitate;
- Accesa detalii despre un medic (nume, spital, locație completă, imagine);
- Alege un **interval orar (slot)** pentru programare;
- Realiza o **rezervare (book)** direct din ecranul doctorului.

---

## 🧠 Funcționalități cheie

✅ Ecran principal (`HomeScreen`):
- Afișează informațiile utilizatorului;
- Prezintă acțiuni rapide și lista specialităților;
- Navighează spre ecranul detaliilor doctorului la selectarea specialității "Cardiologist".

✅ Ecran detalii (`DoctorDetailsScreen`):
- Afișează informațiile complete despre doctor;
- Listează locațiile și adresele din fișierul `v5.json`;
- Permite selecția unui **slot disponibil** și efectuarea unei rezervări.

✅ Persistență locală (prin JSON local în `assets/v5.json`).

✅ Navigare între ecrane folosind **GetX** (`GetMaterialApp`, `Get.toNamed()`).

---

## 🛠️ Tehnologii folosite

- **Flutter** 3.x
- **Dart** SDK
- **GetX** (pentru managementul stării și rutare)
- **Google Fonts**
- **Material Design**
- **JSON Assets** pentru datele doctorilor și specialităților

---

## 🧩 Structura proiectului

lib/
├── controllers/
│ ├── data_controller.dart
│ └── doctor_details_controller.dart
│
├── models/
│ └── (viitoare modele de date)
│
├── screens/
│ ├── home_screen.dart
│ └── doctor_details_screen.dart
│
├── theme/
│ └── theme.dart
│
└── main.dart
assets/
└── v5.json

---

## 🚀 Instalare și rulare

1️⃣ Clonează repository-ul:
```bash
git clone https://github.com/CaracuianuMihail/PAM_DoctorApp_lab3.git

2️⃣ Intră în directorul proiectului:
cd PAM_DoctorApp_lab3

3️⃣ Instalează dependențele:
flutter pub get

4️⃣ Rulează aplicația:
flutter run

## 🧑‍💻 Autor

Caracuianu Mihail
Facultatea de Calculatoare, Informatică și Microelectronică
Universitatea Tehnică a Moldovei (UTM)

📅 Laborator 3 — Programarea Aplicațiilor Mobile
📘 Tema: Aplicație pentru gestionarea consultațiilor medicale (Doctor Appointment App)
