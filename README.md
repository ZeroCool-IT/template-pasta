# Template Messaggi

Utility locale e stand-alone per gestire template di messaggi al cliente da copiare nel sistema di ticketing.

## Uso (eseguibile Windows)
Estrai lo zip in una cartella a tua scelta (es. `Documenti\TemplateMessaggi`) e avvia `TemplateMessaggi.exe`.
I template sono salvati in `template.json` nella stessa cartella dell'exe, con una copia della versione
precedente in `template.bak.json`. Per spostare l'app su un altro PC basta copiare la cartella.

- **Componi**: seleziona un template, ritocca il testo se serve, premi **Copia** (o Ctrl+Invio).
- **Modifica template**: titolo, categoria e testo; **Salva** (o Ctrl+S), **Duplica**, **Elimina**.
- **Esporta / Importa**: backup e condivisione dei template in un file JSON.

Non mettere la cartella in `C:\Programmi`: lì l'app non ha i permessi per scrivere `template.json`.

`resources/index.html` funziona anche aperto direttamente nel browser; in quel caso i dati restano nel browser.

## Sviluppo
Basato su [Neutralinojs](https://neutralino.js.org): l'interfaccia è in `resources/index.html`.

```bash
npm install
npx neu update                           # scarica i binari Neutralino e la libreria client
npx neu run                              # avvia in sviluppo
npx neu build --release --embed-resources   # crea dist/ con l'exe singolo
```
