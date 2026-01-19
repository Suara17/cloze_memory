import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cloze_provider.dart';

class ClozeDisplaySection extends StatefulWidget {
  const ClozeDisplaySection({super.key});

  @override
  State<ClozeDisplaySection> createState() => _ClozeDisplaySectionState();
}

class _ClozeDisplaySectionState extends State<ClozeDisplaySection> {
  final List<TextEditingController> _controllers = [];

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClozeProvider>(
      builder: (context, clozeProvider, child) {
        final clozeItems = clozeProvider.clozeItems;

        // 初始化控制器
        if (_controllers.length != clozeItems.length) {
          for (final controller in _controllers) {
            controller.dispose();
          }
          _controllers.clear();
          for (int i = 0; i < clozeItems.length; i++) {
            _controllers.add(TextEditingController(text: clozeItems[i].userAnswer));
          }
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '填空练习',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _showResults(context, clozeProvider),
                      icon: const Icon(Icons.check_circle),
                      label: const Text('检查答案'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        foregroundColor: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(clozeItems.length, (index) {
                        final item = clozeItems[index];
                         return item.isBlank
                             ? GestureDetector(
                                 onTap: () => clozeProvider.toggleRevealStudy(index),
                                 child: AnimatedContainer(
                                   duration: const Duration(milliseconds: 200),
                                   width: 120,
                                   height: 36,
                                   alignment: Alignment.center,
                                   decoration: BoxDecoration(
                                     color: item.isRevealed
                                         ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2)
                                         : Colors.black87,
                                     borderRadius: BorderRadius.circular(4),
                                     border: Border.all(
                                       color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                                     ),
                                   ),
                                   child: item.isRevealed
                                       ? Text(
                                           item.originalWord,
                                           style: TextStyle(
                                             fontSize: 14,
                                             color: Theme.of(context).colorScheme.primary,
                                             fontWeight: FontWeight.w500,
                                           ),
                                         )
                                       : const Text(
                                           '••••••',
                                           style: TextStyle(
                                             fontSize: 14,
                                             color: Colors.white,
                                             fontWeight: FontWeight.bold,
                                           ),
                                         ),
                                 ),
                               )
                            : AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                child: Text(
                                  item.originalWord,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showResults(BuildContext context, ClozeProvider clozeProvider) {
    final percentage = clozeProvider.getCorrectPercentage();
    final correctCount = (percentage * clozeProvider.clozeItems.where((item) => item.isBlank).length).toInt();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('练习结果'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('正确率: ${(percentage * 100).toStringAsFixed(1)}%'),
            Text('正确填空: $correctCount / ${clozeProvider.clozeItems.where((item) => item.isBlank).length}'),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: percentage,
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(
                percentage >= 0.8
                    ? Colors.green
                    : percentage >= 0.6
                        ? Colors.orange
                        : Colors.red,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('继续练习'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              clozeProvider.reset();
            },
            child: const Text('新练习'),
          ),
        ],
      ),
    );
  }
}