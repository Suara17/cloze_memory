# Cloze Memory App - Windows打包和分发指南

## 📦 概述

本指南介绍如何将Flutter桌面应用打包成可分发的Windows安装程序。

## 🎯 快速开始

### 方法1：自动打包（推荐）
1. 双击运行 `build_release.bat` - 构建发布版本
2. 双击运行 `package_installer.bat` - 创建安装程序

### 方法2：手动打包
按照下面的详细步骤操作。

---

## 📋 前置要求

### 必需软件
- **Flutter SDK** (3.0+) - 已安装在 `E:\flutter\flutter`
- **Visual Studio Build Tools** - 包含C++桌面开发组件
- **NSIS** (Nullsoft Scriptable Install System) - 用于创建安装程序

### 环境检查
运行以下命令验证环境：
```bash
flutter doctor
```

确保显示：
- ✅ Flutter (Channel stable)
- ✅ Visual Studio - develop for Windows
- ✅ Windows • Visual Studio Build Tools

---

## 🔨 构建发布版本

### 步骤1：构建Release版本
```bash
# 切换到项目目录
cd E:\flutter_app

# 安装依赖
flutter pub get

# 构建Windows发布版本
flutter build windows --release
```

### 步骤2：验证构建结果
构建完成后，检查：
```
E:\flutter_app\build\windows\x64\runner\Release\cloze_memory_app.exe
```

这个exe文件就是可执行程序，可以直接在Windows上运行。

---

## 📦 创建安装程序

### 方法1：使用自动化脚本

1. **构建发布版本**：
   ```bash
   # 双击 build_release.bat 或运行：
   .\build_release.bat
   ```

2. **创建安装程序**：
   ```bash
   # 双击 package_installer.bat 或运行：
   .\package_installer.bat
   ```

   脚本会自动：
   - 检查NSIS是否安装
   - 创建安装程序结构
   - 生成NSIS脚本
   - 构建安装程序

3. **结果**：
   - 安装程序：`ClozeMemoryApp_Installer.exe`
   - 大小：约50MB

### 方法2：手动创建安装程序

#### 安装NSIS
1. 下载NSIS：https://nsis.sourceforge.io/Download
2. 运行安装程序，选择完整安装
3. 验证安装：打开命令提示符，输入 `makensis /VERSION`

#### 创建安装程序结构
```bash
# 创建临时目录
mkdir installer_temp
mkdir installer_temp\app

# 复制应用文件
xcopy build\windows\x64\runner\Release\* installer_temp\app\ /e /i /h /y
```

#### 创建NSIS脚本
创建一个名为 `installer.nsi` 的文件，内容如下：

```nsi
!include "MUI2.nsh"
!include "FileFunc.nsh"
!include "LogicLib.nsh"

Name "Cloze Memory App"
OutFile "ClozeMemoryApp_Installer.exe"
Unicode True
InstallDir "$PROGRAMFILES\Cloze Memory App"
InstallDirRegKey HKCU "Software\ClozeMemoryApp" ""
RequestExecutionLevel admin

!define MUI_ABORTWARNING
!define MUI_ICON "installer_temp\app\cloze_memory_app.exe"
!define MUI_UNICON "installer_temp\app\cloze_memory_app.exe"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "English"

Section "MainSection" SEC01
    SetOutPath "$INSTDIR"
    File /r "installer_temp\app\*"

    ; Create desktop shortcut
    CreateShortCut "$DESKTOP\Cloze Memory App.lnk" "$INSTDIR\cloze_memory_app.exe" "" "$INSTDIR\cloze_memory_app.exe" 0

    ; Create start menu entries
    CreateDirectory "$SMPROGRAMS\Cloze Memory App"
    CreateShortCut "$SMPROGRAMS\Cloze Memory App\Cloze Memory App.lnk" "$INSTDIR\cloze_memory_app.exe" "" "$INSTDIR\cloze_memory_app.exe" 0
    CreateShortCut "$SMPROGRAMS\Cloze Memory App\Uninstall.lnk" "$INSTDIR\Uninstall.exe" "" "$INSTDIR\Uninstall.exe" 0

    ; Registry information for add/remove programs
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "DisplayName" "Cloze Memory App"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "QuietUninstallString" "$\"$INSTDIR\uninstall.exe$\" /S"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "InstallLocation" "$\"$INSTDIR$\""
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "DisplayIcon" "$\"$INSTDIR\cloze_memory_app.exe$\""
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "Publisher" "Your Name"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "HelpLink" "https://github.com/yourusername/cloze-memory-app"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "URLUpdateInfo" "https://github.com/yourusername/cloze-memory-app"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "URLInfoAbout" "https://github.com/yourusername/cloze-memory-app"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "DisplayVersion" "1.0.0"
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "VersionMajor" 1
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "VersionMinor" 0
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "NoModify" 1
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "NoRepair" 1
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "EstimatedSize" 50000

    WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

Section "Uninstall"
    Delete "$DESKTOP\Cloze Memory App.lnk"
    Delete "$SMPROGRAMS\Cloze Memory App\Cloze Memory App.lnk"
    Delete "$SMPROGRAMS\Cloze Memory App\Uninstall.lnk"
    RMDir "$SMPROGRAMS\Cloze Memory App"

    Delete "$INSTDIR\cloze_memory_app.exe"
    Delete "$INSTDIR\Uninstall.exe"
    RMDir "$INSTDIR"

    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp"
    DeleteRegKey HKCU "Software\ClozeMemoryApp"
SectionEnd
```

#### 构建安装程序
```bash
# 编译NSIS脚本
makensis installer.nsi
```

---

## 📋 安装程序特性

### 安装功能
- ✅ 自动安装到 Program Files
- ✅ 创建桌面快捷方式
- ✅ 创建开始菜单项
- ✅ 注册到Windows卸载程序
- ✅ 支持中文和英文界面

### 卸载功能
- ✅ 完全卸载所有文件
- ✅ 删除快捷方式和注册表项
- ✅ 从卸载程序列表中移除

---

## 🔍 测试安装程序

### 本地测试
1. 运行 `ClozeMemoryApp_Installer.exe`
2. 选择安装位置（或使用默认）
3. 完成安装
4. 从桌面或开始菜单启动应用
5. 测试所有功能

### 虚拟机测试（推荐）
1. 创建Windows虚拟机
2. 复制安装程序到虚拟机
3. 运行安装和测试

---

## 🚀 分发和部署

### 文件分发
- **安装程序**：`ClozeMemoryApp_Installer.exe` (约50MB)
- **独立exe**：`build\windows\x64\runner\Release\cloze_memory_app.exe` (约30MB)

### 版本管理
- 更新 `pubspec.yaml` 中的版本号
- 在NSIS脚本中更新版本信息
- 重新构建和打包

### 系统要求（分发时告知用户）
- Windows 10 或更高版本
- 至少 100MB 可用磁盘空间
- 管理员权限（用于安装）

---

## 🐛 故障排除

### 构建失败
```
Error: Visual Studio Build Tools not found
```
**解决**：安装Visual Studio Build Tools，包含"使用C++的桌面开发"

### NSIS问题
```
makensis command not found
```
**解决**：重新安装NSIS或添加到PATH

### 应用无法启动
1. 检查是否所有依赖都已包含
2. 验证exe文件完整性
3. 检查Windows兼容性

### 安装程序创建失败
1. 确保所有文件都存在
2. 检查NSIS脚本语法
3. 验证文件路径正确

---

## 📚 相关资源

- [Flutter Windows部署](https://docs.flutter.dev/deployment/windows)
- [NSIS文档](https://nsis.sourceforge.io/Docs/)
- [Flutter打包指南](https://docs.flutter.dev/deployment)
- [Visual Studio Build Tools](https://visualstudio.microsoft.com/downloads/)

---

## 📞 支持

如果遇到问题，请检查：
1. Flutter环境配置
2. Visual Studio安装
3. NSIS安装
4. 项目依赖完整性

最后更新：2024年12月