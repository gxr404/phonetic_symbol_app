import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonetic_symbol_app/models/settings.model.dart';
import 'package:phonetic_symbol_app/services/secure_storage.service.dart';

const SETTINGS_KEY = 'app_settings';

final settingsRepositoryProvider = Provider(
  (ref) => SettingsRepository(
    ref.watch(secureStorageProvider)
  )
);

class SettingsRepository {
  final SecureStorageService storage;
  SettingsRepository(this.storage);

  Future<Settings> load() async {
    final value = await storage.read(SETTINGS_KEY);
    if (value == null) {
      final settings = Settings.defaultSettings();
      await save(settings);
      return settings;
    }
    return Settings.fromJson(
      jsonDecode(value),
    );
  }

  Future<void> save(Settings settings) async {
    await storage.write(
      SETTINGS_KEY,
      jsonEncode(settings.toJson()),
    );

  }
}