#!/bin/sh
# Wraps each Artifact page fragment into a standalone HTML file for GitHub Pages.
#   <idea>/page.html        -> <idea>/index.html
#   <idea>/<name>.page.html -> <idea>/<name>.html
cd "$(dirname "$0")"
for src in */page.html */*.page.html; do
  [ -f "$src" ] || continue
  case "$src" in */page.html) out="${src%page.html}index.html";; *) out="${src%.page.html}.html";; esac
  {
    printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
    sed -n '1,/<\/style>/p' "$src" | sed 's/^\*{box-sizing:border-box}$/*{box-sizing:border-box} body{margin:0} [hidden]{display:none!important} img{max-width:100%}/'
    printf '</head>\n<body>\n'
    sed -n '/<\/style>/,$p' "$src" | tail -n +2
    printf '</body>\n</html>\n'
  } > "$out"
  echo "built $out"
done
