#!/usr/bin/env bash
# Costruisce l'app e prepara in dist/:
#   TemplateMessaggi-win64.zip   pacchetto completo (exe + resources.neu + LEGGIMI)
#   updates/update.json          descrizione dell'aggiornamento
#   updates/resources.neu        interfaccia aggiornabile
# Uso: scripts/package.sh [versione]   (senza argomento usa quella in neutralino.config.json)
set -euo pipefail
cd "$(dirname "$0")/.."

if [ -n "${1:-}" ]; then
  node -e '
    const fs = require("fs"); const f = "neutralino.config.json";
    const c = JSON.parse(fs.readFileSync(f)); c.version = process.argv[1];
    fs.writeFileSync(f, JSON.stringify(c, null, 2) + "\n");' "$1"
fi
VERSION=$(node -p 'require("./neutralino.config.json").version')
BINVER=$(node -p 'require("./neutralino.config.json").cli.binaryVersion')

npx neu update
npx neu build --release

rm -rf dist/pkg dist/updates dist/TemplateMessaggi-win64.zip
mkdir -p dist/pkg/TemplateMessaggi dist/updates
cp dist/TemplateMessaggi/TemplateMessaggi-win_x64.exe dist/pkg/TemplateMessaggi/TemplateMessaggi.exe
cp dist/TemplateMessaggi/resources.neu packaging/LEGGIMI.txt dist/pkg/TemplateMessaggi/
(cd dist/pkg && zip -qr ../TemplateMessaggi-win64.zip TemplateMessaggi)

cp dist/TemplateMessaggi/resources.neu dist/updates/
SHA=$(sha256sum dist/updates/resources.neu | cut -d' ' -f1)
SIZE=$(stat -c %s dist/updates/resources.neu)
cat > dist/updates/update.json <<JSON
{
  "version": "$VERSION",
  "binaryVersion": "$BINVER",
  "resources": "resources.neu",
  "size": $SIZE,
  "sha256": "$SHA",
  "notes": "${RELEASE_NOTES:-}"
}
JSON
echo "Versione $VERSION pronta in dist/"
