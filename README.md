# E-Sholat Guide

E-Sholat Guide adalah aplikasi e-learning panduan sholat dan doa harian berbasis Flutter yang dirancang untuk membantu pengguna mempelajari tata cara ibadah secara mandiri, terstruktur, dan mudah diakses melalui berbagai platform.
Aplikasi ini dikembangkan sebagai bagian dari penelitian dengan pendekatan Agile Development Method, serta ditujukan sebagai media pembelajaran keagamaan berbasis digital.

## Fitur Utama

Panduan Sholat Lengkap
=======

Tujuan Aplikasi
- menyediakan panduan sholat yang runtut dan mudah dipahami
- menyajikan kumpulan doa harian dalam satu aplikasi
- mendukung pembelajaran ibadah secara mandiri
- menjadi contoh implementasi e-learning berbasis Flutter


Fitur Utama
Panduan Sholat Lengkap
- 19 langkah sholat dari niat hingga salam (termasuk Sholat Jenazah)
- Bacaan Arab dengan font Amiri yang indah
- Transliterasi Latin untuk memudahkan
- Terjemahan Bahasa Indonesia
- Ilustrasi gerakan sholat
- Label Wajib/Sunnah untuk setiap bacaan

Daftar Sholat & Niat
- Sholat Wajib (Subuh, Dzuhur, Ashar, Maghrib, Isya)
- Sholat Sunnah (Tahajud, Dhuha, Rawatib, dll)
- Niat lengkap untuk setiap jenis sholat
- Detail bacaan dan tata cara

Doa Harian
- 75+ doa sehari-hari (Total 78 doa)
- Kategori: Doa Pagi & Petang, Doa Sehari-hari, Doa Ibadah, Doa Istimewa, dll.
- Pencarian doa
- Filter berdasarkan kategori
- Fitur favorit untuk menyimpan doa favorit

Kuis Interaktif
- 45 soal tentang tata cara sholat dan wudhu
- **3 tingkat kesulitan**: Mudah, Sedang, Susah
- Kategori: Rukun Sholat, Bacaan Sholat, Gerakan Sholat, Tata Cara Wudhu
- Feedback langsung setelah menjawab
- Penjelasan untuk setiap jawaban
- Skor dan rekomendasi pembelajaran

Tata Cara Wudhu
- 10 langkah wudhu dari niat hingga doa sesudah wudhu
- Bacaan Arab, Latin, dan Terjemahan
- Panduan urutan yang benar

Riwayat Belajar
- Tracking progress belajar sholat dan doa
- Statistik waktu belajar
- Ringkasan materi yang sudah dipelajari
- Rekomendasi pembelajaran selanjutnya

Audio Bacaan
- Audio bacaan sholat
- Audio doa harian
- Audio bacaan wudhu

## Struktur Proyek

```
lib/
├── main.dart                      # Entry point aplikasi
├── models/                        # Data models
│   ├── prayer_step.dart           # Model langkah sholat
│   ├── sholat_item.dart           # Model item sholat & niat
│   ├── doa_item.dart              # Model doa
│   ├── quiz_question.dart         # Model soal kuis
│   ├── quiz_result.dart           # Model hasil kuis
│   └── learning_history.dart      # Model riwayat belajar
├── providers/                     # State management (Provider)
│   ├── prayer_provider.dart       # State panduan sholat
│   ├── doa_provider.dart          # State doa & favorit
│   ├── quiz_provider.dart         # State kuis
│   ├── audio_provider.dart        # State audio player
│   └── learning_history_provider.dart  # State riwayat belajar
├── services/                      # Business logic services
│   ├── audio_service.dart         # Service audio playback
│   └── learning_history_service.dart   # Service riwayat belajar
├── screens/                       # UI Screens
│   ├── home_screen.dart           # Beranda
│   ├── sholat_list_screen.dart    # Daftar jenis sholat
│   ├── sholat_detail_screen.dart  # Detail sholat & niat
│   ├── prayer_guide_screen.dart   # Panduan langkah sholat
│   ├── wudhu_guide_screen.dart    # Tata cara wudhu
│   ├── doa_list_screen.dart       # Daftar doa
│   ├── doa_detail_screen.dart     # Detail doa
│   ├── quiz_screen.dart           # Kuis interaktif
│   └── learning_history_screen.dart    # Riwayat belajar
├── widgets/                       # Reusable widgets
│   ├── arabic_text_widget.dart    # Widget teks Arab
│   ├── prayer_card.dart           # Card langkah sholat
│   └── quiz_option_card.dart      # Card pilihan kuis
└── utils/                         # Utilities
    ├── app_colors.dart            # Warna tema Islami
    ├── app_text_styles.dart       # Typography
    └── data_loader.dart           # JSON loader

assets/
├── data/                          # Data JSON
│   ├── prayer_steps.json          # Data langkah sholat
│   ├── sholat_list.json           # Daftar sholat & niat
│   ├── wudhu_steps.json           # Data tata cara wudhu
│   ├── rakaat_patterns.json       # Pola rakaat
│   ├── doa_harian.json            # Data doa harian (78 doa)
│   └── quiz_questions.json        # Data soal kuis
├── images/                        # Gambar
│   ├── app_icon.png
│   └── sholat/                    # Ilustrasi gerakan sholat
└── audio/                         # Audio files
    ├── prayer/                    # Audio bacaan sholat
    ├── doa/                       # Audio doa harian
    └── wudhu/                     # Audio bacaan wudhu
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1           # State management
  shared_preferences: ^2.2.2 # Local storage
  google_fonts: ^6.1.0       # Fonts (Amiri untuk Arab)
  audioplayers: ^5.2.1       # Audio playback
```

Instalasi & Menjalankan

Prerequisite
- Flutter SDK (stable channel)
- Android Studio / VS Code
- Android SDK untuk build Android
- Xcode untuk build iOS (Mac only)

Langkah-langkah

1. **Clone atau extract project**
   ```bash
   cd c:\panduansholat_ebook\panduan_sholat_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi**
   
   **Android:**
   ```bash
   flutter run -d android
   ```
   
   **iOS (Mac only):**
   ```bash
   flutter run -d ios
   ```
   
   **Windows Desktop:**
   ```bash
   flutter run -d windows
   ```

4. **Build APK (Android)**
   ```bash
   flutter build apk --release
   ```
   
   Output: `build/app/outputs/flutter-apk/app-release.apk`

## Tema & Desain

### Warna
- **Primary**: Elegant Teal (#1D5F5F) - warna Islamic yang tenang
- **Accent**: Royal Gold (#D4A84B) - aksen mewah
- **Background**: Warm Cream (#F8F5F0) - lembut di mata
- **Logo**: Soft Sage (#A5C89E) - background logo hijau

### Palette Menu
- **Panduan Sholat**: Teal (#1D5F5F)
- **Kumpulan Doa**: Gold (#D4A84B)
- **Kuis Interaktif**: Purple (#7B68A6)
- **Tata Cara Wudhu**: Blue (#4A7BA7)
- **Riwayat Belajar**: Rose (#B57B8C)

### Font
- **Arabic**: Amiri (Google Fonts)
- **Latin**: Inter (Google Fonts)

## Data Format

### Sholat Item (sholat_list.json)
```json
{
  "id": "subuh",
  "name": "Sholat Subuh",
  "niat": {
    "arabicText": "...",
    "latinText": "...",
    "translation": "..."
  }
}
```

### Doa (doa_harian.json)
```json
{
  "doaList": [
    {
      "id": "doa_pagi_1",
      "title": "Doa Pagi Hari",
      "category": "sunnah_harian",
      "arabicText": "...",
      "transliteration": "...",
      "translation": "...",
      "context": "Dibaca di pagi hari"
    }
  ]
}
```

## Platform Support
- ✅ Android (API 21+)
- ✅ iOS (iOS 12+)
- ✅ Windows Desktop
- ✅ Web

## Version
- **Current Version**: 1.5.0 (Quiz Difficulty Update)

### Changelog
- **v1.5.0** - Tingkat kesulitan kuis (Mudah/Sedang/Susah), 45 soal kuis, Color palette baru
- **v1.4.0** - Fitur Riwayat Belajar, Audio Bacaan, Daftar Sholat & Niat
- **v1.3.1** - Update ilustrasi gerakan sholat
- **v1.3.0** - Fitur Wudhu, Kuis Interaktif
- **v1.2.0** - Doa Favorit, Filter Kategori
- **v1.1.0** - Panduan Sholat Lengkap
- **v1.0.0** - Rilis awal

## Tentang Aplikasi

**E-Sholat Guide** adalah aplikasi pembelajaran interaktif yang dirancang untuk membantu umat Muslim mempelajari tata cara sholat, wudhu, dan doa harian dengan mudah dan menyenangkan. Aplikasi ini menyediakan panduan lengkap dengan bacaan Arab, transliterasi Latin, terjemahan Indonesia, serta ilustrasi gerakan yang jelas.

Fitur utama meliputi:
- Panduan sholat lengkap dengan 19 langkah
- Daftar sholat wajib dan sunnah dengan niat
- Tata cara wudhu dengan 10 langkah
- 78 doa harian dalam berbagai kategori
- Kuis interaktif dengan 3 tingkat kesulitan (45 soal)
- Riwayat belajar untuk tracking progress
- Audio bacaan untuk membantu pelafalan

---

This application was developed as a final exam for the **Sistem Informasi Dakwah** course.

| Role | Name |
|------|------|
| **Team Leader** | Dwi Agung Santoso |
| **Developer** | Muthi'ah Dwita Fathinah |
| **Analysts** | Taufan Dwiyogo Setiawan and Triana Asih Wulandari |
| **Reviewer** | All Member |

---

## Lisensi

Aplikasi ini dibuat untuk tujuan edukasi dan dakwah Islam. Silakan digunakan dan dikembangkan lebih lanjut untuk kebaikan umat.

**©®2026**

---
