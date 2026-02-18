# 🚀 Compilare APK da GitHub (Automatico)

## ✨ Cosa è stato aggiunto

Un **GitHub Actions Workflow** che compila automaticamente l'APK ogni volta che fai un push a GitHub!

---

## 📋 Come Usarlo

### 1️⃣ Push il codice su GitHub
```bash
git add .
git commit -m "Battaglia Navale - First release"
git push origin main
```

### 2️⃣ Guarda la compilazione
1. Vai su **GitHub** → il tuo repo
2. Clicca su **Actions** (in alto)
3. Vedrai il workflow "Build APK Release" in esecuzione
4. Aspetta che finisca (2-3 minuti)

### 3️⃣ Scarica l'APK
Una volta completato il build:
- Clicca sul workflow completato
- Scorri a fondo: troverai **Artifacts**
- Clicca su **app-release** → scarica `app-release.apk`

---

## 🎯 Flusso Completo

```
git push → GitHub Actions avvia build → APK pronto → Scarica
   ⏱️ ~3 minuti                                    📦
```

---

## 🔄 Come Funziona il Workflow

Il file `.github/workflows/build.yml` fa:

1. ✅ **Setup Flutter** (installa Flutter SDK automaticamente)
2. 📥 **Checkout** del codice dal tuo repo
3. 📦 **Get Dipependenze** (`flutter pub get`)
4. 🔍 **Analyze** il codice (controlla errori)
5. 🏗️ **Build APK Release** (compila l'APK ottimizzato)
6. 💾 **Salva come Artifact** (disponibile per 30 giorni)
7. 📝 **Commenta PR** (se è una pull request)

---

## 📌 Quando Compila Automaticamente

Il workflow è configurato per attivarsi:

- ✅ **Push su branch `main`**
- ✅ **Push su branch `develop`**
- ✅ **Pull request su `main`**
- ✅ **Manualmente** (bottone "Run workflow" su GitHub)

---

## 🏷️ Release Ufficiali (Opzionale)

Se vuoi creare una "Release" ufficiale con l'APK:

```bash
# Crea un tag (es. v1.0.0)
git tag v1.0.0
git push origin v1.0.0
```

Quando fai push del tag, il workflow:
1. Compila l'APK
2. Crea una **Release su GitHub**
3. Allega automaticamente l'APK alla release

Poi puoi scaricare da: **Releases** → seleziona versione → scarica APK

---

## 📊 Monitorare i Build

### Dashboard GitHub Actions
```
Repository → Actions → Build APK Release
├── ✅ Build completato
├── ⏳ Build in corso
└── ❌ Build fallito (leggi i log)
```

### Visualizzare i Log
Se il build fallisce:
1. Clicca sul workflow fallito
2. Clicca su **build**
3. Scorri nei **logs** per vedere l'errore

---

## 🐛 Troubleshooting

### Build fallisce?
- Controlla i **Log di GitHub Actions**
- Verifica che `pubspec.yaml` sia valido
- Assicurati che `AndroidManifest.xml` abbia i permessi

### Come correggere?
1. Fixa il bug localmente
2. Commit e push su GitHub
3. Il workflow si riattiverà automaticamente

---

## 💡 Vantaggi

| Feature | Vantaggio |
|---------|-----------|
| **Automatico** | Non devi compilare localmente |
| **Sempre aggiornato** | APK = ultimo codice su main |
| **Gratis** | GitHub Actions è gratuito per repo pubblici |
| **Condivisibile** | Condividi il link del repo, il resto fa il workflow |
| **Storico** | Tutti i build rimangono per 30 giorni |

---

## 🔐 Sicurezza

⚠️ **Importante**: Il workflow è pubblico, ma:
- Compila su server GitHub (sicuro)
- Nessuna secret o credenziale nel codice
- L'APK è disponibile solo a chi ha accesso al repo

---

## 📱 Flusso per Testare

**Per te e il tuo amico:**

1. Uno di voi fa **push su GitHub**
2. GitHub Actions compila automaticamente
3. Entrambi scaricate l'APK dagli **Artifacts**
4. Installate su dispositivi Android
5. Testate Battaglia Navale!

```
git push
     ↓
[GitHub compila automaticamente - 3 minuti]
     ↓
APK pronto in Artifacts
     ↓
Scarica su 2 dispositivi
     ↓
⚓ BATTAGLIA!
```

---

## 🎯 Riassunto

✅ **Non devi avere Flutter installato** sul tuo PC  
✅ **Non devi compilare manualmente**  
✅ **APK sempre disponibile** da GitHub  
✅ **Perfetto per testing** tra dispositivi  

Basta **git push** e il resto fa GitHub! 🚀

---

Documentazione completa: [.github/workflows/build.yml](.github/workflows/build.yml)
