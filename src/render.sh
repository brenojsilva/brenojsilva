#!/bin/sh
# Gera as imagens do README a partir de src/card.html (requer Microsoft Edge).
cd "$(dirname "$0")/.."
E="/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"
for t in light dark; do
  for id in banner sanjes linko fibrolink videos; do
    h=240; [ $id = banner ] && h=400
    "$E" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=2 \
      --default-background-color=00000000 --virtual-time-budget=6000 --window-size=1280,$h \
      --user-data-dir="$(cygpath -w /tmp/edge-gh-$id-$t)" \
      --screenshot="$(cygpath -w "$PWD/assets/$id-$t.png")" \
      "file:///$(cygpath -m "$PWD/src/card.html")#$id-$t" 2>&1 | grep -o "written.*" &
  done
done
wait
