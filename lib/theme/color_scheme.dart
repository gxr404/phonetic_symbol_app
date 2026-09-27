import 'package:flutter/material.dart';

final colorSchemePreset = {
  Brightness.light: ColorScheme(
    brightness: Brightness.light,
    // primary: Colors.blue[300]!,
    primary: Colors.black,
    // primary: Color(0xff151b23),
    onPrimary: Colors.white,
    secondary: Colors.grey[850]!,
    onSecondary: Color(0xff59636e),
    // 「承载 UI 内容的基础背景色」，也就是各种卡片、面板、菜单、Dialog 等“表面”的默认颜色
    surface: Colors.white,
    onSurface: Colors.black,
    onSurfaceVariant: Colors.grey[400]!,
    // surfaceContainerHighest: Colors.grey[300]!,
    surfaceContainerHighest: Color(0xffe6eaef),
    // 分割线
    outline: Colors.grey,
    outlineVariant: Colors.grey[300]!,

    error: Colors.redAccent,
    onError: Colors.white
  ),
  Brightness.dark:  ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff141b24),
    onPrimary: Colors.white,
    secondary: Colors.black,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    error: Colors.redAccent,
    onError: Colors.white,

    surface: Color(0xff272d36),
    // surface: Color(0xff2a313c),
    // surface: Colors.red,
    surfaceContainerHighest: Color(0xff151b23),
  )
};