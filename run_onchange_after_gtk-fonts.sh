#!/bin/sh
# GTK/GNOME font settings (gsettings isn't a file, so chezmoi applies it here).
# Re-runs whenever this script changes. Pairs with ~/.config/fontconfig/fonts.conf.
set -e
command -v gsettings >/dev/null || exit 0
gsettings set org.gnome.desktop.interface font-name           'Inter 10'
gsettings set org.gnome.desktop.interface document-font-name  'Inter 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 10'
gsettings set org.gnome.desktop.interface font-antialiasing   'grayscale'
gsettings set org.gnome.desktop.interface font-hinting        'slight'
