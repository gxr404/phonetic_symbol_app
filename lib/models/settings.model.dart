import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings.model.g.dart';


enum Pronounce {
  us('US', '美音'),
  uk('UK', '英音');

  final String value;
  final String label;

  const Pronounce(this.value, this.label);
}

enum AppTheme {
  light(Brightness.light, 'Light'),
  dark(Brightness.dark, 'Dark');

  final Brightness value;
  final String label;

  const AppTheme(this.value, this.label);
}

@JsonSerializable(createJsonSchema: true)
class Settings {
  final AppTheme theme;
  final Pronounce pronounce;

  const Settings({
    required this.theme,
    required this.pronounce,
  });

  Settings copyWith({
    AppTheme? theme,
    Pronounce? pronounce,
  }) {

    return Settings(
      theme: theme ?? this.theme,
      pronounce: pronounce ?? this.pronounce
    );
  }

  factory Settings.defaultSettings() {
    return const Settings(
      theme: AppTheme.dark,
      pronounce: Pronounce.us,
    );
  }

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}