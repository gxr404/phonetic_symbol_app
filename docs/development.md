# Development

## Scripts

代码生成

```bash
# 生成启动动画(启动动画相关配置默认在 pubspec.yaml,本项目在flutter_native_splash)
dart run flutter_native_splash:create
# 自动生成 App 启动图标(相关配置默认在 pubspec.yaml)
dart run flutter_launcher_icons

# 一些依赖包基于build_runner生成代码(auto_route/json_serializable)
dart run build_runner watch
dart run build_runner build
```

开发运行

```bash
# 清理
flutter clean

# dev
flutter run

# # dev macos
# flutter run -d macos
# # dev windows
# flutter run -d windows

# 启动模拟器
# android
flutter emulators --launch <deviceId>
flutter emulators --launch Pixel_7_Pro_API_36

# ios
# 查看当前系统支持的simulator，复制 id
xcrun simctl list devices
# 启动 指定的 simulator
xcrun simctl boot 9916ACF4-6C67-4A10-99FC-21D177032E64
# 如未显示可执行
open -a Simulator
```

## Architecture

> [flutter官方最佳实践的架构](https://docs.flutter.dev/app-architecture/guide#repositories)

### Repository

Repository 负责

- 从 Service 中取得数据
- 将 原数据转换为 **Domain Model**

> Domain Model 为 App 所需要的数据

### Dependencies

- [riverpod](https://github.com/rrousselgit/riverpod): 状态管理
- [flutter_native_splash](https://github.com/jonbhanson/flutter_native_splash): 生成启动动画
- [flutter_launcher_icons](https://github.com/fluttercommunity/flutter_launcher_icons): 生成 App 启动图标
- [flutter_markdown_plus](https://github.com/foresightmobile/flutter_markdown_plus): markdown渲染
- [auto_route](https://github.com/Milad-Akarie/auto_route_library) : 路由
- [just_audio](https://github.com/ryanheise/just_audio): 音频播放
- [flutter_secure_storage](https://github.com/juliansteenbakker/flutter_secure_storage): 本地存储
- [json_serializable](https://github.com/google/json_serializable.dart)
- [circular_bottom_navigation](https://github.com/benyaminbeyzaei/circular_bottom_navigation)
- [super_tooltip](https://github.com/bensonarafat/super_tooltip)


## Deployment

```bash
# 1. 执行升版本
bash scripts/bump.sh
# 2. 脚本触发 git tag 的推送继而触发github action
# .github/workflows/release.yml
```

## 遇到的问题

- versionCode
  - app-v1.0.6-1-arm64-v8a-release.apk 编译后得到的versionCode 2001
  - app-v1.0.6-1-release.apk 编译后得到的versionCode 1
    - [相关docs](https://github.com/flutter/flutter/blob/d649d2bfebfeb0018b7333bd7bee1d5127661da2/docs/platforms/android/website-page-draft.md#setting-per-abi-or-per-variant-versioncode)
    - build时 `--split-per-abi` 设置每个 ABI 的版本代码