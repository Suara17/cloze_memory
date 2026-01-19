# 挖空背书应用

一个简约优雅的Flutter应用，帮助用户通过挖空填空的方式进行记忆学习。

## 功能特点

- 📝 **文本输入**：直接输入需要背诵的文本内容
- 📁 **文件上传**：支持上传TXT格式的文本文件
- 🎯 **智能挖空**：随机选择单词进行挖空，可自定义挖空数量
- ✅ **答案检查**：实时检查填空答案并显示正确率
- 🎨 **简约设计**：采用Material Design 3风格，界面简洁优雅

## 技术栈

- Flutter 3.0+
- Provider (状态管理)
- File Picker (文件选择)
- Shared Preferences (数据持久化)

## 安装和运行

### 环境要求
- Windows 10 或更高版本
- 至少 8GB RAM
- 至少 2GB 可用磁盘空间（安装在E盘）

### 安装步骤

#### 1. 运行自动安装脚本（推荐）
双击运行 `install_environment.bat` 文件，它会指导您完成所有安装步骤。

#### 2. 手动安装Flutter SDK到E盘
```cmd
# 创建Flutter目录
mkdir E:\flutter

# 下载Flutter SDK (替换为最新版本链接)
# 从 https://flutter.dev/docs/get-started/install/windows 下载zip文件
# 解压到 E:\flutter\flutter

# 或者使用Git克隆（推荐）
cd /d E:\flutter
git clone https://github.com/flutter/flutter.git -b stable
```

#### 3. 手动安装Android SDK到E盘
```cmd
# 创建Android SDK目录
mkdir E:\Android\Sdk

# 下载Android Command Line Tools
# 从 https://developer.android.com/studio#command-tools 下载
# 解压到 E:\Android\Sdk\cmdline-tools\latest
```

#### 3. 配置环境变量
将以下路径添加到系统PATH环境变量：
- `E:\flutter\flutter\bin`
- `E:\Android\Sdk\platform-tools`
- `E:\Android\Sdk\tools\bin`

#### 4. 配置Flutter
```bash
# 运行flutter doctor检查环境
flutter doctor --android-licenses
flutter doctor
```

#### 5. 运行项目
```bash
cd /d E:\flutter_app
flutter pub get
flutter run
```

或者双击 `run.bat` 文件自动执行上述步骤。

### 快速开始
1. 双击 `check_setup.bat` 检查环境配置
2. 如果检查失败，双击 `install_environment.bat` 或 `setup_environment.ps1` 安装所需工具
3. **桌面版本**: 安装Visual Studio后，双击 `run_desktop.bat`
4. **网页版本**: 双击 `launch.bat` 选择Chrome浏览器

### 注意事项
- 所有脚本现已修复编码问题，支持中文显示
- 如果批处理文件仍有乱码，可以使用 PowerShell 脚本 `setup_environment.ps1`
- 所有开发工具都安装在E盘，不会占用C盘空间

## 使用方法

### 运行应用
1. **开发模式**：双击 `run_desktop.bat` 或运行 `flutter run -d windows`
2. **网页版本**：双击 `launch.bat` 并选择选项2

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