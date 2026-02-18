# 🎯 Battaglia Navale - Quick Start

## 1️⃣ Setup Iniziale (2-3 minuti)

### Installa dipendenze
```bash
cd /workspaces/battaglia_navale_apk_new
flutter pub get
```

### Verificare che non ci siano errori
```bash
flutter analyze
```

## 2️⃣ Lanciare l'app (Debug)

### Su dispositivo connesso
```bash
flutter run
```

### Su emulatore
```bash
# Creare emulatore se non esiste
flutter emulators --create --name pixel_3

# Lanciare emulatore
flutter emulators --launch pixel_3

# Compilare app
flutter run
```

## 3️⃣ Testare Battaglia Navale

### Fase 1: Connessione Bluetooth
1. **Dispositivo 1**: Premi "Cerca Avversario"
2. **Dispositivo 2**: Premi "Cerca Avversario"
3. Una volta trovati, seleziona l'altro dispositivo per connettere

### Fase 2: Posizionamento Navi
1. Tocca le navi nella lista in basso per selezionarle
2. Tieni premuto per ruotarle
3. Tocca la griglia 10x10 per posizionarle
4. Premi "Inizia il Gioco" quando pronto

### Fase 3: Battaglia!
- **Griglia Sinistra**: La tua griglia (vedi i colpi dell'avversario)
- **Griglia Destra**: Griglia avversaria (dove sparare)
- Tocca per sparare quando è il tuo turno

**Colpi:**
- 🔴 **Colpito**: Hai colpito una nave
- ⚪ **Acqua**: Casella vuota
- 💀 **Affondato**: Tutte le caselle della nave distrutte

**Vinci quando**: Distruggi tutte le navi dell'avversario!

---

## 📱 Note Importanti

### Per Bluetooth LE:
- ✅ Userequired su **2 dispositivi Android reali** (emulatore ha limitazioni BT)
- ✅ **Bluetooth deve essere abilitato** su entrambi
- ✅ **Localizzazione deve essere concessa** (richiesto per BLE scan)
- ✅ I dispositivi devono essere **a breve distanza** (< 100m)

### Per APK Release:
```bash
flutter build apk --release
```

---

## 🐛 Se qualcosa non funziona

### App non compila
```bash
flutter clean
flutter pub get
flutter run
```

### Bluetooth non funziona
1. Vai in Impostazioni → Bluetooth e abilita
2. Vai in Impostazioni → Autorizzazioni → Localizzazione e consenti
3. Riavvia l'app

### Su emulatore BT non funziona
👉 Userequired su dispositivi reali per testare Bluetooth

---

## 📂 Architettura App

```
Lobby Screen (ricerca Bluetooth)
    ↓
Setup Screen (configura griglia/navi)
    ↓
Ship Placement (posiziona le tue navi)
    ↓
Gameplay Screen (battaglia!)
```

Ogni screen comunica via **GetX Controller** che gestisce:
- Stato gioco (turni, fasi)
- Comunicazione Bluetooth
- Logica posizionamento/colpi

---

## 🎨 Stile Grafica

- ✏️ **Hand-drawn**: Sfondo carta, linee disegnate
- 🟫 **Colori**: Marrone (#8B7355), terra (#6B4226)
- 🎯 **Semplice**: Come su un foglio di carta

---

## 🚀 Pronto a iniziare?

1. Connetti 2 dispositivi Android
2. `flutter run` su entrambi
3. Cerca l'avversario via Bluetooth
4. Posiziona le navi
5. **Battaglia Navale!**

---

**Domande?** Vedi [README.md](README.md) per documentazione completa o [DEVELOPMENT.md](DEVELOPMENT.md) for l'architettura tecnica.

⚓ **Buon divertimento!** 🎯
