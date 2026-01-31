# Audio File Mapping - Doa Harian

## File Audio yang Sudah Ada (12 files)

| No | ID Doa | Nama File | Ukuran | Status |
|----|--------|-----------|--------|--------|
| 1 | doa_bangun_tidur | doa_bangun_tidur.mpeg | 183 KB | ✅ Ready |
| 2 | doa_kedua_orangtua | doa_kedua_orangtua.mpeg | 255 KB | ✅ Ready |
| 3 | doa_keluar_rumah | doa_keluar_rumah.mpeg | 90 KB | ✅ Ready |
| 4 | doa_masuk_masjid | doa_masuk_masjid.mpeg | 135 KB | ✅ Ready |
| 5 | doa_masuk_rumah | doa_masuk_rumah.mpeg | 746 KB | ✅ Ready |
| 6 | doa_mudah_rezeki | doa_mudah_rezeki.mpeg | 531 KB | ✅ Ready |
| 7 | doa_naik_kendaraan | doa_naik_kendaraan.mpeg | 478 KB | ✅ Ready |
| 8 | doa_pagi | doa_pagi.mpeg | 237 KB | ✅ Ready |
| 9 | doa_petang | doa_petang.mpeg | 219 KB | ✅ Ready |
| 10 | doa_sebelum_makan | doa_sebelum_makan.mpeg | 95 KB | ✅ Ready |
| 11 | doa_sebelum_tidur | doa_sebelum_tidur.mpeg | 128 KB | ✅ Ready |
| 12 | doa_setelah_makan | doa_setelah_makan.mpeg | 416 KB | ✅ Ready |

**Total Ukuran**: ~3.5 MB

## Mapping untuk doa_harian.json

Berikut adalah mapping yang perlu ditambahkan ke file `doa_harian.json`:

```json
{
  "id": "doa_pagi",
  "audioPath": "audio/doa/doa_pagi.mpeg"
}

{
  "id": "doa_petang",
  "audioPath": "audio/doa/doa_petang.mpeg"
}

{
  "id": "doa_bangun_tidur",
  "audioPath": "audio/doa/doa_bangun_tidur.mpeg"
}

{
  "id": "doa_sebelum_tidur",
  "audioPath": "audio/doa/doa_sebelum_tidur.mpeg"
}

{
  "id": "doa_sebelum_makan",
  "audioPath": "audio/doa/doa_sebelum_makan.mpeg"
}

{
  "id": "doa_setelah_makan",
  "audioPath": "audio/doa/doa_setelah_makan.mpeg"
}

{
  "id": "doa_masuk_rumah",
  "audioPath": "audio/doa/doa_masuk_rumah.mpeg"
}

{
  "id": "doa_keluar_rumah",
  "audioPath": "audio/doa/doa_keluar_rumah.mpeg"
}

{
  "id": "doa_kedua_orangtua",
  "audioPath": "audio/doa/doa_kedua_orangtua.mpeg"
}

{
  "id": "doa_mudah_rezeki",
  "audioPath": "audio/doa/doa_mudah_rezeki.mpeg"
}

{
  "id": "doa_naik_kendaraan",
  "audioPath": "audio/doa/doa_naik_kendaraan.mpeg"
}

{
  "id": "doa_masuk_masjid",
  "audioPath": "audio/doa/doa_masuk_masjid.mpeg"
}
```

## Doa yang Belum Ada Audio (66 doa lainnya)

Untuk doa-doa yang belum ada file audionya, Anda bisa:
1. **Tidak menambahkan field `audioPath`** - Tombol audio tidak akan muncul
2. **Set `audioPath: null`** - Sama seperti di atas
3. **Tambahkan file audio nanti** - Buat file dengan format yang sama

## Catatan Format

- ✅ Format MPEG sudah didukung oleh package `audioplayers`
- ✅ MPEG adalah format yang sama dengan MP3 (MPEG-1 Audio Layer 3)
- ✅ Tidak perlu konfigurasi tambahan
- ✅ Kompatibel dengan Android dan iOS

## Langkah Selanjutnya

1. ✅ File audio sudah ada di folder yang benar
2. ⏳ Update `doa_harian.json` dengan audioPath
3. ⏳ Test audio playback di aplikasi
4. ⏳ Tambahkan file audio untuk doa lainnya (opsional)
