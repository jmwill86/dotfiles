#!/usr/bin/env bash

# Install script for polybar themes

# Dirs
FDIR="$HOME/.local/share/fonts"
PDIR="$HOME/.config/polybar"

# Install Fonts
install_fonts() {
	echo -e "\n[*] Installing fonts..."
	[[ ! -d "$FDIR" ]] && mkdir -p "$FDIR"
	cp -rf $PDIR/fonts/* "$FDIR"
}

# Main
main() {
    STYLE='bitmap'
    install_fonts
}

main


echo -e "\n[*] Fonts installed..."


# Add this script to your wm startup file.

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar
pkill -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
polybar -q main -c "$DIR"/config.ini &
echo -e "\n[*] Polybar launched..."
