class NiatItem {
  final String arabicText;
  final String latinText;
  final String translation;

  NiatItem({
    required this.arabicText,
    required this.latinText,
    required this.translation,
  });

  factory NiatItem.fromJson(Map<String, dynamic> json) {
    return NiatItem(
      arabicText: (json['arabicText'] ?? '') as String,
      latinText: (json['latinText'] ?? '') as String,
      translation: (json['translation'] ?? '') as String,
    );
  }
}

class SholatItem {
  final String id;
  final String name;
  final String category;
  final NiatItem? niat;
  final int? rakaatCount;
  final String type;
  final String description;
  final String pattern;

  SholatItem({
    required this.id,
    required this.name,
    required this.category,
    this.niat,
    this.rakaatCount,
    this.type = 'wajib',
    this.description = '',
    this.pattern = 'dua_rakaat',
  });

  factory SholatItem.fromJson(Map<String, dynamic> json) {
    final name = (json['name'] ?? json['title'] ?? '') as String;
    final type = json['type'] as String? ?? 'wajib';
    final niatJson = json['niat'] as Map<String, dynamic>?;

    if (niatJson == null) {
      throw Exception('Niat data is missing for $name');
    }

    final niat = NiatItem.fromJson(niatJson);

    if (type == 'sunnah' && (niat.arabicText.contains('فَرْضَ') || niat.latinText.toLowerCase().contains('fardha'))) {
      throw Exception('Sunnah prayer ($name) cannot contain "fardha" in niat');
    }

    if (type == 'wajib' && niat.arabicText.isEmpty) {
      throw Exception('Wajib prayer ($name) must have Arabic niat defined');
    }

    // Allowed category values validation
    final category = json['category'] as String? ?? '';
    const allowedCategories = {
      'wajib',
      'sunnah_rawatib',
      'sunnah_harian',
      'hari_besar',
      'sunnah_tertentu',
      'khusus'
    };
    if (!allowedCategories.contains(category)) {
      throw Exception('Invalid category "$category" for sholat $name');
    }

    return SholatItem(
      id: (json['id'] ?? '') as String,
      name: name,
      category: category,
      niat: niat,
      rakaatCount: json['rakaatCount'] as int?,
      type: type,
      description: json['description'] as String? ?? '',
      pattern: json['pattern'] as String? ?? 'dua_rakaat',
    );
  }
}
