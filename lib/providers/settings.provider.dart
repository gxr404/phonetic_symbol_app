import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonetic_symbol_app/models/settings.model.dart';
import 'package:phonetic_symbol_app/repositories/settings.repository.dart';

final settingsNotifierProvider =
  AsyncNotifierProvider<SettingsNotifier, Settings>(
    SettingsNotifier.new
  );



class SettingsNotifier extends AsyncNotifier<Settings> {
  late final SettingsRepository _repository;

  @override
  Future<Settings> build() async {
    _repository = ref.watch(settingsRepositoryProvider);
    return _repository.load();
  }

  Future<void> toggleTheme() async {
    final current = state.valueOrNull;
    if (current == null) return;
    final newSettings = current.copyWith(
      theme: current.theme == AppTheme.dark
        ? AppTheme.light
        : AppTheme.dark
    );
    state = AsyncData(newSettings);
    await _repository.save(newSettings);
  }

  Future<void> togglePronounce() async {
    final current = state.valueOrNull;
    if (current == null) return;
    final newSettings = current.copyWith(
      pronounce: current.pronounce == Pronounce.uk
        ? Pronounce.us
        : Pronounce.uk
    );
    state = AsyncData(newSettings);
    await _repository.save(newSettings);
  }
}