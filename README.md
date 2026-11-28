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
12. [Sumber dan Referensi](#-sumber-dan-referensi)

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
| Kernel | 5.15.0-204-generic (dipilih di tab Kernel Cubic) |
| Boot splash | Plymouth tema kustom `distro-splash` |
| Autologin | Ya (user live `ubuntu`, sesi XFCE) |
| Fitur khusus | **B3**: info namespace dan cgroup suatu proses |
| Zona waktu | Asia/Makassar |
| Alat build | Cubic (Custom Ubuntu ISO Creator) |
| Ukuran ISO | 4,47 GiB (4.801.540.096 byte) |

Ringkasan konfigurasi lengkap: [`tahap 1/konfigurasi/konfigurasi-sistem.txt`](tahap%201/konfigurasi/konfigurasi-sistem.txt).

---

## 📈 Progres Pengembangan

| Tahap | Fokus | Status | Dokumentasi |
|---|---|---|---|
| **Tahap 1** | Remastering Ubuntu dengan Cubic, XFCE + LightDM, autologin, wallpaper, background login, Plymouth, 10 paket container, branding, skrip B3 | ✅ Selesai | [Folder `tahap 1/`](tahap%201/) |
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

> Untuk memeriksa proses milik root (misalnya PID 1), jalankan dengan `sudo container-info 1`. Tanpa `sudo`, namespace PID 1 tidak bisa dibaca oleh pengguna biasa dan muncul `Permission denied`. Proses milik pengguna sendiri bisa diperiksa tanpa `sudo`.

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

Tema visual: **paus pembawa tumpukan container** (terinspirasi tema container/Docker, digambar sendiri dengan palet warna berbeda). Logo dan kedua background memakai palet yang senada (biru, cyan, tosca, coral).

| Elemen | Berkas | Cara |
|---|---|---|
| Wallpaper desktop | `/usr/share/backgrounds/distro-custom/wallpaper-distro.jpg` (1920×1080) | Diatur lewat `xfce4-desktop.xml` di `/etc/skel` |
| Background layar login | `/usr/share/backgrounds/distro-custom/login-bg.jpg` (1920×1080) | Baris `background=` di `/etc/lightdm/lightdm-gtk-greeter.conf`; sengaja berbeda dari wallpaper desktop |
| Boot splash | `/usr/share/plymouth/themes/distro-splash/logo-distro.png` (256×256, PNG transparan) | Tema Plymouth `distro-splash` (script module), lalu `update-initramfs -u -k all` |
| Nama distro | `/etc/os-release` dan `/etc/lsb-release` | Diubah menjadi "Host Container Mini" (`ID_LIKE=debian` dan `VERSION_CODENAME=jammy` tidak diubah). `PRETTY_NAME` ditimpa Cubic saat generate ISO (lihat [Catatan](#-catatan-dan-kendala)) |
| Autologin | `/etc/lightdm/lightdm.conf.d/50-live-autologin.conf` | Autologin user live `ubuntu` |

Berkas gambar ada di [`tahap 1/assets/`](tahap%201/assets/).

---

## 🔧 Cara Build dengan Cubic

### Persiapan
- VM Ubuntu 22.04 di VirtualBox: RAM 3 GB, 2 CPU, disk 50 GB.
- Shared folder VirtualBox (Guest Additions terpasang).
- Bahan: ISO `ubuntu-22.04.5-desktop-amd64.iso`, `logo-distro.png`, `wallpaper-distro.jpg`, `login-bg.jpg`.

### Langkah singkat

1. **Salin bahan ke disk VM** (jangan jalankan Cubic langsung di shared folder):
   ```bash
   mkdir -p ~/cubic-proyek ~/assets
   rsync -ah --progress /media/sf_Proyek_5/ubuntu-22.04.5-desktop-amd64.iso ~/cubic-proyek/
   cp /media/sf_Proyek_5/logo-distro.png /media/sf_Proyek_5/wallpaper-distro.jpg /media/sf_Proyek_5/login-bg.jpg ~/assets/
   ```
2. **Pasang Cubic:**
   ```bash
   sudo apt-add-repository universe
   sudo apt-add-repository ppa:cubic-wizard/release
   sudo apt update && sudo apt install -y cubic
   ```
3. **Buat proyek di Cubic:** project directory `~/cubic-proyek`, pilih ISO lokal, isi Filename `host-container-mini.iso` dan Volume ID `HostContainerMini`.
4. **Di terminal Cubic (chroot):** jalankan langkah berikut secara manual, atau sekaligus lewat skrip [`tahap 1/skrip/instalasi.sh`](tahap%201/skrip/instalasi.sh) (*drag-and-drop* `instalasi.sh`, `wallpaper-distro.jpg`, `login-bg.jpg`, dan `logo-distro.png` ke terminal Cubic, klik **Copy**, lalu `bash instalasi.sh`).
   1. Update repo (`universe`, `multiverse`)
   2. Pasang XFCE + LightDM, hapus GNOME dan aplikasi berat
   3. Atur autologin
   4. Pasang wallpaper desktop dan background login, lalu arahkan `lightdm-gtk-greeter.conf`
   5. Buat tema Plymouth dengan logo baru, lalu `update-initramfs -u -k all`
   6. Pasang 10 paket, branding, zona waktu, skrip B3
   7. Bersihkan cache (`apt clean`)
5. **Generate:** tab Packages dibiarkan default, tab Kernel pilih `5.15.0-204-generic`, tab Compression pilih `gzip`, lalu klik **Generate**.

### Mengganti tampilan pada proyek yang sudah ada

Buka kembali proyek `~/cubic-proyek` di Cubic sampai terminal `root@cubic` muncul, lalu:

```bash
cd /usr/share/backgrounds/distro-custom
rm -f wallpaper-distro.jpg login-bg.jpg
# seret wallpaper-distro.jpg dan login-bg.jpg ke terminal Cubic, klik Copy
chmod 755 /usr/share/backgrounds/distro-custom
chmod 644 /usr/share/backgrounds/distro-custom/*.jpg
sed -i 's#^background=.*#background=/usr/share/backgrounds/distro-custom/login-bg.jpg#' /etc/lightdm/lightdm-gtk-greeter.conf

cd /usr/share/plymouth/themes/distro-splash
rm -f logo-distro.png
# seret logo-distro.png ke terminal Cubic, klik Copy
chmod 644 logo-distro.png
update-initramfs -u -k all
```

Lalu Generate ulang dengan kernel `5.15.0-204-generic` dan kompresi `gzip`.

---

## ✅ Pengujian

Pengujian dilakukan pada ISO hasil build ulang (`host-container-mini.iso`, tampilan baru) di VM baru VirtualBox (RAM 2 GB, disk virtual 25 GB), dimulai dari boot ISO lalu instalasi ke disk virtual. Gambar 1-14 (proses build) diambil pada build pertama tanggal 25 November 2026. Build ulang tanggal 28 November hanya mengganti wallpaper, background login, dan logo boot.

Keterangan status: ✅ sudah diuji dan ada buktinya, ⏳ belum diuji atau belum ada tangkapan layar.

| No | Yang diuji | Hasil | Bukti |
|---|---|---|---|
| 1 | Proses build ISO di Cubic (terminal chroot, `update-initramfs`, Generate) | ✅ | [Gambar 1](tahap%201/screenshots/1.png) sampai [Gambar 14](tahap%201/screenshots/14.png) |
| 2 | ISO baru bisa boot dan layar Welcome installer tampil | ✅ | [Gambar 15](tahap%201/screenshots/15.png) |
| 3 | Installer berjalan: pilih keyboard, jenis instalasi (Minimal), dan pembuatan akun | ✅ | [Gambar 16](tahap%201/screenshots/16.png), [Gambar 17](tahap%201/screenshots/17.png), [Gambar 18](tahap%201/screenshots/18.png) |
| 4 | Instalasi ke disk berhasil, login ke desktop XFCE dengan wallpaper kustom baru (sistem terinstal) | ✅ | [Gambar 22](tahap%201/screenshots/22.png) |
| 5 | Logo Plymouth baru muncul saat boot | ⏳ | - |
| 6 | Jendela first-login (sambutan, namespace, cgroup) | ⏳ | - |
| 7 | `runc --version`, `ip a` | ⏳ | - |
| 8 | `container-info 1` (dengan dan tanpa `sudo`) | ⏳ | - |
| 9 | `cat /etc/os-release` menampilkan `NAME="Host Container Mini"` | ⏳ | - |
| 10 | Layar login LightDM dengan background login kustom (sistem terinstal) | ⏳ | - |

### Galeri screenshot

Klik gambar untuk membukanya dalam ukuran penuh. Semua tangkapan layar ada di [`tahap 1/screenshots/`](tahap%201/screenshots/).

#### Pengujian ISO baru

<table>
  <tr>
    <td align="center" valign="top"><a href="tahap%201/screenshots/15.png"><img src="tahap%201/screenshots/15.png" width="250"><br><b>Gambar 15</b></a><br>Layar Welcome installer</td>
    <td align="center" valign="top"><a href="tahap%201/screenshots/16.png"><img src="tahap%201/screenshots/16.png" width="250"><br><b>Gambar 16</b></a><br>Installer: Keyboard layout</td>
    <td align="center" valign="top"><a href="tahap%201/screenshots/17.png"><img src="tahap%201/screenshots/17.png" width="250"><br><b>Gambar 17</b></a><br>Installer: pilih Minimal installation</td>
  </tr>
  <tr>
    <td align="center" valign="top"><a href="tahap%201/screenshots/18.png"><img src="tahap%201/screenshots/18.png" width="250"><br><b>Gambar 18</b></a><br>Installer: Who are you?</td>
    <td align="center" valign="top"><a href="tahap%201/screenshots/22.png"><img src="tahap%201/screenshots/22.png" width="250"><br><b>Gambar 22</b></a><br>Desktop sistem terinstal, wallpaper paus baru</td>
  </tr>
</table>

#### Proses build dan persiapan (Gambar 1-14)

<details>
<summary>Tampilkan Gambar 1-14</summary>

<table>
  <tr>
    <td align="center" valign="top"><a href="tahap%201/screenshots/1.png"><img src="tahap%201/screenshots/1.png" width="250"><br><b>Gambar 1</b></a><br>Menambah repositori universe</td>
    <td align="center" valign="top"><a href="tahap%201/screenshots/2.png"><img src="tahap%201/screenshots/2.png" width="250"><br><b>Gambar 2</b></a><br>Menambah PPA Cubic</td>
    <td align="center" valign="top"><a href="tahap%201/screenshots/3.png"><img src="tahap%201/screenshots/3.png" width="250"><br><b>Gambar 3</b></a><br>apt update setelah PPA Cubic</td>
  </tr>
  <tr>
    <td align="center" valign="top"><a href="tahap%201/screenshots/4.png"><img src="tahap%201/screenshots/4.png" width="250"><br><b>Gambar 4</b></a><br>Memasang Cubic (apt install)</td>
    <td align="center" valign="top"><a href="tahap%201/screenshots/5.png"><img src="tahap%201/screenshots/5.png" width="250"><br><b>Gambar 5</b></a><br>Cubic terpasang, layar awal</td>
    <td align="center" valign="top"><a href="tahap%201/screenshots/6.png"><img src="tahap%201/screenshots/6.png" width="250"><br><b>Gambar 6</b></a><br>Pengaturan proyek: nama ISO, Volume ID, Release</td>
  </tr>
  <tr>
    <td align="center" valign="top"><a href="tahap%201/screenshots/7.png"><img src="tahap%201/screenshots/7.png" width="250"><br><b>Gambar 7</b></a><br>Cubic mengekstrak ISO induk</td>
    <td align="center" valign="top"><a href="tahap%201/screenshots/8.png"><img src="tahap%201/screenshots/8.png" width="250"><br><b>Gambar 8</b></a><br>Daftar paket snap (tidak ada yang dihapus)</td>
    <td align="center" valign="top"><a href="tahap%201/screenshots/9.png"><img src="tahap%201/screenshots/9.png" width="250"><br><b>Gambar 9</b></a><br>Terminal chroot Cubic (root@cubic)</td>
  </tr>
  <tr>
    <td align="center" valign="top"><a href="tahap%201/screenshots/10.png"><img src="tahap%201/screenshots/10.png" width="250"><br><b>Gambar 10</b></a><br>apt update di dalam chroot</td>
    <td align="center" valign="top"><a href="tahap%201/screenshots/11.png"><img src="tahap%201/screenshots/11.png" width="250"><br><b>Gambar 11</b></a><br>Isi /etc/casper.conf</td>
    <td align="center" valign="top"><a href="tahap%201/screenshots/12.png"><img src="tahap%201/screenshots/12.png" width="250"><br><b>Gambar 12</b></a><br>Pilihan paket yang dihapus saat instalasi</td>
  </tr>
  <tr>
    <td align="center" valign="top"><a href="tahap%201/screenshots/13.png"><img src="tahap%201/screenshots/13.png" width="250"><br><b>Gambar 13</b></a><br>Tab Kernel: 5.15.0-204-generic dipilih</td>
    <td align="center" valign="top"><a href="tahap%201/screenshots/14.png"><img src="tahap%201/screenshots/14.png" width="250"><br><b>Gambar 14</b></a><br>Generate ISO selesai (build pertama, 25 Nov 2026)</td>
  </tr>
</table>

</details>

---

## 💿 Download ISO

ISO berukuran 4,47 GiB sehingga tidak bisa diunggah ke GitHub (batas 100 MB per file).

| Item | Nilai |
|---|---|
| Link unduh | `ISI_LINK_GOOGLE_DRIVE_ATAU_ONEDRIVE` |
| Nama file | `host-container-mini.iso` |
| Ukuran | 4.801.540.096 byte |
| MD5 | `c236a36c63c9756b8faa4756cb4a407f` |

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
    │   ├── wallpaper-distro.jpg
    │   └── login-bg.jpg
    │
    ├── konfigurasi/
    │   └── konfigurasi-sistem.txt
    │
    ├── screenshots/
    │   ├── 1.png
    │   ├── 2.png
    │   ├── ...
    │   ├── 18.png
    │   └── 22.png
    │
    ├── skrip/
    │   └── instalasi.sh
    │
    └── daftar-paket.txt
```

| Berkas / folder | Isi |
|---|---|
| `tahap 1/assets/` | Logo boot splash, wallpaper desktop, dan background layar login |
| `tahap 1/konfigurasi/konfigurasi-sistem.txt` | Ringkasan konfigurasi sistem |
| `tahap 1/screenshots/` | Dokumentasi proses build dan pengujian (`1.png` sampai `18.png` dan `22.png`) |
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
| `Permission denied` pada `container-info 1` | `/proc/1/ns` hanya bisa dibaca root | Jalankan `sudo container-info 1` |
| `PRETTY_NAME` bukan "Host Container Mini" | Cubic menimpa deskripsi rilis saat generate ISO | `NAME` tetap "Host Container Mini"; `PRETTY_NAME` mengikuti Volume ID dan waktu build Cubic |
| Kernel sesi Live bisa berbeda dengan sistem terinstal | Instalasi ke disk dapat memasang kernel yang berbeda dari kernel sesi Live | Dicatat saja. Fitur container tetap berjalan |
| Logo dan background tidak berubah setelah build ulang | Berkas lama belum terhapus, atau `update-initramfs` terlewat | Hapus berkas lama dengan `rm -f` sebelum menyalin yang baru, lalu jalankan `update-initramfs -u -k all` setelah mengganti logo |
| Desktop akun uji masih menampilkan wallpaper lama | Pengaturan XFCE sudah tersimpan sejak login pertama | Klik kanan desktop, pilih Desktop Settings, lalu pilih `wallpaper-distro.jpg` |

---

## 📚 Sumber dan Referensi

- Panduan Build Distro Kustom Tahap 1 (dosen pengampu, mata kuliah Sistem Operasi).
- Ubuntu 22.04.5 LTS (Canonical) sebagai base. Nama dan logo "Ubuntu" tidak dipakai sebagai merek distro ini.
- Cubic (Custom Ubuntu ISO Creator) sebagai alat remaster.
- Logo, wallpaper, dan background login dibuat dengan bantuan AI (Claude, Anthropic), dengan tema paus pembawa container yang terinspirasi dari tema container/Docker. Gambar dibuat sendiri, bukan logo resmi Docker.
- Skrip `first-login.sh` dan `container-info` disusun dengan bantuan AI berdasarkan panduan Tahap 1.
- Dokumentasi ini (README) disusun dengan bantuan AI dari data build dan pengujian kelompok. Semua tangkapan layar berasal dari VM kelompok sendiri.

---

## 📜 Lisensi

Distro ini adalah turunan Ubuntu dan mengikuti lisensi masing-masing paket yang disertakan. Proyek dibuat untuk keperluan pendidikan.
