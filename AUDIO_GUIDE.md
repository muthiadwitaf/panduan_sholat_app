# Panduan Audio untuk Aplikasi Panduan Sholat

## 📁 Struktur Folder Audio

```
assets/
└── audio/
    ├── prayer/          # Audio bacaan sholat (19 files)
    ├── doa/             # Audio doa harian (78 files)
    └── wudhu/           # Audio bacaan wudhu (10 files)
```

## 🎵 Format Audio yang Didukung

Aplikasi ini mendukung berbagai format audio:
- **MP3** - Format paling umum, kompatibel dengan semua platform
- **M4A** - Format AAC, kualitas bagus dengan ukuran kecil
- **OGG** - Format open source, kualitas bagus

## 📝 Daftar File Audio

### Audio Bacaan Sholat (19 files)

| No | Nama File | Format | Keterangan |
|----|-----------|--------|------------|
| 1 | `niat.mp3` | MP3 | Niat sholat |
| 2 | `takbir.m4a` | M4A | Takbiratul ihram |
| 3 | `iftitah.mp3` | MP3 | Doa iftitah |
| 4 | `fatihah.ogg` | OGG | Surat Al-Fatihah |
| 5 | `surat.mp3` | MP3 | Surat pendek |
| 6 | `ruku.m4a` | M4A | Bacaan ruku |
| 7 | `itidal.mp3` | MP3 | Bacaan i'tidal |
| 8 | `sujud.ogg` | OGG | Bacaan sujud |
| 9 | `duduk_sujud.mp3` | MP3 | Duduk antara dua sujud |
| 10 | `tasyahud_awal.m4a` | M4A | Tahiyat awal |
| 11 | `tasyahud_akhir.mp3` | MP3 | Tahiyat akhir |
| 12 | `salam.ogg` | OGG | Salam |
| 13 | `qunut.mp3` | MP3 | Doa qunut |
| 14 | `takbir_jenazah_1.m4a` | M4A | Takbir jenazah pertama |
| 15 | `takbir_jenazah_2.mp3` | MP3 | Takbir jenazah kedua |
| 16 | `takbir_jenazah_3.ogg` | OGG | Takbir jenazah ketiga |
| 17 | `takbir_jenazah_4.mp3` | MP3 | Takbir jenazah keempat |
| 18 | `takbir_extra.m4a` | M4A | Takbir tambahan |
| 19 | `tasbih.mp3` | MP3 | Bacaan tasbih |

### Audio Doa Harian (78 files)

Lihat file lengkap di folder `assets/audio/doa/` yang mencakup:
- Doa pagi & petang
- Doa harian (bangun tidur, sebelum tidur, makan, dll)
- Doa rezeki
- Doa kesehatan
- Doa perjalanan
- Doa ilmu
- Doa waktu tertentu
- Doa kualitas diri
- Doa pernikahan & rumah tangga
- Doa hamil & persalinan

### Audio Wudhu (10 files)

| No | Nama File | Format | Keterangan |
|----|-----------|--------|------------|
| 1 | `niat_wudhu.mp3` | MP3 | Niat wudhu |
| 2 | `basuh_tangan.m4a` | M4A | Membasuh tangan |
| 3 | `berkumur.mp3` | MP3 | Berkumur |
| 4 | `istinsyaq.ogg` | OGG | Menghirup air ke hidung |
| 5 | `basuh_muka.mp3` | MP3 | Membasuh muka |
| 6 | `basuh_tangan_siku.m4a` | M4A | Membasuh tangan sampai siku |
| 7 | `usap_kepala.mp3` | MP3 | Mengusap kepala |
| 8 | `usap_telinga.ogg` | OGG | Mengusap telinga |
| 9 | `basuh_kaki.mp3` | MP3 | Membasuh kaki |
| 10 | `doa_setelah_wudhu.m4a` | M4A | Doa setelah wudhu |

## 🔄 Cara Mengganti File Audio Placeholder

File-file audio yang ada saat ini adalah **PLACEHOLDER KOSONG**. Untuk mengganti dengan audio asli:

1. **Siapkan file audio asli** dalam format MP3, M4A, atau OGG
2. **Pastikan nama file sama persis** dengan yang tercantum di daftar di atas
3. **Ganti file placeholder** dengan file audio asli Anda
4. **Rebuild aplikasi** dengan perintah:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

## 📏 Rekomendasi Kualitas Audio

Untuk hasil terbaik, gunakan spesifikasi berikut:

- **Sample Rate**: 44.1 kHz
- **Bitrate**: 128 kbps (MP3) atau 96 kbps (M4A/OGG)
- **Channels**: Mono (untuk menghemat ukuran file)
- **Durasi**: Sesuaikan dengan panjang bacaan (umumnya 10-60 detik)

## 🎯 Cara Menggunakan Fitur Audio di Aplikasi

### Untuk User:

1. Buka aplikasi dan navigasi ke halaman Panduan Sholat atau Doa Harian
2. Pilih bacaan yang ingin didengarkan
3. Klik tombol **Play** (▶️) untuk memutar audio
4. Klik tombol **Pause** (⏸️) untuk menghentikan sementara
5. Audio akan otomatis berhenti saat pindah ke halaman lain

### Untuk Developer:

Untuk menambahkan tombol audio di UI:

```dart
import 'package:panduan_sholat_app/widgets/audio_button.dart';

// Tombol audio sederhana
AudioButton(
  audioPath: prayerStep.audioPath,
  size: 48,
  color: Colors.green,
)

// Mini audio player dengan kontrol lengkap
MiniAudioPlayer(
  audioPath: doaItem.audioPath,
  title: doaItem.title,
)
```

## ⚠️ Catatan Penting

1. **Ukuran APK**: Menambahkan semua file audio akan meningkatkan ukuran APK secara signifikan. Pastikan total ukuran audio tidak melebihi 50 MB.

2. **Lisensi Audio**: Pastikan Anda memiliki hak untuk menggunakan file audio yang digunakan dalam aplikasi.

3. **Testing**: Selalu test audio di device fisik, karena emulator mungkin memiliki masalah dengan beberapa format audio.

4. **Alternatif TTS**: Jika ukuran file terlalu besar, pertimbangkan menggunakan Text-to-Speech (TTS) untuk generate audio secara dinamis.

## 🐛 Troubleshooting

### Audio tidak terputar
- Pastikan file audio ada di folder yang benar
- Cek nama file sesuai dengan yang ada di JSON
- Cek format audio didukung (MP3, M4A, OGG)

### Audio terputus-putus
- Kurangi bitrate audio
- Gunakan format yang lebih efisien (M4A atau OGG)

### Ukuran APK terlalu besar
- Kompres file audio dengan bitrate lebih rendah
- Gunakan format OGG yang lebih efisien
- Pertimbangkan menggunakan TTS sebagai alternatif

## 📞 Support

Jika ada pertanyaan atau masalah terkait audio, silakan hubungi developer atau buat issue di repository.
