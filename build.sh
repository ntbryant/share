#!/bin/sh
# Wraps each Artifact page fragment into a standalone HTML file for GitHub Pages.
#   <idea>/page.html        -> <idea>/index.html
#   <idea>/<name>.page.html -> <idea>/<name>.html
cd "$(dirname "$0")"
for src in */page.html */*.page.html; do
  [ -f "$src" ] || continue
  case "$src" in */page.html) out="${src%page.html}index.html";; *) out="${src%.page.html}.html";; esac
  {
    printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n<link rel="icon" href="data:image/svg+xml,%%3Csvg xmlns=%%27http://www.w3.org/2000/svg%%27 viewBox=%%270 0 32 32%%27%%3E%%3Crect width=%%2732%%27 height=%%2732%%27 rx=%%278%%27 fill=%%27%%23123a63%%27/%%3E%%3Cpath d=%%27M9 22h14%%27 stroke=%%27%%23f2b705%%27 stroke-width=%%273%%27 stroke-linecap=%%27round%%27/%%3E%%3Cpath d=%%27M11 10h10M11 16h10%%27 stroke=%%27%%23fff%%27 stroke-width=%%273%%27 stroke-linecap=%%27round%%27/%%3E%%3C/svg%%3E">\n'
    sed -n '1,/<\/style>/p' "$src" | sed 's/^\*{box-sizing:border-box}$/*{box-sizing:border-box} body{margin:0} [hidden]{display:none!important} img{max-width:100%}/'
    printf '</head>\n<body>\n'
    sed -n '/<\/style>/,$p' "$src" | tail -n +2
    printf '</body>\n</html>\n'
  } > "$out"
  echo "built $out"
done
