#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Cari semua file gambar
mapfile -t FILES < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \))

# Pilih wallpaper dengan rofi
SELECTED_WALLPAPER=$(printf '%s\n' "${FILES[@]}" | rofi -dmenu -p "Pilih Wallpaper")

# Cek jika kosong (cancel)
if [ -z "$SELECTED_WALLPAPER" ]; then
  echo "Tidak ada wallpaper dipilih, keluar."
  exit 1
fi

# Jalankan swww daemon jika belum jalan
if ! pgrep -x "swww-daemon" >/dev/null; then
  swww init
  sleep 1
fi

# Set wallpaper yang dipilih dengan transisi
swww img "$SELECTED_WALLPAPER" --transition-type any --transition-step 90


