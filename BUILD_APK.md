# 🔨 Come Generare l'APK - Battaglia Navale

## Prerequisiti
- **Flutter SDK** installato e nel PATH
- **Android SDK** con compileSdkVersion 34+
- **Java SDK** (opzionale, di solito in bundle con Android Studio)

## 📱 Comandi per Generare APK

### 1️⃣ APK Debug (Rapido, per Testing)
```bash
cd /workspaces/battaglia_navale_apk_new

# Installare dipendenze (prima volta)
flutter pub get

# Pulire build precedenti
flutter clean

# Generare APK debug
flutter build apk --debug
```

**Output**: `build/app/outputs/flutter-apk/app-debug.apk`

**Tempo**: ~2-5 minuti

**Usr**: Testing su dispositivi durante sviluppo

---

### 2️⃣ APK Release (Ottimizzato, per Distribuzione)
```bash
cd /workspaces/battaglia_navale_apk_new

flutter pub get
flutter clean

# Generare APK release
flutter build apk --release
```

**Output**: `build/app/outputs/flutter-apk/app-release.apk`

**Tempo**: ~5-10 minuti

**Uso**: Distribuzione e test finale

---

### 3️⃣ App Bundle (Per Google Play)
```bash
flutter build appbundle --release
```

**Output**: `build/app/outputs/bundle/release/app-release.aab`

---

## 🚀 Installare su Dispositivo Android

### Da File APK
```bash
# Elencare dispositivi connessi
flutter devices

# Installare APK su dispositivo
adb install build/app/outputs/flutter-apk/app-debug.apk

# Eseguire direttamente
flutter run --release
```

### Direttamente con Flutter
```bash
# Build + Install + Run (più semplice)
flutter run --release

# O per debug
flutter run
```

---

## 📋 Checklist Prima di Generare APK

- [ ] **pubspec.yaml** aggiornato con versione corretta
- [ ] **pubspec.lock** generato (`flutter pub get`)
- [ ] `flutter analyze` senza errori critici
- [ ] **AndroidManifest.xml** con permessi Bluetooth
- [ ] Dispositivi Android preparati (Bluetooth abilitato)

---

## ⚙️ Configurazione AndroidManifest.xml

✅ **Già configurato nel progetto** con:
```xml
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

---

## 🐛 Troubleshooting

### ❌ "Cannot find flutter"
```bash
# Aggiungere Flutter al PATH (su Linux/Mac)
export PATH="$PATH:/path/to/flutter/bin"

# Su Windows
set PATH=%PATH%;C:\path\to\flutter\bin
```

### ❌ "Unable to locate Android SDK"
```bash
flutter config --android-sdk /path/to/android-sdk
```

### ❌ "Gradle build failed"
```bash
flutter clean
flutter pub get
flutter build apk --verbose
```

### ❌ "compileSdkVersion not supported"
Aggiorna `android/app/build.gradle`:
```gradle
android {
    compileSdkVersion 34  // o versione più recente
    ...
}
```

---

## 📊 Dimensioni File

| Tipo | Dimensione |
|------|------------|
| APK Debug | ~150-200 MB |
| APK Release | ~50-70 MB |
| App Bundle | ~40-60 MB |

---

## 🎯 Flusso Completo (Racconto)

```bash
# 1. Pulire e preparare
flutter clean
flutter pub get

# 2. Verificare (opzionale)
flutter analyze

# 3. Generare APK release
flutter build apk --release

# 4. Trovare il file
ls build/app/outputs/flutter-apk/app-release.apk

# 5. Installare su dispositivo
flutter devices  # Lista dispositivi
flutter install --release  # Installa
flutter run --release  # Lancia

# Oppure manualmente:
adb install build/app/outputs/flutter-apk/app-release.apk
```

---

## ✅ Una Volta Installato

1. Apri l'app "Battaglia Navale" su un dispositivo
2. Apri su un secondo dispositivo
3. Entrambi premono "Cerca Avversario"
4. Connetti tramite Bluetooth LE
5. Posiziona le navi
6. **Battaglia!**

---

## 📝 Export/Condivisione APK

Una volta generato `app-release.apk`:
```bash
# Copiare in posizione comoda
cp build/app/outputs/flutter-apk/app-release.apk ~/Downloads/BattagliaNavale.apk

# Condividere via WhatsApp, Email, CloudStorage ecc.
```

---

## 🔗 Riferimenti Utili

- [Flutter Build Documentation](https://flutter.dev/docs/deployment/android)
- [Android Gradle Plugin](https://developer.android.com/studio/releases/gradle-plugin)
- [APK vs App Bundle](https://developer.android.com/guide/app-bundle)

---

**Pronto! Segui i comandi sopra e avrai il tuo APK di Battaglia Navale! ⚓**
