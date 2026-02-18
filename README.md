# Battaglia Navale - App Android Flutter

Un gioco di Battaglia Navale multiplayer in tempo reale tramite Bluetooth LE per Android, con grafica hand-drawn su carta.

## 📱 Caratteristiche

- **Comunicazione Bluetooth LE**: Connessione P2P tra due dispositivi Android
- **3 Fasi di Gioco**:
  1. **Lobby**: Ricerca e connessione con l'avversario
  2. **Preparazione**: Configurazione griglia e posizionamento navi
  3. **Gameplay**: Battaglia in tempo reale con doppia griglia
- **Grafica Hand-drawn**: Interfaccia disegnata a mano su sfondo carta
- **Gesture Support**: Tocco per posizionare navi e sparare
- **Classico 10x10**: Preset classico (griglia 10x10, 5 navi)

## 🚀 Installazione e Setup

### Prerequisiti
- Flutter SDK (versione 3.0 o superiore)
- Android SDK e Android Studio
- Almeno 2 dispositivi Android con Bluetooth LE

### Compilazione

**Development (Debug)**
```bash
flutter pub get
flutter run
```

**Release (APK)**
```bash
flutter build apk --release
```

## 🎮 Come Giocare

### Fase 1: Collegamento
1. Avvia l'app su due dispositivi diversi
2. Premi **"Cerca Avversario"** per iniziare la scansione Bluetooth
3. Seleziona il dispositivo dell'avversario per connetterti

### Fase 2: Posizionamento Navi
1. Vedrai una griglia 10x10 con 5 navi da piazzare
2. Tocca una nave per selezionarla
3. Tieni premuto per ruotarla
4. Tocca la griglia per posizionarla

### Fase 3: Battaglia
- Schermata divisa: Griglia propria a sinistra, avversaria a destra
- Tocca la griglia dell'avversario per sparare
- Colpi segnalati: Colpito 🔴, Acqua ⚪, Affondato 💀

## 🏗️ Architettura

- **Models**: Board, Ship, GameConfig, GameState
- **Services**: BluetoothService (BLE), GameService (logica)
- **Controllers**: GameController (GetX state management)
- **Screens**: Lobby, Setup, ShipPlacement, Gameplay
- **Widgets**: BoardWidget, ShipPlacementWidget (custom painters)

## 📦 Dipendenze

- GetX: State management
- flutter_blue_plus: Bluetooth LE
- shared_preferences: Storage
- uuid: ID generation

Vedi [pubspec.yaml](pubspec.yaml) per la lista completa.

## 👨‍💻 Autore

Stefano Giombetti

**Buon divertimento! ⚓🎯**
