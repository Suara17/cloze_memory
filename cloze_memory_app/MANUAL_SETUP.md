# 手动安装指南 - 如果自动脚本失败

## 1. 下载Flutter SDK
1. 打开浏览器访问: https://flutter.dev/docs/get-started/install/windows
2. 点击 "Get the Flutter SDK" 按钮
3. 下载最新的 Windows zip 文件 (flutter_windows_xxx.zip)
4. 将下载的zip文件解压到: `E:\flutter`
   - 解压后应该有: `E:\flutter\bin\flutter.bat`

## 2. 下载Android Command Line Tools
1. 打开浏览器访问: https://developer.android.com/studio#command-tools
2. 下载 "Command line tools only" (SDK Tools download)
3. 将zip文件解压到: `E:\Android\Sdk\cmdline-tools\latest`
   - 解压后应该有: `E:\Android\Sdk\cmdline-tools\latest\bin\sdkmanager.bat`

## 3. 配置环境变量 (重要!)
1. 右键点击 "此电脑" -> "属性"
2. 点击 "高级系统设置"
3. 点击 "环境变量"
4. 在"系统变量"部分:

### 添加新的系统变量:
- `FLUTTER_HOME = E:\flutter`
- `ANDROID_HOME = E:\Android\Sdk`
- `ANDROID_SDK_ROOT = E:\Android\Sdk`

### 修改PATH变量:
在Path中添加以下路径 (每行一个):
```
E:\flutter\bin
E:\Android\Sdk\platform-tools
E:\Android\Sdk\tools\bin
```

## 4. 验证安装
1. 打开新的命令提示符 (重要!)
2. 运行: `flutter --version`
3. 运行: `flutter doctor --android-licenses`
4. 运行: `flutter doctor`

## 5. 如果遇到问题
- 确保所有路径都正确
- 重新启动命令提示符
- 运行 `check_setup.bat` 检查配置
- 如果仍有问题，请告诉我具体错误信息