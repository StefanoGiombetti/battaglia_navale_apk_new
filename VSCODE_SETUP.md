# 🛠️ VSCode Extensions per Monitorare il Build

## Estensioni Installate ✅

### 1. **Flutter - Official** 
- ID: `Dart-Code.flutter`
- **Cosa fa**: Supporto completo Flutter in VSCode
- **Funzioni**:
  - Syntax highlighting
  - Code completion
  - Hot reload/restart
  - Widget tree explorer
  - Device selector

### 2. **Dart - Official**
- ID: `Dart-Code.dart-code`
- **Cosa fa**: Supporto Dart / diagnostica errori
- **Funzioni**:
  - Error detection in tempo reale
  - Code analysis
  - Refactoring tools
  - Format code

### 3. **GitHub Pull Requests and Issues**
- ID: `GitHub.vscode-pull-request-github`
- **Cosa fa**: Gestire PR e build direttamente da VSCode
- **Funzioni**:
  - Visualizzare lo stato dei GitHub Actions
  - Leggere i log del build
  - Creare PR
  - Vedere i commit

---

## 🚀 Come Usare le Estensioni

### Monitorare il Build da VSCode

#### 1️⃣ Aprire GitHub Pull Requests
- **Ctrl+Shift+P** (o **Cmd+Shift+P** su Mac)
- Digita: `GitHub: Browse on GitHub`
- Oppure clicca l'icona GitHub nella sidebar

#### 2️⃣ Vedere lo Stato dei GitHub Actions
```
Activity Bar (sinistra)
  └─ GitHub Icon
      └─ Pull Requests / Actions
          └─ Clicca per vedere i build
```

#### 3️⃣ Leggere i Log del Build Fallito
1. Clicca su **Actions** nel menu GitHub di VSCode
2. Seleziona il workflow fallito
3. Espandi _dettagli per vedere i log

---

## 🔍 Diagnostica Errori Localmente

### Controlla gli Errori in VSCode

**I file con errori appariranno**:
- ❌ Rossi nel file explorer
- 🔴 Sottolineati nel codice

**Come risolvere**:
1. **Apri Problems Panel**: **Ctrl+Shift+M**
2. Leggi gli errori
3. Clicca sull'errore → vai al file
4. Risolvi

### Analizza il Codice

```
Ctrl+Shift+P → "Dart: Analyze"
```

Questo esegue `flutter analyze` e mostra tutti gli errori/warning.

---

## ✨ Comandi Utili

| Comando | Scorciatoia |
|---------|------------|
| Run | **F5** o **Ctrl+F5** |
| Hot Reload | **Ctrl+Shift+;** |
| Hot Restart | **Ctrl+Shift+,** |
| Format Code | **Shift+Alt+F** |
| Analyze | **Ctrl+Shift+P** → "Dart: Analyze" |
| Select Device | **Ctrl+Shift+P** → "Flutter: Select Device" |

---

## 📋 Flusso di Testing

### Debug Locale
1. Connetti un dispositivo Android
2. Premi **F5** per avviare il debug
3. VSCode mostra gli errori in tempo reale
4. Modifica il codice → Auto hot reload

### Vedere il Build su GitHub
1. Fai un **commit + push**
2. **Ctrl+Shift+P** → "GitHub: Browse on GitHub"
3. Vai su **Actions** nel repo
4. Vedi il workflow in tempo reale
5. Se fallisce, clicca e leggi i log

---

## 🐛 Problemi Comuni

### "Cannot find Flutter"
- Assicurati che Flutter sia nel PATH
- **Ctrl+Shift+P** → "Flutter: Change Device"
  - Se non vedi dispositivi, Flutter non è trovato
- Riconfigura: `flutter config --android-sdk /path`

### Errori di Import
- **Ctrl+Shift+M** per aprire Problems
- Gli errori di import appariranno qui
- Risolvi e saved → auto fix spesso funziona

### Build Lento
- Usa **Hot Reload** (Ctrl+Shift+;) durante lo sviluppo
- Solo compilazione cambierà `flutter run --release` per test finale

---

## 📦 Setup Consigliato

Nella cartella VSCode workspace (`.vscode/settings.json`):

```json
{
  "dart.enableSdkFormatter": true,
  "dart.lineLength": 80,
  "[dart]": {
    "editor.defaultFormatter": "Dart-Code.dart-code",
    "editor.formatOnSave": true
  },
  "flutter.debugLogFile": "./debug.log"
}
```

---

## ✅ Riassunto

| Feature | Estensione |
|---------|-----------|
| 🐦 Flutter development | Flutter Official |
| 🔍 Error detection | Dart Official |
| 📊 Monitor GitHub Actions | GitHub PRs |
| 🎨 Code format | Built-in Dart |

Con queste estensioni:
- ✅ Vedi gli errori in tempo reale
- ✅ Monitora i build su GitHub
- ✅ Hot reload durante lo sviluppo
- ✅ Fix automatico di molti errori

---

**Pronto a debuggare il build! 🚀**
