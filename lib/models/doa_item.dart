class DoaItem {
  final String id;
  final String title;
  final String category;
  final String arabicText;
  final String transliteration;
  final String translation;
  final String? context;
  final String? audioPath;
  final bool isFavorite;

  DoaItem({
    required this.id,
    required this.title,
    required this.category,
    required this.arabicText,
    required this.transliteration,
    required this.translation,
    this.context,
    this.audioPath,
    this.isFavorite = false,
  });

  factory DoaItem.fromJson(Map<String, dynamic> json) {
    return DoaItem(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      arabicText: json['arabicText'] as String,
      transliteration: json['transliteration'] as String,
      translation: json['translation'] as String,
      context: json['context'] as String?,
      audioPath: json['audioPath'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'arabicText': arabicText,
      'transliteration': transliteration,
      'translation': translation,
      'context': context,
      'audioPath': audioPath,
      'isFavorite': isFavorite,
    };
  }

  DoaItem copyWith({
    String? id,
    String? title,
    String? category,
    String? arabicText,
    String? transliteration,
    String? translation,
    String? context,
    String? audioPath,
    bool? isFavorite,
  }) {
    return DoaItem(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      arabicText: arabicText ?? this.arabicText,
      transliteration: transliteration ?? this.transliteration,
      translation: translation ?? this.translation,
      context: context ?? this.context,
      audioPath: audioPath ?? this.audioPath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
