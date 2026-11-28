# 🐳 Host Container Mini

![Base](https://img.shields.io/badge/Base-Ubuntu%2022.04.5%20LTS-E95420?logo=ubuntu&logoColor=white)
![Desktop](https://img.shields.io/badge/Desktop-XFCE4-2284F2?logo=xfce&logoColor=white)
![Arch](https://img.shields.io/badge/Arsitektur-x86__64-blue)
![Builder](https://img.shields.io/badge/Builder-Cubic-green)
![Tahap](https://img.shields.io/badge/Tahap%201-Selesai-brightgreen)

**Host Container Mini** adalah distribusi Linux kustom berbasis **Ubuntu 22.04.5 LTS (Jammy Jellyfish)** dengan desktop ringan **XFCE4**. Distro ini dirancang sebagai *host* mini untuk mempelajari dan menjalankan teknologi container, lengkap dengan runtime, alat jaringan, alat cgroup, dan skrip bawaan untuk melihat **namespace** serta **cgroup** suatu proses.

> Proyek Mata Kuliah Sistem Operasi, Tahap 1.

---

## 📑 Daftar Isi

1. [Identitas Kelompok](#-identitas-kelompok)
2. [Ringkasan Distro](#-ringkasan-distro)
3. [Progres Pengembangan](#-progres-pengembangan)
4. [Paket yang Dipasang dan Dihapus](#-paket-yang-dipasang-10-paket)
5. [Fitur B3: Info Namespace dan Cgroup](#-fitur-b3-info-namespace-dan-cgroup)
6. [Kustomisasi Tampilan](#-kustomisasi-tampilan)
7. [Cara Build (Cubic)](#-cara-build-dengan-cubic)
8. [Pengujian](#-pengujian)
9. [Download ISO](#-download-iso)
10. [Struktur Repositori](#-struktur-repositori)
11. [Catatan dan Kendala](#-catatan-dan-kendala)

---

## 👥 Identitas Kelompok

| Keterangan | Isi |
|---|---|
| Nomor Kelompok | 2 |
| Mata Kuliah | Sistem Operasi |
| Dosen Pengampu | JEFFRY, S.Kom., M.T |

| No | Nama | NIM | Peran |
|---|---|---|---|
| 1 | ALIF PUTRA LATIEF | 251011022 | Ketua |
| 2 | IKRAMUL MUSLIM | 251011024 | Anggota |
| 3 | ABDUL RAHIM | 251011055 | Anggota |
| 4 | FANI RAHIM | 251011060 | Anggota |
| 5 | ANDI ASHILAH TENRIPADA | 251011153 | Anggota |
| 6 | KAYLA CHANDRA | 251011138 | Anggota |
| 7 | NUR HIKMATUL AULIA | 251011152 | Anggota |
| 8 | PUTRI MARSALIA | 251011140 | Anggota |
| 9 | ANGGUN LISSOLATI | 251011049 | Anggota |
| 10 | SUCI RAMADHANI | 251011029 | Anggota |

---

## 🧭 Ringkasan Distro

| Item | Detail |
|---|---|
| Nama distro | Host Container Mini |
| Tipe | Distro pengembang container |
| Base | Ubuntu 22.04.5 LTS (Jammy) |
| Arsitektur | x86_64 |
| Desktop | XFCE4 + LightDM |
| Kernel | 5.15.0-204-generic |
| Boot splash | Plymouth tema kustom `distro-splash` |
| Autologin | Ya (user live `ubuntu`, sesi XFCE) |
| Fitur khusus | **B3**: info namespace dan cgroup suatu proses |
| Zona waktu | Asia/Makassar |
| Alat build | Cubic (Custom Ubuntu ISO Creator) |
| Ukuran ISO | 4,47 GiB (4.801.179.648 byte) |

Ringkasan konfigurasi lengkap: [`tahap 1/konfigurasi/konfigurasi-sistem.txt`](tahap%201/konfigurasi/konfigurasi-sistem.txt).

---

## 📈 Progres Pengembangan

| Tahap | Fokus | Status | Dokumentasi |
|---|---|---|---|
| **Tahap 1** | Remastering Ubuntu dengan Cubic, XFCE + LightDM, autologin, wallpaper, Plymouth, 10 paket container, branding, skrip B3 | ✅ Selesai | [Folder `tahap 1/`](tahap%201/) |
| **Tahap 2** | Pengembangan lanjutan | ⏳ Menyusul | - |

---

## 📦 Paket yang Dipasang (10 Paket)

| No | Paket | Fungsi | Alasan dipilih |
|---|---|---|---|
| 1 | `runc` | Runtime container standar OCI | Inti untuk menjalankan container |
| 2 | `iproute2` | Perintah `ip` | Mengatur network namespace dan veth |
| 3 | `cgroup-tools` | `cgcreate`, `cgexec`, dll. | Membuat dan mengelola cgroup |
| 4 | `containerd` | Manajer siklus hidup container | Memakai `runc` di bawahnya |
| 5 | `iptables` | Firewall dan NAT | Aturan jaringan untuk container |
| 6 | `bridge-utils` | Perintah `brctl` | Membuat bridge jaringan container |
| 7 | `busybox` | Kumpulan utilitas mini | Rootfs mini untuk container uji |
| 8 | `curl` | Klien HTTP | Uji koneksi dan unduh rootfs |
| 9 | `htop` | Monitor proses | Memantau penggunaan sumber daya |
| 10 | `vim` | Editor teks | Menyunting konfigurasi |

Perintah pemasangan:

```bash
apt install -y runc iproute2 cgroup-tools containerd iptables bridge-utils busybox curl htop vim
```

### Paket yang Dihapus

GNOME dan aplikasi berat dihapus agar sistem lebih ringan dan tidak bentrok dengan XFCE + LightDM.

| Paket | Jenis | Alasan dihapus |
|---|---|---|
| `ubuntu-desktop` | Metapaket desktop GNOME | Diganti XFCE |
| `gnome-shell` | Shell desktop GNOME | Diganti XFCE |
| `gdm3` | Display manager GNOME | Diganti LightDM |
| `libreoffice*` | Paket office | Berat dan tidak relevan dengan tema container |
| `rhythmbox*` | Pemutar musik | Tidak relevan dengan tema |
| `thunderbird*` | Klien email | Tidak relevan dengan tema |
| `aisleriot` | Permainan kartu | Tidak relevan dengan tema |
| `gnome-mahjongg` | Permainan | Tidak relevan dengan tema |
| `gnome-mines` | Permainan | Tidak relevan dengan tema |
| `gnome-sudoku` | Permainan | Tidak relevan dengan tema |

Perintah penghapusan:

```bash
apt purge -y ubuntu-desktop gnome-shell gdm3 \
  libreoffice* rhythmbox* thunderbird* \
  aisleriot gnome-mahjongg gnome-mines gnome-sudoku
apt autoremove -y
```

Setelah itu `ubiquity`, `ubiquity-frontend-gtk`, dan `casper` dipasang ulang agar installer dan mode Live tetap utuh.

Daftar lengkap (termasuk paket dasar sistem): [`tahap 1/daftar-paket.txt`](tahap%201/daftar-paket.txt).

---

## 🔍 Fitur B3: Info Namespace dan Cgroup

Distro ini membawa tiga komponen untuk fitur B3:

| Komponen | Lokasi | Fungsi |
|---|---|---|
| `first-login.sh` | `/usr/local/bin/first-login.sh` | Saat login pertama, menampilkan sambutan, `uname -a`, namespace, dan cgroup proses saat ini |
| `container-info` | `/usr/local/bin/container-info` | Menampilkan namespace dan cgroup untuk PID tertentu |
| `first-login.desktop` | `/etc/skel/.config/autostart/` | Menjalankan `first-login.sh` otomatis saat desktop dimulai |

Cara pakai:

```bash
container-info          # untuk proses shell saat ini
container-info 1        # untuk proses init (PID 1)
container-info <PID>    # untuk proses lain
```

Contoh keluaran `container-info 1`:

```
=== Namespace PID 1 ===
lrwxrwxrwx 1 root root 0 ... cgroup -> 'cgroup:[4026532321]'
lrwxrwxrwx 1 root root 0 ... ipc    -> 'ipc:[4026532319]'
lrwxrwxrwx 1 root root 0 ... mnt    -> 'mnt:[4026532317]'
lrwxrwxrwx 1 root root 0 ... net    -> 'net:[4026531840]'
lrwxrwxrwx 1 root root 0 ... pid    -> 'pid:[4026532320]'
lrwxrwxrwx 1 root root 0 ... uts    -> 'uts:[4026532318]'
...
=== Cgroup PID 1 ===
0::/
```

---

## 🎨 Kustomisasi Tampilan

| Elemen | Cara |
|---|---|
| Wallpaper desktop | `/usr/share/backgrounds/distro-custom/wallpaper-distro.jpg`, diatur lewat `xfce4-desktop.xml` di `/etc/skel` |
| Wallpaper layar login | `/etc/lightdm/lightdm-gtk-greeter.conf` |
| Boot splash | Tema Plymouth `distro-splash` (script module) dengan `logo-distro.png` |
| Nama distro | `/etc/os-release` dan `/etc/lsb-release` diubah menjadi "Host Container Mini" (`ID_LIKE=debian` dan `VERSION_CODENAME=jammy` tidak diubah) |
| Autologin | `/etc/lightdm/lightdm.conf.d/50-live-autologin.conf` |

Berkas gambar ada di [`tahap 1/assets/`](tahap%201/assets/).

---

## 🔧 Cara Build dengan Cubic

### Persiapan
- VM Ubuntu 22.04 di VirtualBox: RAM 3 GB, 2 CPU, disk 50 GB.
- Shared folder VirtualBox (Guest Additions terpasang).
- Bahan: ISO `ubuntu-22.04.5-desktop-amd64.iso`, `logo-distro.png`, `wallpaper-distro.jpg`.

### Langkah singkat

1. **Salin bahan ke disk VM** (jangan jalankan Cubic langsung di shared folder):
   ```bash
   mkdir -p ~/cubic-proyek ~/assets
   rsync -ah --progress /media/sf_Proyek_5/ubuntu-22.04.5-desktop-amd64.iso ~/cubic-proyek/
   cp /media/sf_Proyek_5/logo-distro.png /media/sf_Proyek_5/wallpaper-distro.jpg ~/assets/
   ```
2. **Pasang Cubic:**
   ```bash
   sudo apt-add-repository universe
   sudo apt-add-repository ppa:cubic-wizard/release
   sudo apt update && sudo apt install -y cubic
   ```
3. **Buat proyek di Cubic:** project directory `~/cubic-proyek`, pilih ISO lokal, isi Filename `host-container-mini.iso` dan Volume ID `HostContainerMini`.
4. **Di terminal Cubic (chroot):** jalankan langkah berikut secara manual, atau sekaligus lewat skrip [`tahap 1/skrip/instalasi.sh`](tahap%201/skrip/instalasi.sh) (*drag-and-drop* `instalasi.sh`, `wallpaper-distro.jpg`, dan `logo-distro.png` ke terminal Cubic, klik **Copy**, lalu `bash instalasi.sh`).
   1. Update repo (`universe`, `multiverse`)
   2. Pasang XFCE + LightDM, hapus GNOME dan aplikasi berat
   3. Atur autologin
   4. Pasang wallpaper dan konfigurasi desktop/login
   5. Buat tema Plymouth, lalu `update-initramfs -u -k all`
   6. Pasang 10 paket, branding, zona waktu, skrip B3
   7. Bersihkan cache (`apt clean`)
5. **Generate:** tab Packages dibiarkan default, tab Kernel pilih `5.15.0-204-generic`, tab Compression pilih `gzip`, lalu klik **Generate**.

---

## ✅ Pengujian

Pengujian dilakukan di VM baru (RAM 2-3 GB, 2 CPU, disk 25 GB, grafis VMSVGA), pertama dalam mode Live, lalu setelah instalasi ke disk.

| No | Yang diuji | Hasil | Bukti |
|---|---|---|---|
| 1 | Logo Plymouth muncul saat boot | ✅ | [Gambar 15](tahap%201/screenshots/15.png) |
| 2 | Autologin langsung ke XFCE (mode Live) | ☐ | Gambar _ |
| 3 | Wallpaper kustom tampil | ✅ | [Gambar 16](tahap%201/screenshots/16.png) |
| 4 | Jendela first-login (namespace + cgroup) | ☐ | Gambar _ |
| 5 | `runc --version`, `ip a` | ☐ | Gambar _ |
| 6 | `container-info 1` | ☐ | Gambar _ |
| 7 | `cat /etc/os-release` menampilkan "Host Container Mini" | ☐ | Gambar _ |
| 8 | Instalasi ke disk berhasil, login sebagai `uji` | ✅ | [Gambar 16](tahap%201/screenshots/16.png), [Gambar 17](tahap%201/screenshots/17.png) |
| 9 | Layar login LightDM dengan wallpaper kustom, login berhasil | ☐ | Gambar _ |

> Ganti ☐ dengan ✅ dan isi nomor gambar setelah diuji. Klik nomor gambar untuk membuka file-nya, atau lihat galeri di bawah.

### Galeri screenshot

Klik gambar untuk membukanya dalam ukuran penuh. Semua tangkapan layar ada di [`tahap 1/screenshots/`](tahap%201/screenshots/).

<table>
  <tr>
    <td align="center"><a href="tahap%201/screenshots/1.png"><img src="tahap%201/screenshots/1.png" width="250"><br>Gambar 1</a></td>
    <td align="center"><a href="tahap%201/screenshots/2.png"><img src="tahap%201/screenshots/2.png" width="250"><br>Gambar 2</a></td>
    <td align="center"><a href="tahap%201/screenshots/3.png"><img src="tahap%201/screenshots/3.png" width="250"><br>Gambar 3</a></td>
  </tr>
  <tr>
    <td align="center"><a href="tahap%201/screenshots/4.png"><img src="tahap%201/screenshots/4.png" width="250"><br>Gambar 4</a></td>
    <td align="center"><a href="tahap%201/screenshots/5.png"><img src="tahap%201/screenshots/5.png" width="250"><br>Gambar 5</a></td>
    <td align="center"><a href="tahap%201/screenshots/6.png"><img src="tahap%201/screenshots/6.png" width="250"><br>Gambar 6</a></td>
  </tr>
  <tr>
    <td align="center"><a href="tahap%201/screenshots/7.png"><img src="tahap%201/screenshots/7.png" width="250"><br>Gambar 7</a></td>
    <td align="center"><a href="tahap%201/screenshots/8.png"><img src="tahap%201/screenshots/8.png" width="250"><br>Gambar 8</a></td>
    <td align="center"><a href="tahap%201/screenshots/9.png"><img src="tahap%201/screenshots/9.png" width="250"><br>Gambar 9</a></td>
  </tr>
  <tr>
    <td align="center"><a href="tahap%201/screenshots/10.png"><img src="tahap%201/screenshots/10.png" width="250"><br>Gambar 10</a></td>
    <td align="center"><a href="tahap%201/screenshots/11.png"><img src="tahap%201/screenshots/11.png" width="250"><br>Gambar 11</a></td>
    <td align="center"><a href="tahap%201/screenshots/12.png"><img src="tahap%201/screenshots/12.png" width="250"><br>Gambar 12</a></td>
  </tr>
  <tr>
    <td align="center"><a href="tahap%201/screenshots/13.png"><img src="tahap%201/screenshots/13.png" width="250"><br>Gambar 13</a></td>
    <td align="center"><a href="tahap%201/screenshots/14.png"><img src="tahap%201/screenshots/14.png" width="250"><br>Gambar 14</a></td>
    <td align="center"><a href="tahap%201/screenshots/15.png"><img src="tahap%201/screenshots/15.png" width="250"><br>Gambar 15</a></td>
  </tr>
  <tr>
    <td align="center"><a href="tahap%201/screenshots/16.png"><img src="tahap%201/screenshots/16.png" width="250"><br>Gambar 16</a></td>
    <td align="center"><a href="tahap%201/screenshots/17.png"><img src="tahap%201/screenshots/17.png" width="250"><br>Gambar 17</a></td>
    <td></td>
  </tr>
</table>

---

## 💿 Download ISO

ISO berukuran 4,47 GiB sehingga tidak bisa diunggah ke GitHub (batas 100 MB per file).

| Item | Nilai |
|---|---|
| Link unduh | `ISI_LINK_GOOGLE_DRIVE_ATAU_ONEDRIVE` |
| Nama file | `host-container-mini.iso` |
| Ukuran | 4.801.179.648 byte |
| MD5 | `5b4f58fa05c1dc19fedc80492c8b6af9` |

Verifikasi setelah mengunduh:

```bash
md5sum host-container-mini.iso
```

Windows (PowerShell): `Get-FileHash host-container-mini.iso -Algorithm MD5`

---

## 📂 Struktur Repositori

```
Proyek_Sisitem_Operasi/
├── README.md
└── tahap 1/
    ├── assets/
    │   ├── logo-distro.png
    │   └── wallpaper-distro.jpg
    │
    ├── konfigurasi/
    │   └── konfigurasi-sistem.txt
    │
    ├── screenshots/
    │   ├── 1.png
    │   ├── 2.png
    │   ├── ...
    │   └── 17.png
    │
    ├── skrip/
    │   └── instalasi.sh
    │
    └── daftar-paket.txt
```

| Berkas / folder | Isi |
|---|---|
| `tahap 1/assets/` | Logo boot splash dan wallpaper |
| `tahap 1/konfigurasi/konfigurasi-sistem.txt` | Ringkasan konfigurasi sistem |
| `tahap 1/screenshots/` | Dokumentasi proses build dan pengujian (17 gambar) |
| `tahap 1/skrip/instalasi.sh` | Seluruh perintah build di chroot Cubic |
| `tahap 1/daftar-paket.txt` | Daftar paket dan alasan pemilihan |

---

## 📝 Catatan dan Kendala

| Masalah | Penyebab | Solusi |
|---|---|---|
| Shared folder tidak muncul di Ubuntu | Guest Additions belum terpasang | `apt install virtualbox-guest-utils virtualbox-guest-x11`, tambah user ke grup `vboxsf`, reboot |
| Salinan ISO terhenti di tengah | `Ctrl+C` tertekan / disk VM penuh | Perbesar disk, salin ulang dengan `rsync --progress` |
| Disk VM kurang untuk Cubic | Disk awal hanya 20 GB | Perbesar ke 50 GB (Virtual Media Manager + GParted) |
| Peringatan `cryptsetup` saat `update-initramfs` | Lingkungan chroot tidak punya `/dev/sda3` | Aman diabaikan |
| Init system | Ubuntu memakai systemd, bukan BusyBox init | Paket `busybox` tetap dipasang sebagai utilitas dan rootfs uji. Konfirmasi ke dosen bila BusyBox init wajib |

---

## 📜 Lisensi

Distro ini adalah turunan Ubuntu dan mengikuti lisensi masing-masing paket yang disertakan. Proyek dibuat untuk keperluan pendidikan.
