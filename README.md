# E-Sholat Guide

Aplikasi multiplatform (Android, iOS, Desktop) untuk membantu umat Muslim mempelajari tata cara sholat dan doa harian berbasis e-book interaktif.

## 🌟 Fitur Utama

### 📖 Panduan Sholat Lengkap
- 19 langkah sholat dari niat hingga salam (termasuk Sholat Jenazah)
- Bacaan Arab dengan font Amiri yang indah
- Transliterasi Latin untuk memudahkan
- Terjemahan Bahasa Indonesia
- Panduan gerakan sholat
- Label Wajib/Sunnah untuk setiap bacaan (Grup Sholat Wajib)

### 🤲 Doa Harian
- 75+ doa sehari-hari (Total 78 doa)
- Kategori: Doa Pagi & Petang, Doa Sehari-hari, Doa Ibadah, Doa Istimewa, dll.
- Pencarian doa
- Filter berdasarkan kategori
- Fitur favorit untuk menyimpan doa favorit

### 🎯 Kuis Interaktif
- 20 soal tentang tata cara sholat
- Kategori: Rukun Sholat, Bacaan Sholat, Gerakan Sholat
- Feedback langsung setelah menjawab
- Penjelasan untuk setiap jawaban
- Skor dan rekomendasi pembelajaran

### 💧 Tata Cara Wudhu
- 10 langkah wudhu dari niat hingga doa sesudah wudhu
- Bacaan Arab, Latin, dan Terjemahan
- Panduan urutan yang benar

## 🏗️ Struktur Proyek

```
lib/
├── main.dart                    # Entry point aplikasi
├── models/                      # Data models
│   ├── prayer_step.dart        # Model langkah sholat
│   ├── doa_item.dart          # Model doa
│   ├── quiz_question.dart     # Model soal kuis
│   └── quiz_result.dart       # Model hasil kuis
├── providers/                   # State management (Provider)
│   ├── prayer_provider.dart   # State sholat
│   ├── doa_provider.dart      # State doa & favorit
│   └── quiz_provider.dart     # State kuis
├── screens/                     # UI Screens
│   ├── home_screen.dart       # Beranda
│   ├── prayer_guide_screen.dart # Panduan sholat
│   ├── wudhu_guide_screen.dart # Tata cara wudhu [NEW]
│   ├── doa_list_screen.dart   # Daftar doa
│   ├── doa_detail_screen.dart # Detail doa
│   └── quiz_screen.dart       # Kuis interaktif
├── widgets/                     # Reusable widgets
│   ├── arabic_text_widget.dart # Widget teks Arab
│   ├── prayer_card.dart       # Card langkah sholat
│   └── quiz_option_card.dart  # Card pilihan kuis
└── utils/                       # Utilities
    ├── app_colors.dart         # Warna tema Islami
    ├── app_text_styles.dart   # Typography
    └── data_loader.dart        # JSON loader

assets/
├── data/                        # Data JSON
│   ├── prayer_steps.json      # Data langkah sholat
│   ├── wudhu_steps.json       # Data tata cara wudhu [NEW]
│   ├── rakaat_patterns.json   # Pola rakaat
│   ├── sholat_list.json       # Daftar sholat & niat
│   ├── doa_harian.json       # Data doa harian
│   └── quiz_questions.json   # Data soal kuis
└── images/                      # Gambar
    ├── app_icon.png
    └── sholat/                # Ilustrasi gerakan sholat
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1          # State management
  shared_preferences: ^2.2.2 # Local storage
  google_fonts: ^6.1.0      # Fonts (Amiri untuk Arab)
```

## 🚀 Instalasi & Menjalankan

### Prerequisite
- Flutter SDK (stable channel)
- Android Studio / VS Code
- Android SDK untuk build Android
- Xcode untuk build iOS (Mac only)

### Langkah-langkah

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

## 🎨 Tema & Desain

### Warna
- **Primary**: Teal Green (#2D5F5D) - warna Islamic yang tenang
- **Accent**: Gold (#D4AF37) - aksen mewah
- **Background**: Cream (#F5F5F0) - lembut di mata

### Font
- **Arabic**: Amiri (Google Fonts)
- **Latin**: Inter (Google Fonts)

## 📝 Data Format

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

## 📱 Platform Support

- ✅ Android (API 21+)
- ✅ iOS (iOS 12+)
- ✅ Windows Desktop
- ✅ Web

## 📦 Version
- **Current Version**: 1.3.1 (Illustrated Update)

## 📄 Lisensi

Aplikasi ini dibuat untuk tujuan edukasi dan dakwah Islam. Silakan digunakan dan dikembangkan lebih lanjut untuk kebaikan umat.

---

**Dibuat dengan ❤️ untuk umat Muslim Indonesia**
