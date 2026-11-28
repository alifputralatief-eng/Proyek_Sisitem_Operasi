#!/bin/bash
# =====================================================================
# instalasi.sh - Skrip build "Host Container Mini" (Tahap 1)
#
# Merangkum seluruh perintah Langkah 1-7 yang dijalankan di terminal
# chroot Cubic (root@cubic:~#) agar build dapat diulang (reproducible).
#
# Cara pakai (di dalam terminal Cubic):
#   1. Drag-and-drop 3 file ini ke jendela terminal Cubic, klik Copy:
#        instalasi.sh, wallpaper-distro.jpg, logo-distro.png
#   2. bash instalasi.sh
#   3. Klik Next di Cubic -> tab Kernel pilih kernel 5.15.0-xxx-generic
#      -> Compression gzip -> Generate.
# =====================================================================

set -u

NAMA_DISTRO="Host Container Mini"
ZONA_WAKTU="Asia/Makassar"
ASSET_DIR="${1:-$PWD}"
WALLPAPER_SRC="$ASSET_DIR/wallpaper-distro.jpg"
LOGO_SRC="$ASSET_DIR/logo-distro.png"

if [ "$(id -u)" -ne 0 ]; then
  echo "Jalankan sebagai root (di dalam terminal chroot Cubic)." >&2
  exit 1
fi

for f in "$WALLPAPER_SRC" "$LOGO_SRC"; do
  if [ ! -f "$f" ]; then
    echo "File tidak ditemukan: $f" >&2
    echo "Drag-and-drop file aset ke terminal Cubic dulu, lalu klik Copy." >&2
    exit 1
  fi
done

echo "### [1/9] Update repository"
apt update
apt-add-repository -y universe
apt-add-repository -y multiverse
apt update

echo "### [2/9] XFCE + LightDM"
DEBIAN_FRONTEND=noninteractive apt install -y \
  xfce4 xfce4-goodies lightdm lightdm-gtk-greeter \
  xfce4-terminal network-manager-gnome

echo "lightdm shared/default-x-display-manager select lightdm" | debconf-set-selections
echo "/usr/sbin/lightdm" > /etc/X11/default-display-manager
dpkg-reconfigure -f noninteractive lightdm

apt purge -y ubuntu-desktop gnome-shell gdm3 \
  'libreoffice*' 'rhythmbox*' 'thunderbird*' \
  aisleriot gnome-mahjongg gnome-mines gnome-sudoku
apt autoremove -y
apt install -y ubiquity ubiquity-frontend-gtk casper

echo "### [3/9] Autologin Live (user: ubuntu)"
mkdir -p /etc/lightdm/lightdm.conf.d

cat << 'EOF' > /etc/lightdm/lightdm.conf.d/50-xfce-default.conf
[Seat:*]
user-session=xfce
greeter-session=lightdm-gtk-greeter
EOF

cat << 'EOF' > /etc/lightdm/lightdm.conf.d/50-live-autologin.conf
[Seat:*]
autologin-guest=false
autologin-user=ubuntu
autologin-user-timeout=0
autologin-session=xfce
EOF

echo "### [4/9] Wallpaper desktop dan layar login"
WP_DIR=/usr/share/backgrounds/distro-custom
mkdir -p "$WP_DIR"
cp "$WALLPAPER_SRC" "$WP_DIR/wallpaper-distro.jpg"
chmod 755 "$WP_DIR"
chmod 644 "$WP_DIR/wallpaper-distro.jpg"

mkdir -p /usr/share/backgrounds/xfce
ln -sf "$WP_DIR/wallpaper-distro.jpg" /usr/share/backgrounds/xfce/xfce-verticals.png
ln -sf "$WP_DIR/wallpaper-distro.jpg" /usr/share/backgrounds/xfce/xfce-shapes.svg

mkdir -p /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml
cat << 'EOF' > /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-desktop" version="1.0">
  <property name="backdrop" type="empty">
    <property name="screen0" type="empty">
      <property name="monitorVirtual1" type="empty">
        <property name="workspace0" type="empty">
          <property name="last-image" type="string" value="/usr/share/backgrounds/distro-custom/wallpaper-distro.jpg"/>
          <property name="image-style" type="int" value="5"/>
        </property>
      </property>
      <property name="monitor0" type="empty">
        <property name="workspace0" type="empty">
          <property name="last-image" type="string" value="/usr/share/backgrounds/distro-custom/wallpaper-distro.jpg"/>
          <property name="image-style" type="int" value="5"/>
        </property>
      </property>
    </property>
  </property>
</channel>
EOF

cat << 'EOF' > /etc/lightdm/lightdm-gtk-greeter.conf
[greeter]
background=/usr/share/backgrounds/distro-custom/wallpaper-distro.jpg
theme-name=Greybird
icon-theme-name=elementary-xfce-dark
EOF

echo "### [5/9] Boot splash Plymouth"
apt install -y plymouth plymouth-themes linux-image-generic linux-headers-generic

TEMA_DIR=/usr/share/plymouth/themes/distro-splash
mkdir -p "$TEMA_DIR"
cp "$LOGO_SRC" "$TEMA_DIR/logo-distro.png"

cat << 'EOF' > "$TEMA_DIR/distro-splash.plymouth"
[Plymouth Theme]
Name=Distro Custom Splash
Description=Splash screen kustom tugas proyek Sistem Operasi
ModuleName=script

[script]
ImageDir=/usr/share/plymouth/themes/distro-splash
ScriptFile=/usr/share/plymouth/themes/distro-splash/distro-splash.script
EOF

cat << 'EOF' > "$TEMA_DIR/distro-splash.script"
Window.SetBackgroundTopColor(0.08, 0.10, 0.14);
Window.SetBackgroundBottomColor(0.05, 0.06, 0.09);

logo.image = Image("logo-distro.png");
logo.sprite = Sprite(logo.image);
logo.sprite.SetX(Window.GetWidth() / 2 - logo.image.GetWidth() / 2);
logo.sprite.SetY(Window.GetHeight() / 2 - logo.image.GetHeight() / 2);
logo.sprite.SetOpacity(1);
EOF

update-alternatives --install \
  /usr/share/plymouth/themes/default.plymouth default.plymouth \
  "$TEMA_DIR/distro-splash.plymouth" 200
update-alternatives --set default.plymouth "$TEMA_DIR/distro-splash.plymouth"
update-initramfs -u -k all

echo "### [6/9] 10 paket container"
apt install -y runc iproute2 cgroup-tools \
  containerd iptables bridge-utils busybox \
  curl htop vim

echo "### [7/9] Branding nama distro"
sed -i --follow-symlinks \
  "s/^NAME=.*/NAME=\"$NAMA_DISTRO\"/; s/^PRETTY_NAME=.*/PRETTY_NAME=\"$NAMA_DISTRO\"/" \
  /etc/os-release
sed -i "s/^DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION=\"$NAMA_DISTRO\"/" /etc/lsb-release

echo "### [8/9] Zona waktu dan bahasa"
ln -sf "/usr/share/zoneinfo/$ZONA_WAKTU" /etc/localtime
echo "$ZONA_WAKTU" > /etc/timezone
locale-gen en_US.UTF-8 id_ID.UTF-8
update-locale LANG=en_US.UTF-8

echo "### [9/9] Skrip first-login dan fitur B3 (container-info)"
mkdir -p /usr/local/bin /etc/skel/.config/autostart

cat << 'EOF' > /usr/local/bin/first-login.sh
#!/bin/bash
FLAG="$HOME/.first_login_done"
if [ ! -f "$FLAG" ]; then
  xfce4-terminal --hold -e "bash -c 'echo Selamat datang di Host Container Mini!; uname -a; echo; echo === Namespace proses ini ===; ls -l /proc/self/ns; echo; echo === Cgroup proses ini ===; cat /proc/self/cgroup; echo; echo Gunakan: container-info PID untuk proses lain'"
  touch "$FLAG"
fi
EOF
chmod +x /usr/local/bin/first-login.sh

cat << 'EOF' > /usr/local/bin/container-info
#!/bin/bash
# Fitur B3: tampilkan info namespace dan cgroup suatu proses.
PID=${1:-self}
echo "=== Namespace PID $PID ==="
ls -l /proc/$PID/ns
echo
echo "=== Cgroup PID $PID ==="
cat /proc/$PID/cgroup
EOF
chmod +x /usr/local/bin/container-info

cat << 'EOF' > /etc/skel/.config/autostart/first-login.desktop
[Desktop Entry]
Type=Application
Name=First Login Setup
Exec=/usr/local/bin/first-login.sh
X-GNOME-Autostart-enabled=true
EOF

echo "### Pembersihan cache APT"
apt clean
rm -rf /var/lib/apt/lists/*

echo
echo "Selesai. Verifikasi cepat:"
cat /etc/X11/default-display-manager
update-alternatives --display default.plymouth | head -n 2
grep PRETTY_NAME /etc/os-release
echo "Lanjut: klik Next di Cubic -> Kernel -> Compression (gzip) -> Generate."
