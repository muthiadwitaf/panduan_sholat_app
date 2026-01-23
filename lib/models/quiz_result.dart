class QuizResult {
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;
  final double scorePercentage;
  final DateTime completedAt;
  final Map<String, int> categoryBreakdown;

  QuizResult({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.scorePercentage,
    required this.completedAt,
    required this.categoryBreakdown,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      totalQuestions: json['totalQuestions'] as int,
      correctAnswers: json['correctAnswers'] as int,
      incorrectAnswers: json['incorrectAnswers'] as int,
      scorePercentage: (json['scorePercentage'] as num).toDouble(),
      completedAt: DateTime.parse(json['completedAt'] as String),
      categoryBreakdown: Map<String, int>.from(json['categoryBreakdown'] as Map),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
      'scorePercentage': scorePercentage,
      'completedAt': completedAt.toIso8601String(),
      'categoryBreakdown': categoryBreakdown,
    };
  }

  String get grade {
    if (scorePercentage >= 90) return 'Sangat Baik';
    if (scorePercentage >= 75) return 'Baik';
    if (scorePercentage >= 60) return 'Cukup';
    return 'Perlu Ditingkatkan';
  }
}
