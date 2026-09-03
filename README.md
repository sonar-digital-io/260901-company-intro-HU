# Sonar Digital — Bemutatkozás & szolgáltatáscsomagok

Egyfájlos, billentyűvel lapozható prezentáció (slide deck) a Sonar Digital bemutatkozásához és a négy szolgáltatáscsomaghoz. Sötét, DM Sans alapú Sonar-arculat, 1920×1080 print/PDF-móddal.

## Tartalom (18 dia)

Borító · Tartalom · Önmeghatározás · **Kik vagyunk?** · Ars poetica · Szolgáltatásaink (SELL / BUILD / OPERATE / RETHINK) · **SELL** + MedTech esettanulmány · **BUILD** + Labtech esettanulmány · **OPERATE** + Kék Vonal esettanulmány · **RETHINK** + Econ Engineering esettanulmány · Csapat (3 dia) · Kapcsolat.

## Design nyelv

A deck a Sonar deck-rendszer **kanonikus komponenseit** használja. A referencia:
`AI_Toborzasi_Rendszer_Sonar_csomagok_v2` — ebből származnak a tokenek, méretek és komponensek. Ha új diát vagy komponenst készítesz, **innen vedd a mintát, ne találj ki újat.**

| Komponens | Mire való | Hol használjuk |
|---|---|---|
| `.slide-tag` | dia-azonosító jobb felül | minden dia |
| `.composition` + `.comp-piece` | 14 darabból, egyenként animálva belépő borítókép | borító |
| `.step-header` (+ `-left` / `-meta-row` / `-num` / `-title` / `-hours`) | dia-fejléc: pill + cím balra, nagy mint szám jobbra, alatta vonal | csomag-diák |
| `.step-cols` + `.step-col` (`.solution` kék, `.result` mint gradiens bal szegély) | három hasáb; `h3` = uppercase mint mikro-label | csomag-diák |
| `.scope-list` | felsorolás mint ponttal | Labtech case |
| `.pricing-features` | szállítandók mint pipával | csomag-diák |
| `.rate-card` + `.rate-card-num` | nagy szám / metrika kártya | esettanulmány-statok |
| `.scope-header` / `.pricing-card` / `.pricing-card-tier` | szekció-fejléc, csomag-kártya, kis tier-label | Szolgáltatásaink |
| `.image-band-bottom` | alsó gradiens sáv (`gradient-bottom.jpg`) | **minden dia** (`.slide.with-band`) |
| `.pricing-card` + `.featured` + `.pricing-card-tier` | kártya-rács, mint-kiemelt variánssal | csomag-diák, Szolgáltatásaink |
| `.logo-hint` | navigációs tipp a logó alatt (bezárható, lapozásra eltűnik) | globális |

Deck-specifikus kiegészítések (a kanonikusra épülnek, nem helyettesítik):
`.pkg-cards` (Probléma / Megoldás / Impact hármas `.pricing-card`-ban, az Impact a `.featured` mint-kiemelt variáns), `.impact-list`, `.deliverables` + `.chip-blue` („Mit kapsz a végén?" chipek sötétkéken), `.creed-list` / `.creed-row` (Kik vagyunk? — állítás + kifejtés soronként), `.quote-list` (ügyfél-idézetek), `ol.step-list` (számozott lépések), `.case-stats` (`.rate-card` rács), `.services-grid.packages`, `.case-highlights`.

### Csomag-dia felépítése (SELL / BUILD / OPERATE / RETHINK)

`.step-header`: kategória-pill + `n / 4` balra, **a csomag szlogenje a nagy címben**, a csomag neve mintben jobbra — pontosan ott, ahol a referencián a lépés neve és az óraszám áll; alatta a fejléc elválasztó vonala. Alatta `.pkg-cards` a három kártyával, majd `.deliverables` chip-sor, végül az alsó sáv.

Az alsó sáv minden dián fut: a `section`-re `with-band` osztály kerül, ami `padding-bottom: calc(130px + 4vh)` helyet hagy a sávnak (768 px alatt a sáv a folyamba kerül, ott nincs szükség a helykihagyásra).

## Szerkezet

```
index.html            – a teljes deck (egy fájl: HTML + CSS + JS inline)
assets/               – képek (logó, lab-képek, esettanulmány-vizuálok, csapatfotók)
assets/comp/          – a borító kompozíció 14 darabja
og-image.png          – link-előnézeti kép (Open Graph)
vercel.json           – statikus deploy (cache + biztonsági headerek)
export-pdf.sh         – PDF-export headless Chrome-mal
sonar-intro-2026.pdf  – a legutóbb exportált PDF (18 lap, 1920×1080)
```

## Nyitott elemek

Két esettanulmány-dián ideiglenes kép van, `TODO` kommenttel jelölve az `index.html`-ben:

| Dia | Jelenlegi (ideiglenes) kép | Várt végleges fájl |
|-----|---------------------------|--------------------|
| 10 — Labtech (BUILD) | `assets/sonar_software-lab.avif` | `assets/case-labtech.jpg` |
| 12 — Kék Vonal (OPERATE) | `assets/sonar_growth-lab.avif` | `assets/case-kekvonal.jpg` |

A `assets/case-njt.jpg` (AI jogszabálykereső) nincs használatban: az a dia kikerült a deckből, a fájl megmaradt.

## Helyi futtatás

```bash
python -m http.server 8099
```

majd `http://localhost:8099/`

Navigáció: `←` `→` / `Space` lapozás · `Home`/`End` ugrás · `1`–`9` közvetlen ugrás · a logóra kattintva a tartalomjegyzék.

## Deploy (Vercel)

Statikus oldal, build nélkül. A repo push-ra automatikusan deployol; a `vercel.json` állítja a cache- és biztonsági headereket.

## PDF-export

```bash
./export-pdf.sh
```

18 lap, egyenként pontosan 1920×1080 px. A `@media print` blokk állítja a lapméretet (`@page { size: 1920px 1080px }`), kikapcsolja az animációkat, és `!important`-tal fixálja a desktop rácsokat — a Chrome ugyanis nyomtatáskor a viewport, nem a lapméret alapján értékeli a reszponzív breakpointokat.

Kézzel: Chrome → `Ctrl/Cmd+P` → Save as PDF, Landscape, margó nincs, **Background graphics: ON**.
