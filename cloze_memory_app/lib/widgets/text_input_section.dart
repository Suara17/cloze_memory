import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cloze_provider.dart';

class TextInputSection extends StatefulWidget {
  const TextInputSection({super.key});

  @override
  State<TextInputSection> createState() => _TextInputSectionState();
}

class _TextInputSectionState extends State<TextInputSection> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.edit_note,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '输入文本',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _textController,
              maxLines: 8,
              decoration: const InputDecoration(
                hintText: '请输入要背诵的文本内容...',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                 Expanded(
                   child: ElevatedButton.icon(
                     onPressed: () {
                       if (_textController.text.trim().isNotEmpty) {
                         final clozeProvider = context.read<ClozeProvider>();
                         clozeProvider.setOriginalText(_textController.text.trim());
                         // 自动生成挖空（默认5个）
                         clozeProvider.generateCloze(5);
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(content: Text('文本已加载，开始挖空练习')),
                         );
                       }
                     },
                     icon: const Icon(Icons.check),
                     label: const Text('确认并开始挖空'),
                     style: ElevatedButton.styleFrom(
                       padding: const EdgeInsets.symmetric(vertical: 12),
                     ),
                   ),
                 ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    _textController.clear();
                    context.read<ClozeProvider>().reset();
                  },
                  icon: const Icon(Icons.clear),
                  tooltip: '清空',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}