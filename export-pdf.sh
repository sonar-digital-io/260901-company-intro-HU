#!/usr/bin/env bash
# PDF-export: 17 lap, egyenként 1920×1080 px.
# Használat:  ./export-pdf.sh [kimeneti-fájl]
#
# A deck @media print blokkja gondoskodik a lapméretről és arról, hogy a
# reszponzív breakpointok ne szóljanak bele a nyomtatásba.

set -euo pipefail

OUT="${1:-sonar-intro-2026.pdf}"
PORT=8099
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Chrome megkeresése (Windows / macOS / Linux)
for c in \
  "$LOCALAPPDATA/Google/Chrome/Application/chrome.exe" \
  "/c/Program Files/Google/Chrome/Application/chrome.exe" \
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  "$(command -v google-chrome || true)" \
  "$(command -v chromium || true)"
do
  [ -x "$c" ] && CHROME="$c" && break
done
: "${CHROME:?Chrome nem található — add meg kézzel a CHROME változóban.}"

# Ideiglenes helyi szerver (a file:// nem tölti be az assetek egy részét)
python -m http.server "$PORT" --directory "$DIR" >/dev/null 2>&1 &
SERVER=$!
trap 'kill $SERVER 2>/dev/null || true' EXIT
sleep 1

"$CHROME" \
  --headless=new --disable-gpu --no-sandbox \
  --no-pdf-header-footer \
  --run-all-compositor-stages-before-draw \
  --virtual-time-budget=25000 \
  --print-to-pdf="$DIR/$OUT" \
  "http://localhost:$PORT/"

echo "Kész: $OUT"
