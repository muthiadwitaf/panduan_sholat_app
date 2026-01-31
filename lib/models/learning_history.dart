import 'package:flutter/foundation.dart';

class LearningHistory {
  final String id;
  final String prayerType;
  final String prayerName;
  final DateTime completedAt;
  final int stepsCompleted;
  final int totalSteps;
  final int? durationSeconds;

  LearningHistory({
    required this.id,
    required this.prayerType,
    required this.prayerName,
    required this.completedAt,
    required this.stepsCompleted,
    required this.totalSteps,
    this.durationSeconds,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'prayerType': prayerType,
      'prayerName': prayerName,
      'completedAt': completedAt.toIso8601String(),
      'stepsCompleted': stepsCompleted,
      'totalSteps': totalSteps,
      'durationSeconds': durationSeconds,
    };
  }

  factory LearningHistory.fromJson(Map<String, dynamic> json) {
    return LearningHistory(
      id: json['id'] as String,
      prayerType: json['prayerType'] as String,
      prayerName: json['prayerName'] as String,
      completedAt: DateTime.parse(json['completedAt'] as String),
      stepsCompleted: json['stepsCompleted'] as int,
      totalSteps: json['totalSteps'] as int,
      durationSeconds: json['durationSeconds'] as int?,
    );
  }

  bool get isCompleted => stepsCompleted >= totalSteps;

  double get completionPercentage => 
      totalSteps > 0 ? (stepsCompleted / totalSteps) * 100 : 0;
  String get formattedDate {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final date = DateTime(completedAt.year, completedAt.month, completedAt.day);

    if (date == today) {
      return 'Hari ini, ${completedAt.hour.toString().padLeft(2, '0')}:${completedAt.minute.toString().padLeft(2, '0')}';
    } else if (date == yesterday) {
      return 'Kemarin, ${completedAt.hour.toString().padLeft(2, '0')}:${completedAt.minute.toString().padLeft(2, '0')}';
    } else {
      return '${completedAt.day}/${completedAt.month}/${completedAt.year} ${completedAt.hour.toString().padLeft(2, '0')}:${completedAt.minute.toString().padLeft(2, '0')}';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LearningHistory &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
