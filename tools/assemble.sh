#!/usr/bin/env bash
# Assemble the GitHub Pages site from a Next.js static export of brainfortsecurity.com.
#   usage: tools/assemble.sh <next-export-dir> <destination-dir>
# Keeps only what the portfolio page needs: its route, its assets, the hashed /_next bundle
# and the root files the page references (favicon). The page is served at "/" and at
# "/portfolio/WassimBizid/" so both the short and the familiar address work.
set -euo pipefail

OUT="${1:?next export dir}"
DEST="${2:?destination dir}"
PAGE="$OUT/portfolio/WassimBizid/index.html"

[ -f "$PAGE" ] || { echo "missing $PAGE - run 'npm run build' first" >&2; exit 1; }

rm -rf "$DEST"
mkdir -p "$DEST"
cp -r "$OUT/_next" "$DEST/_next"
cp -r "$OUT/portfolio" "$DEST/portfolio"

# Root-level files referenced by the page (e.g. /favicon.ico).
grep -oE '(href|src)="/[^"]+"' "$PAGE" \
  | sed -E 's/^[a-z]+="\/([^"?#]*).*/\1/' \
  | grep -vE '^(_next|portfolio)/' \
  | sort -u \
  | while read -r f; do
      if [ -n "$f" ] && [ -f "$OUT/$f" ]; then
        mkdir -p "$DEST/$(dirname "$f")"
        cp "$OUT/$f" "$DEST/$f"
      fi
    done

# The portfolio is the home page of this site.
cp "$PAGE" "$DEST/index.html"

# /portfolio/ -> the portfolio (same behaviour as the main domain).
cat > "$DEST/portfolio/index.html" <<'HTML'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="robots" content="noindex">
<meta http-equiv="refresh" content="0; url=/">
<link rel="canonical" href="/">
<title>Wassim Bizid - Portfolio</title>
</head>
<body><p><a href="/">Open the portfolio</a></p></body>
</html>
HTML
cp "$DEST/portfolio/index.html" "$DEST/404.html"

# GitHub Pages runs Jekyll by default, which drops folders starting with "_" such as /_next.
touch "$DEST/.nojekyll"

echo "assembled $(find "$DEST" -type f | wc -l) files into $DEST"
