import 'package:flutter/foundation.dart';
import '../models/quiz_question.dart';
import '../models/quiz_result.dart';
import '../utils/data_loader.dart';

class QuizProvider with ChangeNotifier {
  List<QuizQuestion> _allQuestions = [];
  List<QuizQuestion> _currentQuestions = [];
  int _currentQuestionIndex = 0;
  final Map<int, int> _userAnswers = {};
  bool _isLoading = false;
  String? _error;
  QuizResult? _lastResult;
  String? _selectedDifficulty;

  List<QuizQuestion> get currentQuestions => _currentQuestions;
  int get currentQuestionIndex => _currentQuestionIndex;
  bool get isLoading => _isLoading;
  String? get error => _error;
  QuizResult? get lastResult => _lastResult;
  String? get selectedDifficulty => _selectedDifficulty;
  
  QuizQuestion? get currentQuestion => _currentQuestions.isNotEmpty 
      ? _currentQuestions[_currentQuestionIndex] 
      : null;
  
  int get totalQuestions => _currentQuestions.length;
  int get answeredCount => _userAnswers.length;
  bool get hasNext => _currentQuestionIndex < _currentQuestions.length - 1;
  bool get hasPrevious => _currentQuestionIndex > 0;
  bool get isQuizComplete => _userAnswers.length == _currentQuestions.length;
  
  // Get question counts per difficulty
  Map<String, int> get difficultyCount {
    Map<String, int> counts = {'mudah': 0, 'sedang': 0, 'susah': 0};
    for (var q in _allQuestions) {
      counts[q.difficulty] = (counts[q.difficulty] ?? 0) + 1;
    }
    return counts;
  }

  Future<void> loadQuestions() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final Map<String, dynamic> data = 
          await DataLoader.loadJsonMap('assets/data/quiz_questions.json');
      
      final List<dynamic> questionsJson = data['quizQuestions'] as List;
      _allQuestions = questionsJson
          .map((json) => QuizQuestion.fromJson(json as Map<String, dynamic>))
          .toList();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Gagal memuat soal kuis: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  void startQuiz({int questionCount = 10, String? difficulty}) {
    _selectedDifficulty = difficulty;
    
    List<QuizQuestion> filteredQuestions;
    if (difficulty != null) {
      filteredQuestions = _allQuestions.where((q) => q.difficulty == difficulty).toList();
    } else {
      filteredQuestions = List.from(_allQuestions);
    }
    
    filteredQuestions.shuffle();
    _currentQuestions = filteredQuestions.take(questionCount).toList();
    _currentQuestionIndex = 0;
    _userAnswers.clear();
    _lastResult = null;
    notifyListeners();
  }

  void submitAnswer(int answerIndex) {
    if (currentQuestion != null) {
      _userAnswers[_currentQuestionIndex] = answerIndex;
      notifyListeners();
    }
  }

  int? getUserAnswer(int questionIndex) {
    return _userAnswers[questionIndex];
  }

  void nextQuestion() {
    if (hasNext) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (hasPrevious) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  void goToQuestion(int index) {
    if (index >= 0 && index < _currentQuestions.length) {
      _currentQuestionIndex = index;
      notifyListeners();
    }
  }

  QuizResult calculateResult() {
    int correctAnswers = 0;
    Map<String, int> categoryCorrect = {};
    Map<String, int> categoryTotal = {};

    for (int i = 0; i < _currentQuestions.length; i++) {
      final question = _currentQuestions[i];
      final userAnswer = _userAnswers[i];
      
      categoryTotal[question.category] = 
          (categoryTotal[question.category] ?? 0) + 1;
      
      if (userAnswer == question.correctAnswerIndex) {
        correctAnswers++;
        categoryCorrect[question.category] = 
            (categoryCorrect[question.category] ?? 0) + 1;
      }
    }

    final scorePercentage = 
        (correctAnswers / _currentQuestions.length) * 100;
    
    _lastResult = QuizResult(
      totalQuestions: _currentQuestions.length,
      correctAnswers: correctAnswers,
      incorrectAnswers: _currentQuestions.length - correctAnswers,
      scorePercentage: scorePercentage,
      completedAt: DateTime.now(),
      categoryBreakdown: categoryCorrect,
    );

    notifyListeners();
    return _lastResult!;
  }

  void reset() {
    _currentQuestions.clear();
    _currentQuestionIndex = 0;
    _userAnswers.clear();
    _lastResult = null;
    _selectedDifficulty = null;
    notifyListeners();
  }
}
