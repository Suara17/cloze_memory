import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cloze_item.dart';

enum AppMode {
  edit,    // 输入模式
  prepare, // 准备模式（选择挖空）
  study    // 背诵模式
}

class ClozeProvider with ChangeNotifier {
  String _originalText = '';
  List<ClozeItem> _clozeItems = [];
  AppMode _mode = AppMode.edit;
  bool _isLoading = false;
  SharedPreferences? _prefs;

  String get originalText => _originalText;
  List<ClozeItem> get clozeItems => _clozeItems;
  AppMode get mode => _mode;
  bool get isLoading => _isLoading;
  bool get isClozeMode => _mode == AppMode.prepare || _mode == AppMode.study;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    if (_prefs == null) return;

    final savedText = _prefs!.getString('original_text');
    if (savedText != null && savedText.isNotEmpty) {
      _originalText = savedText;
      notifyListeners();
    }
  }

  Future<void> _saveText() async {
    if (_prefs == null) return;
    await _prefs!.setString('original_text', _originalText);
  }

  void setOriginalText(String text) {
    _originalText = text;
    _clozeItems = [];
    _mode = AppMode.edit;
    _saveText();
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
        isRevealed: false,
      ));
    }

    _mode = AppMode.prepare;
    notifyListeners();
  }

  void updateUserAnswer(int index, String answer) {
    if (index >= 0 && index < _clozeItems.length) {
      _clozeItems[index] = _clozeItems[index].copyWith(userAnswer: answer);
      notifyListeners();
    }
  }

  void toggleRevealStudy(int index) {
    if (index >= 0 && index < _clozeItems.length && _clozeItems[index].isBlank) {
      _clozeItems[index] = _clozeItems[index].copyWith(
        isRevealed: !_clozeItems[index].isRevealed,
      );
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
    _mode = AppMode.edit;
    _isLoading = false;
    notifyListeners();
  }

  // 切换到准备模式
  void startPrepare() {
    if (_originalText.isEmpty) return;

    final processed = processText(_originalText);
    _clozeItems = processed;
    _mode = AppMode.prepare;
    notifyListeners();
  }

  // 智能文本分词
  List<ClozeItem> processText(String inputText) {
    // 正则：匹配换行符 | 英文单词 | 单个中文字符/标点
    final regex = RegExp(r'(\n|[a-zA-Z0-9]+|[\u4e00-\u9fa5]|[^\s\w])');
    final parts = regex.allMatches(inputText);

    return parts.map((match) {
      final part = match.group(0)!;
      return ClozeItem(
        originalWord: part,
        isBlank: false,
        userAnswer: '',
        isRevealed: false,
        isNewLine: part == '\n',
      );
    }).toList();
  }

  // 切换令牌的挖空状态（准备模式）
  void toggleTokenMask(int index) {
    if (_mode != AppMode.prepare || index < 0 || index >= _clozeItems.length) return;

    _clozeItems[index] = _clozeItems[index].copyWith(
      isBlank: !_clozeItems[index].isBlank,
    );
    notifyListeners();
  }

  // 自动随机挖空
  void autoMask() {
    if (_mode != AppMode.prepare) return;

    final random = DateTime.now().millisecondsSinceEpoch;
    int index = 0;

    _clozeItems = _clozeItems.map((item) {
      // 不隐藏换行符和常见标点
      if (item.isNewLine || RegExp(r'[,.!?;:，。！？；：]').hasMatch(item.originalWord)) {
        index++;
        return item.copyWith(isBlank: false);
      }
      // 使用不同的随机种子确保每个项目都有不同的随机性
      final isBlank = (random + index * 31) % 100 < 40; // 40%概率被隐藏
      index++;
      return item.copyWith(isBlank: isBlank);
    }).toList();
    notifyListeners();
  }

  // 开始背诵模式
  void startStudy() {
    if (_mode != AppMode.prepare) return;
    _mode = AppMode.study;
    notifyListeners();
  }

  // 返回准备模式
  void backToPrepare() {
    if (_mode != AppMode.study) return;
    _mode = AppMode.prepare;
    notifyListeners();
  }

  // 切换答案显示（背诵模式）
  void toggleReveal(int index) {
    if (_mode != AppMode.study || index < 0 || index >= _clozeItems.length) return;

    _clozeItems[index] = _clozeItems[index].copyWith(
      isRevealed: !_clozeItems[index].isRevealed,
    );
    notifyListeners();
  }

  // 模拟图片OCR处理
  Future<void> processImage(String imagePath) async {
    _isLoading = true;
    notifyListeners();

    // 模拟OCR处理延迟
    await Future.delayed(const Duration(seconds: 2));

    // 模拟OCR结果
    const ocrResult = '''[图片解析结果]

细胞呼吸（cellular respiration）是指有机物在细胞内经过一系列的氧化分解，生成二氧化碳或其他产物，释放出能量并生成ATP的过程。

分为有氧呼吸和无氧呼吸。''';

    _originalText = ocrResult;
    _clozeItems = [];
    _mode = AppMode.edit;
    _isLoading = false;
    _saveText();
    notifyListeners();
  }
}