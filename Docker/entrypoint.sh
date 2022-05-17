#!/bin/bash

set -eux -o pipefail

(set +e; (while true; do Xvfb :0 -screen 0 1600x900x24 -fbdir "$(mktemp -d)"; done) 2>&1 | tee ../logs/Xvfb.log) &
sleep 1
(set +e; (while true; do x11vnc -display "$DISPLAY" -forever; done) 2>&1 | tee ../logs/x11vnc.log) &
(set +e; (while true; do /root/workdir/noVNC/utils/novnc_proxy  --vnc localhost:5900; done) 2>&1 | tee ../logs/noVNC.log) &
gnome-terminal "--display=$DISPLAY" &
java -jar sikulixide.jar -c -r tests/ishikihikui.sikuli/ishikihikui.py &
date > /root/workdir/tests/timestamp.txt
fvwm2
