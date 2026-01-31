# Script untuk membuat placeholder audio files
Write-Host "Membuat placeholder audio files..." -ForegroundColor Green

# Fungsi untuk membuat file placeholder
function Create-PlaceholderAudio {
    param([string]$Path, [string]$Format)
    
    $content = switch ($Format) {
        "mp3" { [byte[]]@(0x49, 0x44, 0x33, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00) }
        "m4a" { [byte[]]@(0x00, 0x00, 0x00, 0x20, 0x66, 0x74, 0x79, 0x70, 0x4D, 0x34, 0x41, 0x20) }
        "ogg" { [byte[]]@(0x4F, 0x67, 0x67, 0x53, 0x00, 0x02, 0x00, 0x00) }
        default { [byte[]]@(0x00) }
    }
    [System.IO.File]::WriteAllBytes($Path, $content)
}

# Prayer audio files
$prayerFiles = @("niat.mp3", "takbir.m4a", "iftitah.mp3", "fatihah.ogg", "surat.mp3", "ruku.m4a", "itidal.mp3", "sujud.ogg", "duduk_sujud.mp3", "tasyahud_awal.m4a", "tasyahud_akhir.mp3", "salam.ogg", "qunut.mp3", "takbir_jenazah_1.m4a", "takbir_jenazah_2.mp3", "takbir_jenazah_3.ogg", "takbir_jenazah_4.mp3", "takbir_extra.m4a", "tasbih.mp3")

# Doa audio files
$doaFiles = @("doa_pagi.mp3", "doa_petang.m4a", "doa_bangun_tidur.mp3", "doa_sebelum_tidur.ogg", "doa_sebelum_makan.mp3", "doa_setelah_makan.m4a", "doa_masuk_rumah.mp3", "doa_keluar_rumah.ogg", "doa_kedua_orangtua.mp3", "doa_mudah_rezeki.m4a", "doa_naik_kendaraan.mp3", "doa_masuk_masjid.ogg", "doa_keluar_masjid.mp3", "zikir_sholat_fardhu_lengkap.m4a", "doa_mimpi_buruk.mp3", "doa_masuk_kamar_mandi.ogg", "doa_keluar_kamar_mandi.mp3", "doa_turun_hujan.m4a", "doa_setelah_hujan.mp3", "doa_masuk_pasar.ogg", "doa_bercermin.mp3", "doa_memakai_pakaian.m4a", "doa_melepas_pakaian.mp3", "doa_sesudah_adzan.ogg", "doa_keselamatan_keturunan.mp3", "doa_perlindungan_bencana.m4a", "doa_disergap_galau.mp3", "doa_dunia_akhirat.ogg", "doa_selamat_tolakbala.mp3", "doa_tertimpa_musibah.m4a", "doa_terhindar_kedzaliman.mp3", "doa_perampas_hak.ogg", "doa_gempa_bumi.mp3", "doa_kehilangan_barang.m4a", "doa_pertanda_buruk.mp3", "doa_berangkat_kerja.ogg", "doa_mudah_urusan.mp3", "doa_bayar_utang.m4a", "doa_lilitan_hutang.mp3", "doa_harta_haram.ogg", "doa_kerugian.mp3", "doa_kesembuhan.m4a", "doa_jenguk_orang.mp3", "doa_mohon_sehat.ogg", "doa_terhindar_dari_wabah.mp3", "doa_terhindar_dari_penyakit_ain.m4a", "doa_naik_kapal.mp3", "doa_mendoakan_orang_yang_akan_bepergian.ogg", "doa_berangkat_mengajar.mp3", "doa_sebelum_belajar.m4a", "doa_sesudah_belajar.mp3", "doa_mohon_ilmu_bermanfaat.ogg", "mendoakan_guru.mp3", "doa_penutup_majelis.m4a", "doa_akhir_tahun.mp3", "doa_awal_tahun.ogg", "doa_asyura.mp3", "doa_bulan_rajab.m4a", "doa_nisfu_syaban.mp3", "doa_awal_bulan_ramadhan.ogg", "doa_malam_idul_fitri_atau_idul_adha.mp3", "doa_dijauhkan_dari_maksiat.m4a", "doa_giat_beribadah.mp3", "doa_mohon_akhlak_mulia.ogg", "doa_menghilangkan_malas.mp3", "doa_meredam_rasa_marah.m4a", "doa_untuk_orang_iri_atau_dengki.mp3", "doa_mohon_istiqamah.ogg", "doa_mohon_umur_berkah.mp3", "doa_husnul_khatimah.m4a", "doa_mendekatkan_jodoh.mp3", "doa_mendoakan_pengantin_baru.ogg", "doa_mohon_rumah_tangga_berkah.mp3", "doa_terhindar_dari_rumah_tangga_toksik.m4a", "doa_dikaruniai_keturunan_sholeh_dan_sholehah.mp3", "doa_mohon_keturunan.ogg", "doa_selama_bayi_dalam_kandungan.mp3", "doa_saat_proses_persalinan.m4a")

# Wudhu audio files
$wudhuFiles = @("niat_wudhu.mp3", "basuh_tangan.m4a", "berkumur.mp3", "istinsyaq.ogg", "basuh_muka.mp3", "basuh_tangan_siku.m4a", "usap_kepala.mp3", "usap_telinga.ogg", "basuh_kaki.mp3", "doa_setelah_wudhu.m4a")

Write-Host "Creating prayer audio files..." -ForegroundColor Cyan
foreach ($file in $prayerFiles) {
    $ext = $file.Split('.')[-1]
    $path = "c:\panduansholat_ebook\panduan_sholat_app\assets\audio\prayer\$file"
    Create-PlaceholderAudio -Path $path -Format $ext
    Write-Host "  Created: $file" -ForegroundColor Gray
}

Write-Host "Creating doa audio files..." -ForegroundColor Cyan
foreach ($file in $doaFiles) {
    $ext = $file.Split('.')[-1]
    $path = "c:\panduansholat_ebook\panduan_sholat_app\assets\audio\doa\$file"
    Create-PlaceholderAudio -Path $path -Format $ext
    Write-Host "  Created: $file" -ForegroundColor Gray
}

Write-Host "Creating wudhu audio files..." -ForegroundColor Cyan
foreach ($file in $wudhuFiles) {
    $ext = $file.Split('.')[-1]
    $path = "c:\panduansholat_ebook\panduan_sholat_app\assets\audio\wudhu\$file"
    Create-PlaceholderAudio -Path $path -Format $ext
    Write-Host "  Created: $file" -ForegroundColor Gray
}

$total = $prayerFiles.Count + $doaFiles.Count + $wudhuFiles.Count
Write-Host ""
Write-Host "SELESAI! Total $total placeholder files created." -ForegroundColor Green
Write-Host "CATATAN: File-file ini adalah PLACEHOLDER kosong, ganti dengan audio asli!" -ForegroundColor Yellow
