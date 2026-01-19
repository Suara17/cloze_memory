class ClozeItem {
  final String originalWord;
  final bool isBlank;
  final String userAnswer;
  final bool isRevealed;
  final bool isNewLine;

  ClozeItem({
    required this.originalWord,
    required this.isBlank,
    required this.userAnswer,
    this.isRevealed = false,
    this.isNewLine = false,
  });

  ClozeItem copyWith({
    String? originalWord,
    bool? isBlank,
    String? userAnswer,
    bool? isRevealed,
    bool? isNewLine,
  }) {
    return ClozeItem(
      originalWord: originalWord ?? this.originalWord,
      isBlank: isBlank ?? this.isBlank,
      userAnswer: userAnswer ?? this.userAnswer,
      isRevealed: isRevealed ?? this.isRevealed,
      isNewLine: isNewLine ?? this.isNewLine,
    );
  }
}