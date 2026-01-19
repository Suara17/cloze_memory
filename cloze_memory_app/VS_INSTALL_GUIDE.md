# Visual Studio Build Tools 安装指南

## 下载地址
**官方网站**: https://visualstudio.microsoft.com/downloads/

## 安装步骤

### 1. 选择正确的版本
- 找到 **"Build Tools for Visual Studio 2022"**
- 点击下载 (vs_BuildTools.exe)

### 2. 运行安装程序
- 双击下载的 `vs_BuildTools.exe`
- 等待安装程序加载

### 3. 选择工作负载
在安装程序中，选择以下组件：
- ✅ **Desktop development with C++**
  - 这将包括所有必要的C++编译器和Windows SDK

### 4. 安装位置
- **建议安装到**: `E:\VS_BuildTools\`
- 避免安装到C盘

### 5. 等待安装完成
- 安装需要一些时间（大约30分钟到1小时）
- 确保网络连接稳定

### 6. 重启计算机
- 安装完成后必须重启计算机
- 环境变量需要重启后生效

## 验证安装

安装完成后，运行：
```bash
flutter doctor
```

应该显示：
```
[✓] Visual Studio - develop Windows apps
```

## 如果安装失败

### 选项1: 使用Visual Studio Community (免费完整版)
- 下载: https://visualstudio.microsoft.com/downloads/
- 选择 "Visual Studio Community 2022"
- 安装时选择 "Desktop development with C++" 工作负载

### 选项2: 使用在线安装器
如果离线安装包有问题，可以使用在线安装器。

## 安装后的测试

安装完成后，在新的命令提示符中运行：
```bash
cd E:\flutter_app
flutter run -d windows
```

您的挖空背书桌面应用就可以运行了！