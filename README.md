# 挖空背书应用

一个简约优雅的Flutter应用，帮助用户通过挖空填空的方式进行记忆学习。

## 🚀 快速开始（推荐）

### 一键下载使用

**无需安装任何开发环境，下载即可使用！**

1. **下载安装包**
   - 访问 [Releases 页面](https://github.com/Suara17/cloze_memory/releases)
   - 下载最新版本的 `cloze_memory_app_portable.zip`

2. **解压运行**
   - 解压zip文件到任意目录
   - 双击 `cloze_memory_app.exe` 即可运行

3. **系统要求**
   - Windows 10 或更高版本
   - 无需安装Flutter或任何开发工具
   - 解压后约 26MB 磁盘空间

---

界面展示：
<img width="1584" height="892" alt="image" src="https://github.com/user-attachments/assets/622388b6-0965-4de2-aab9-f6d66db3e851" />
<img width="1582" height="853" alt="image" src="https://github.com/user-attachments/assets/0dfec631-063e-446c-9d80-5ab15b08ad40" />


## 技术栈

- Flutter 3.0+
- Provider (状态管理)
- File Picker (文件选择)
- Shared Preferences (数据持久化)

---

## 💻 开发者模式

如果你想自己编译和修改代码，请按照以下步骤操作：

### 安装和运行

```bash
# 克隆仓库
git clone https://github.com/Suara17/cloze_memory.git
cd cloze_memory/cloze_memory_app

# 获取依赖
flutter pub get

# 运行应用
flutter run -d windows
```

详细的环境配置和开发指南请参考:
- [手动安装指南](MANUAL_SETUP.md)
- [VS安装指南](VS_INSTALL_GUIDE.md)
- [Windows打包指南](WINDOWS_PACKAGING_GUIDE.md)

## 使用方法

### 应用功能
应用采用三步流程设计，模拟教室黑板的学习环境：

#### 第1步：输入内容
- 在黑板上直接输入或粘贴需要背诵的文本
- 点击"导入图片"按钮可以上传图片进行OCR识别
- 支持中英文混合输入

#### 第2步：挖空设置
- 点击"去挖空"进入准备模式
- 点击任何文字可将其标记为挖空（橙色删除线）
- 使用"随机挖空"按钮自动随机隐藏40%的内容
- 点击"重置"清除所有挖空标记

#### 第3步：背诵练习
- 点击"开始背诵"进入练习模式
- 挖空处显示为橙色遮罩块
- 点击遮罩块可查看答案（黄色高亮显示）
- 再次点击可隐藏答案

#### 底部功能
- 右下角的黑板擦可以清空所有内容重新开始

## 界面特色

- 🎨 **黑板风格UI**：深绿色黑板背景，木质边框设计
- 📝 **三步学习流程**：输入 → 挖空设置 → 背诵练习
- 🎯 **智能分词**：自动识别中英文单词和标点符号
- 🔄 **交互式挖空**：手动选择或自动随机挖空
- 👆 **点击揭示**：点击遮罩块即时查看答案
- 🎪 **装饰元素**：贴纸装饰和粉笔槽设计
- 📱 **响应式布局**：适配不同屏幕尺寸

## 项目结构

```
lib/
├── main.dart              # 应用入口
├── providers/
│   └── cloze_provider.dart # 状态管理和业务逻辑
├── screens/
│   └── home_screen.dart    # 主界面（黑板风格）
├── models/
│   └── cloze_item.dart     # 挖空项数据模型
└── widgets/               # （已整合到主界面中）
```

## 许可证

MIT License
