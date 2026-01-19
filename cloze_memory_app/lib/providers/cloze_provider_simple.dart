import 'package:flutter/foundation.dart';

class ClozeProvider with ChangeNotifier {
  String _originalText = '';
  List<ClozeItem> _clozeItems = [];
  bool _isClozeMode = false;

  String get originalText => _originalText;
  List<ClozeItem> get clozeItems => _clozeItems;
  bool get isClozeMode => _isClozeMode;

  void setOriginalText(String text) {
    _originalText = text;
    _clozeItems = [];
    _isClozeMode = false;
    notifyListeners();
  }

  void generateCloze(int blankCount) {
    if (_originalText.isEmpty) return;

    final words = _originalText.split(RegExp(r'\s+'));
    if (words.length <= blankCount) return;

    final randomIndices = <int>{};
    while (randomIndices.length < blankCount) {
      randomIndices.add(DateTime.now().millisecondsSinceEpoch % words.length);
    }

    _clozeItems = [];
    for (int i = 0; i < words.length; i++) {
      final word = words[i];
      final isBlank = randomIndices.contains(i);
      _clozeItems.add(ClozeItem(
        originalWord: word,
        isBlank: isBlank,
        userAnswer: '',
      ));
    }

    _isClozeMode = true;
    notifyListeners();
  }

  void updateUserAnswer(int index, String answer) {
    if (index >= 0 && index < _clozeItems.length) {
      _clozeItems[index] = _clozeItems[index].copyWith(userAnswer: answer);
      notifyListeners();
    }
  }

  double getCorrectPercentage() {
    if (_clozeItems.isEmpty) return 0.0;

    int correctCount = 0;
    for (final item in _clozeItems) {
      if (item.isBlank && item.originalWord.trim().toLowerCase() == item.userAnswer.trim().toLowerCase()) {
        correctCount++;
      }
    }

    return correctCount / _clozeItems.where((item) => item.isBlank).length;
  }

  void reset() {
    _originalText = '';
    _clozeItems = [];
    _isClozeMode = false;
    notifyListeners();
  }
}

class ClozeItem {
  final String originalWord;
  final bool isBlank;
  final String userAnswer;

  ClozeItem({
    required this.originalWord,
    required this.isBlank,
    required this.userAnswer,
  });

  ClozeItem copyWith({
    String? originalWord,
    bool? isBlank,
    String? userAnswer,
  }) {
    return ClozeItem(
      originalWord: originalWord ?? this.originalWord,
      isBlank: isBlank ?? this.isBlank,
      userAnswer: userAnswer ?? this.userAnswer,
    );
  }
}