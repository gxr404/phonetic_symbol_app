import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonetic_symbol_app/providers/settings.provider.dart';
import 'package:phonetic_symbol_app/routing/router.dart';
import 'package:phonetic_symbol_app/theme/color_scheme.dart';
import 'package:phonetic_symbol_app/theme/theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge));
  SystemChrome.setSystemUIOverlayStyle(
    // SystemUiOverlayStyle.dark,
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarContrastEnforced: false,
    )
  );
  runApp(
    ProviderScope(
      child: MyApp()
    )
  );
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final settings = ref.watch(settingsNotifierProvider);
    return settings.when(
      loading: () => const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (error, stackTrace) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Failed to load settings: $error'),
          ),
        ),
      ),
      data: (settings) => MaterialApp.router(
        routerConfig: _appRouter.config(),
        theme: getThemeData(
          colorSchemePreset[settings.theme.value]!,
          settings.theme.value
        ),
      ),
  );
  }
}

