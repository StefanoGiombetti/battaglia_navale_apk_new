# Battaglia Navale - Guida di Sviluppo

## 📋 Struttura Progetto Completata

### ✅ File Creati

#### 1. Configurazione Flutter (`pubspec.yaml`)
- Dipendenze core (GetX, flutter_blue_plus)
- Configurazione asset e font

#### 2. Modelli Dati (`lib/models/`)
- **board.dart**: Griglia 2D con celle, stati (empty, ship, hit, miss, sunk)
- **ship.dart**: Nave con orientamento (H/V) e posizione
- **game_config.dart**: Configurazione partita (dimensioni, navi)
- **game_state.dart**: Stato globale del gioco

#### 3. Servizi (`lib/services/`)
- **bluetooth_service.dart**: 
  - Wrapper flutter_blue_plus
  - Scan dispositivi, connessione, messaggi
  - Placeholder per implementazione GATT nativa
  
- **game_service.dart**:
  - Logica di posizionamento navi (validazione collisioni)
  - Registrazione colpi
  - Serializzazione messaggi (JSON)

#### 4. State Management (`lib/controllers/`)
- **game_controller.dart** (GetX):
  - Orchestrazione del flusso game
  - Binding tra UI e servizi
  - Listener Bluetooth e logica messaggi

#### 5. UI Screens (`lib/screens/`)
- **lobby_screen.dart**: Ricerca e connessione
- **setup_screen.dart**: Configurazione partita
- **ship_placement_screen.dart**: Posizionamento navi + rotazione
- **gameplay_screen.dart**: Doppia griglia (grigliaarella propria vs avversaria)

#### 6. UI Widgets (`lib/widgets/`)
- **board_widget.dart**: CustomPainter per disegno griglia
  - Effetti hand-drawn (colore carta, linee)
  - Visualizzazione stato celle (navi, colpi, acqua)
  
- **ship_placement_widget.dart**: Anteprima posizionamento nave

#### 7. Android Configuration
- **AndroidManifest.xml**: Permessi BT, location
- **build.gradle** (app): Configurazione compilazione
- **MainActivity.kt**: Activity Flutter
- **android/build.gradle**: Configurazione root Gradle

#### 8. Configurazione Progetto
- **main.dart**: Routing GetPages, tema app
- **analysis_options.yaml**: Lint rules Flutter
- **.gitignore**: File ignorati
- **README.md**: Documentazione completa

---

## 🔧 Prossimi Passi per Completamento

### Fase 1: Testing & Debugging (PROSSIMO)
1. **Compilare il progetto**
   ```bash
   cd /workspaces/battaglia_navale_apk_new
   flutter pub get
   flutter run -v
   ```

2. **Verificare imports e dipendenze**
   - Controllare che tutti gli import di pubspec.yaml siano corretti
   - Risolvere eventuali errori di build

### Fase 2: Implementazione Bluetooth Avanzata
1. **Configurare GATT Services Android**
   - Creare servizi BLE custom
   - Implementare caratteristiche per scambio messaggi
   - Aggiungere configurazione in `android/build.gradle`

2. **Migliorare BluetoothService**
   - Implementazione device discovery con filtri UUID
   - Gestione riconnessione automatica
   - Logging dettagliato

### Fase 3: Completare Logica Gioco
1. **Turni**
   - Implementare alternanza turni
   - Validare colpi (non sparare 2 volte stessa casella)
   - Controllare vittoria/sconfitta

2. **Sincronizzazione Stato**
   - Verificare entrambi i giocatori hanno stessi dati
   - Gestire stati "out of sync"

3. **Messaggistica**
   - Serializzazione completa stato gioco
   - Gestione problemi connessione

### Fase 4: UI Polish
1. **Grafica Hand-drawn**
   - Aggiungere texture carta (PNG sottile)
   - Effetti penna per disegno linee
   - Animazioni colpi (es. X animata per colpito)

2. **Responsività**
   - Adattare UI per diversi fattori di forma
   - Testare landscape/portrait

3. **Suono & Feedback**
   - Vibrazioni su colpi
   - Suoni per hit/miss/affondato
   - Notifiche turno

### Fase 5: Testing Completo
1. **Unit Tests** (`test/`)
   - Logica posizionamento navi
   - Validazione coordinate
   - Algoritmo colpi

2. **Integration Tests**
   - Flusso completo 2 dispositivi
   - Sincronizzazione stato
   - Disconnessione/riconnessione

3. **Device Testing**
   - Testare su veri dispositivi Android
   - Verificare permessi runtime (Android 6/12+)
   - Testare con molteplici coppie dispositivi

---

## 🚀 Come Avanzare

### Build Locale
```bash
cd /workspaces/battaglia_navale_apk_new

# Verificare sintassi
flutter analyze

# Formattare codice
flutter format .

# Compilare per debug
flutter run

# Compilare APK release
flutter build apk --release
```

### Deploy su Dispositivi
```bash
# Listare dispositivi connessi
flutter devices

# Lanciare su dispositivo specifico
flutter run -d <device-id>
```

### Debugging
```bash
# Log in tempo reale
flutter logs

# Debugging con DevTools
flutter pub global activate devtools
devtools
```

---

## 📝 Note Tecniche

### Architettura
```
Model ← → Service ← → Controller
  ↓                      ↓
                   → UI Screen
```

- **Model**: Immutable data, logica pura
- **Service**: Esterno (BT, API), logica isolata
- **Controller**: Orchestra flussi, reactive
- **Screen**: Consuma controller, stateless quando possibile

### Pattern Usati
1. **Reactive**: GetX observables per stato UI
2. **Factory**: Singleton pattern per servizi
3. **Custom Painter**: Hand-drawn rendering
4. **JSON Serialization**: Messaggi Bluetooth

### Permessi Android Required
- `BLUETOOTH`: Connessione dispositivi
- `BLUETOOTH_CONNECT`: Operazioni su dispositivi connessi
- `BLUETOOTH_SCAN`: Discovery dispositivi
- `ACCESS_FINE_LOCATION`: Richiesto per BLE scan (Android 6+)

---

## 🐛 Troubleshooting Comuni

| Problema | Soluzione |
|----------|-----------|
| `flutter: command not found` | Aggiungere Flutter al PATH |
| App non compila | `flutter clean && flutter pub get` |
| Bluetooth non funziona emulatore | Usare dispositivi reali |
| Permessi negati | Aggiungere richieste runtime in `MainActivity.kt` |
| Connessione BT lenta | Verificare distanza, abilitare BT su entrambi |

---

## 📚 Risorse Utili

- [Flutter Docs](https://flutter.dev/docs)
- [flutter_blue_plus](https://pub.dev/packages/flutter_blue_plus)
- [GetX Documentation](https://github.com/jonataslaw/getx)
- [Android Bluetooth Developer Guide](https://developer.android.com/guide/topics/connectivity/bluetooth)

---

**Last Updated:** Feb 18, 2026
**Status:** Scaffold Completo ✅ | Testing in Progress ⏳
