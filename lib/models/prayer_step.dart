class PrayerStep {
  final String stepId;
  final String title;
  final String arabicText;
  final String latinText;
  final String translation;
  final String imagePath;
  final String? audioPath;
  final String? niat;
  final int? rakaat;
  
  PrayerStep({
    required this.stepId,
    required this.title,
    required this.arabicText,
    required this.latinText,
    required this.translation,
    required this.imagePath,
    this.audioPath,
    this.niat,
    this.rakaat,
  });

  factory PrayerStep.fromJson(Map<String, dynamic> json) {
    return PrayerStep(
      stepId: json['stepId'] as String,
      title: json['title'] as String,
      arabicText: json['arabicText'] as String,
      latinText: json['latinText'] as String,
      translation: json['translation'] as String,
      imagePath: json['imagePath'] as String,
      audioPath: json['audioPath'] as String?,
      niat: json['niat'] as String?,
      rakaat: json['rakaat'] as int?,
    );
  }

  PrayerStep copyWith({
    int? rakaat,
    String? niat,
    String? title,
    String? arabicText,
    String? latinText,
    String? translation,
    String? audioPath,
  }) {
    return PrayerStep(
      stepId: stepId,
      title: title ?? this.title,
      arabicText: arabicText ?? this.arabicText,
      latinText: latinText ?? this.latinText,
      translation: translation ?? this.translation,
      imagePath: imagePath,
      audioPath: audioPath ?? this.audioPath,
      niat: niat ?? this.niat,
      rakaat: rakaat ?? this.rakaat,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stepId': stepId,
      'title': title,
      'arabicText': arabicText,
      'latinText': latinText,
      'translation': translation,
      'imagePath': imagePath,
      'audioPath': audioPath,
      'niat': niat,
      'rakaat': rakaat,
    };
  }
}
