# phonetic_symbol_app

## Getting Started

## Scripts

```bash
# 生成启动动画
dart run flutter_native_splash:create
# App icon setup
dart run flutter_launcher_icons
# build runner watch
dart run build_runner watch

# 清理
flutter clean
```

## Architecture

> [flutter官方最佳实践的架构](https://docs.flutter.dev/app-architecture/guide#repositories)

### Repository

Repository 负责

- 从 Service 中取得数据
- 将 原数据转换为 **Domain Model**

> Domain Model 为 App 所需要的数据

