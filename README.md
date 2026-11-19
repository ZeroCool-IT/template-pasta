# Template Messaggi

Utility locale e stand-alone per gestire template di messaggi al cliente da copiare nel sistema di ticketing.

## Uso (eseguibile Windows)
Scarica `TemplateMessaggi-win64.zip` dall'[ultima release](https://github.com/ZeroCool-IT/template-pasta/releases/latest),
estrailo in una cartella a tua scelta (es. `Documenti\TemplateMessaggi`) e avvia `TemplateMessaggi.exe`
(`resources.neu` deve restare nella stessa cartella).
I template sono salvati in `template.json` nella stessa cartella dell'exe, con una copia della versione
precedente in `template.bak.json`. Per spostare l'app su un altro PC basta copiare la cartella.

All'avvio l'app controlla se c'è una versione nuova e propone di aggiornarsi con un clic
(anche manualmente con il pulsante **Aggiornamenti**). I template non vengono toccati.

- **Componi**: seleziona un template, ritocca il testo se serve, premi **Copia** (o Ctrl+Invio).
- **Modifica template**: titolo, categoria e testo; **Salva** (o Ctrl+S), **Duplica**, **Elimina**.
- **Campi automatici**: nel testo del template puoi usare `{{data}}` (19/11/2026), `{{ora}}` (14:35) e
  `{{dataora}}` (19/11/2026 14:35), anche con i pulsanti sotto il testo. In "Componi" vengono sostituiti con
  data e ora attuali, aggiornate finché non modifichi il testo e ricalcolate al momento della copia.
- **Esporta / Importa**: backup e condivisione dei template in un file JSON.

Non mettere la cartella in `C:\Programmi`: lì l'app non ha i permessi per scrivere `template.json`.

`resources/index.html` funziona anche aperto direttamente nel browser; in quel caso i dati restano nel browser.

## Sviluppo
Basato su [Neutralinojs](https://neutralino.js.org): l'interfaccia è in `resources/index.html`.

```bash
npm install
npx neu update        # scarica i binari Neutralino e la libreria client
npx neu run           # avvia in sviluppo
scripts/package.sh    # crea in dist/ lo zip completo e i file di aggiornamento
```

## Pubblicare una nuova versione
Alza `version` in `neutralino.config.json` (es. `1.2.0`) e fai push su `main`.
Il workflow `.github/workflows/release.yml` costruisce l'app, crea la release con lo zip e pubblica
`update.json` + `resources.neu` nel ramo `updates`, da cui le app installate scaricano l'aggiornamento
(verificando dimensione e SHA-256).

L'aggiornamento automatico sostituisce solo `resources.neu` (interfaccia e configurazione). Se cambia
`cli.binaryVersion` in `neutralino.config.json` serve un nuovo eseguibile: l'app lo segnala e rimanda
alla pagina delle release.
