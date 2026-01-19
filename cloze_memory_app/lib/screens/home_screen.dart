import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cloze_provider.dart';

// 精致的黑板配色方案 - 根据提示词优化
const Color chalkboardGreen = Color(0xFF003300); // 深森林绿基调
const Color chalkboardBorder = Color(0xFFDAA520); // 柔和金色边框
const Color chalkboardShadow = Color(0x40000000); // 柔和阴影
const Color chalkWhite = Color(0xFFF5F5F5); // 柔和米色粉笔文字
const Color accentGold = Color(0xFFDAA520); // 柔和金色点缀
const Color contentBackground = Color(0xFFF8F9FA); // 内容区域背景

// 精致的装饰元素
const List<Map<String, dynamic>> _stickers = [
  {'content': '⭐', 'top': 0.88, 'left': 0.03, 'rotate': -8.0},
  {'content': '📖', 'top': 0.12, 'left': 0.03, 'rotate': -3.0},
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: chalkboardGreen, // 统一的深森林绿
          border: Border.all(
            color: chalkboardBorder, // 经典木色边框
            width: 8,
          ),
          boxShadow: [
            BoxShadow(
              color: chalkboardShadow.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: chalkboardBorder.withOpacity(0.2),
              blurRadius: 35,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // 顶部黑板槽装饰
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
            ),

            // 贴纸装饰
            Expanded(
              child: Stack(
                children: [
                  // 主内容
                  Column(
                    children: [
                      // 顶部工具栏
                      _buildTopBar(),
                      // 主内容区域
                      Expanded(child: _buildMainContent()),
                      // 底部粉笔槽
                      _buildBottomTray(),
                    ],
                  ),

                  // 精致的贴纸装饰
                  ..._stickers.map((sticker) => Positioned(
                    top: MediaQuery.of(context).size.height * 0.95 * sticker['top'],
                    left: MediaQuery.of(context).size.width * 0.95 * sticker['left'],
                    child: Transform.rotate(
                      angle: sticker['rotate'] * 3.14159 / 180,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: accentGold.withOpacity(0.9), // 金色背景
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: chalkboardShadow.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(2, 2),
                            ),
                          ],
                          border: Border.all(
                            color: chalkWhite.withOpacity(0.5),
                            width: 2,
                          ),
                        ),
                        child: Text(
                          sticker['content'],
                          style: const TextStyle(
                            fontSize: 24,
                            color: Color(0xFF1B4332), // 深绿文字
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Consumer<ClozeProvider>(
      builder: (context, clozeProvider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: chalkboardGreen.withOpacity(0.95), // 深森林绿
            border: Border(
              bottom: BorderSide(
                color: chalkWhite.withOpacity(0.2), // 淡白色分割线
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            children: [
              Row(
                children: [
                  Icon(Icons.menu_book, color: chalkWhite.withOpacity(0.95), size: 24),
                  const SizedBox(width: 8),
                  Text(
                    '记忆小教室',
                    style: TextStyle(
                      color: chalkWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      fontFamily: 'Comic Sans MS',
                      shadows: [
                        Shadow(
                          color: chalkboardGreen.withOpacity(0.5),
                          blurRadius: 3,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _buildTopButtons(clozeProvider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopButtons(ClozeProvider clozeProvider) {
    switch (clozeProvider.mode) {
      case AppMode.edit:
        return Row(
          children: [
            _buildButton(
              icon: Icons.image,
              label: '导入图片',
              onPressed: () => _handleImageUpload(context),
              color: accentGold,
            ),
            const SizedBox(width: 12),
            _buildButton(
              icon: Icons.edit,
              label: '去空格',
              onPressed: clozeProvider.startPrepare,
              color: accentGold,
            ),
          ],
        );

      case AppMode.prepare:
        return Row(
          children: [
            _buildButton(
              icon: Icons.auto_fix_high,
              label: '随机挖空',
              onPressed: clozeProvider.autoMask,
              color: const Color(0xFFF59E0B),
            ),
            const SizedBox(width: 12),
            _buildButton(
              icon: Icons.clear,
              label: '重置',
              onPressed: () => clozeProvider.reset(),
              color: const Color(0xFFDC2626),
            ),
            const SizedBox(width: 12),
            _buildButton(
              icon: Icons.check,
              label: '开始背诵',
              onPressed: clozeProvider.startStudy,
              color: const Color(0xFF16A34A),
            ),
          ],
        );

      case AppMode.study:
        return _buildButton(
          icon: Icons.arrow_back,
          label: '返回调整',
          onPressed: clozeProvider.backToPrepare,
          color: chalkWhite.withOpacity(0.2),
        );
    }
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: chalkboardShadow.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 14, color: chalkWhite),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            color: chalkWhite,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: chalkWhite,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return chalkWhite.withOpacity(0.1);
              }
              if (states.contains(WidgetState.pressed)) {
                return chalkWhite.withOpacity(0.2);
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Consumer<ClozeProvider>(
      builder: (context, clozeProvider, child) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Stack(
            children: [
              // 状态提示
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getStatusText(clozeProvider.mode),
                      style: TextStyle(
                        color: chalkWhite.withOpacity(0.7),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              // 主内容区域
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: _buildContentArea(clozeProvider),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getStatusText(AppMode mode) {
    switch (mode) {
      case AppMode.edit:
        return '第 1 步：输入或导入内容';
      case AppMode.prepare:
        return '第 2 步：点击文字进行挖空，或使用随机功能';
      case AppMode.study:
        return '第 3 步：点击遮罩块查看答案';
    }
  }

  Widget _buildContentArea(ClozeProvider clozeProvider) {
    if (clozeProvider.isLoading) {
      return _buildLoadingView();
    }

    switch (clozeProvider.mode) {
      case AppMode.edit:
        return _buildEditView(clozeProvider);
      case AppMode.prepare:
      case AppMode.study:
        return _buildTokenView(clozeProvider);
    }
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                accentGold,
              ),
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '正在施展魔法解析图片...',
            style: TextStyle(
              color: chalkWhite.withOpacity(0.9),
              fontSize: 16,
              fontFamily: 'Comic Sans MS',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditView(ClozeProvider clozeProvider) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: chalkWhite.withOpacity(0.98), // 接近纯白
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: chalkboardShadow.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: chalkWhite.withOpacity(0.8),
          width: 1,
        ),
      ),
      child: TextField(
        controller: TextEditingController(text: clozeProvider.originalText),
        onChanged: (value) => clozeProvider.setOriginalText(value),
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontFamily: 'Comic Sans MS',
          height: 1.5,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: '在这里输入想要背诵的文字，或者粘贴内容...\n\n例如：Batch Normalization（批标准化）是一种在深度学习中常用的技术。\n\n它通过对每一层的输入进行标准化处理，使得每层的输入分布保持稳定，从而加速模型收敛，减少对初始化的依赖性，并一定程度上缓解过拟合问题。\n\n主要好处包括：\n- 更快的收敛速度\n- 减少对dropout的依赖\n- 允许使用更大的学习率',
          hintStyle: TextStyle(
            color: Colors.black38,
            fontSize: 16,
            fontFamily: 'Comic Sans MS',
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildTokenView(ClozeProvider clozeProvider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Wrap(
        spacing: 4,
        runSpacing: 8,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: List.generate(clozeProvider.clozeItems.length, (index) {
          final item = clozeProvider.clozeItems[index];

          if (item.isNewLine) {
            return const SizedBox(width: double.infinity, height: 16);
          }

          return _buildToken(clozeProvider, item, index);
        }),
      ),
    );
  }

  Widget _buildToken(ClozeProvider clozeProvider, item, int index) {
    final isMasked = item.isBlank;

    if (clozeProvider.mode == AppMode.prepare) {
      return GestureDetector(
        onTap: () => clozeProvider.toggleTokenMask(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: isMasked ? Colors.orange.withOpacity(0.2) : null,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            item.originalWord,
            style: TextStyle(
              color: isMasked ? Colors.orange.shade200 : chalkWhite.withOpacity(0.9),
              fontSize: 16,
              fontFamily: 'Comic Sans MS',
              decoration: isMasked ? TextDecoration.lineThrough : null,
              decorationColor: Colors.orange.shade300,
              decorationThickness: 2,
            ),
          ),
        ),
      );
    } else {
      // Study mode
      if (isMasked) {
        return GestureDetector(
          onTap: () => clozeProvider.toggleRevealStudy(index),
          child: Container(
            width: 42,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: item.isRevealed
                  ? Colors.transparent
                  : Colors.orange.shade200,
              borderRadius: BorderRadius.circular(4),
              border: item.isRevealed
                  ? Border.all(color: accentGold.withOpacity(0.5), width: 2)
                  : null,
            ),
            child: Text(
              item.isRevealed ? item.originalWord : '',
              style: TextStyle(
                color: item.isRevealed ? accentGold : Colors.transparent,
                fontSize: 16,
                fontFamily: 'Comic Sans MS',
                fontWeight: item.isRevealed ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      } else {
        return Text(
          item.originalWord,
          style: TextStyle(
            color: chalkWhite.withOpacity(0.9),
            fontSize: 16,
            fontFamily: 'Comic Sans MS',
          ),
        );
      }
    }
  }

  Widget _buildBottomTray() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: chalkWhite.withOpacity(0.95),
        border: Border(
          top: BorderSide(
            color: chalkboardBorder.withOpacity(0.3),
            width: 2,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: chalkboardShadow.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 清除按钮
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: chalkboardShadow.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () => _showClearConfirmDialog(context),
              icon: Icon(Icons.clear, size: 16, color: chalkboardGreen),
              label: const Text(
                '清除',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF003300),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: chalkWhite,
                foregroundColor: chalkboardGreen,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide(color: chalkboardBorder.withOpacity(0.3)),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleImageUpload(BuildContext context) {
    try {
      // 这里可以集成file_picker进行图片选择
      // 暂时显示模拟的OCR处理
      final clozeProvider = context.read<ClozeProvider>();
      clozeProvider.setOriginalText(''); // 清空当前文本
      clozeProvider.processImage('simulated_image.jpg');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('图片已处理完成')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('图片处理失败: $e')),
      );
    }
  }

  void _showClearConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认清空'),
        content: const Text('要清空黑板重新开始吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<ClozeProvider>().reset();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}