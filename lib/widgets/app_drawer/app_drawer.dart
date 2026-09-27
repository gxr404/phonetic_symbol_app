import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonetic_symbol_app/models/settings.model.dart';
import 'package:phonetic_symbol_app/providers/settings.provider.dart';

class AppDrawer extends ConsumerStatefulWidget {
  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {

  // late final Pronounce _pronounce;
  // Pronounce _pronounce = Pronounce.us;
  // AppTheme _appTheme = AppTheme.light;

  @override
  void initState() {
    super.initState();
    // _pronounce = Pronounce.us;
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsNotifierProvider).requireValue;

    final c = Theme.of(context).colorScheme;

    const gap = 14.0;
    return Drawer(
      // shadowColor: c.onPrimary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 56.0,
              child: Align(
                alignment: Alignment.centerLeft, // 让文字靠左对齐
                child: Text(
                  '设置',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: c.onSurface,
                    fontSize: 16.0
                  ),
                ),
              ),
            ),
            const Divider(height: 0),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  const SizedBox(height: gap),
                  Row(
                    children: [
                      SizedBox(width: 100, child: const Text('发音: ')),
                      Expanded(
                        child: genSwitch<Pronounce>(
                          context,
                          currnet: settings.pronounce,
                          values: Pronounce.values,
                          onChanged: (v) {
                            // setState(() => _pronounce = v);
                            ref.read(settingsNotifierProvider.notifier).togglePronounce();
                          },
                          labelBuilder: (current) => current.label
                        ),
                      )
                      // Expanded(child: Slider(value: 'en', onChanged: onChanged))
                    ],
                  ),
                  const SizedBox(height: gap),
                  Row(
                    children: [
                      SizedBox(width: 100, child: const Text('主题: ')),
                      Expanded(
                        child: genSwitch<AppTheme>(
                          context,
                          currnet: settings.theme,
                          values: AppTheme.values,
                          onChanged: (v) {
                            // setState(() => _appTheme = v);
                            ref.read(settingsNotifierProvider.notifier).toggleTheme();
                          },
                          labelBuilder: (current) => current.label
                        ),
                      )
                      // Expanded(child: Slider(value: 'en', onChanged: onChanged))
                    ],
                  )
                ],
              )
            ),
            // Bottom
            const Divider(height: 0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  // Text('Phonetic', style: TextStyle(fontSize: 14, color: c.onSurfaceVariant)),
                  Text('v0.0.1', style: TextStyle(fontSize: 14, color: c.onSurfaceVariant)),
                ],
              )
            )
          ]
        ),
      )
    );
  }

  Widget genSwitch<T>(
    BuildContext context,{
    required T currnet,
    required List<T> values,
    // required FutureOr<void> Function(T) onChanged,
    required ValueChanged<T> onChanged,
    required String Function(T) labelBuilder
  }) {
    final c = Theme.of(context).colorScheme;

    final switchStyle = ToggleStyle(
      borderColor: c.surfaceContainerHighest,
      backgroundColor: c.surfaceContainerHighest,
      indicatorColor: c.onPrimary,
      borderRadius: BorderRadius.circular(6.0),
      indicatorBorderRadius: BorderRadius.circular(4.0),
    );
    return AnimatedToggleSwitch<T>.size(
      textDirection: TextDirection.rtl,
      height: 30.0,
      current: currnet,
      values: values,
      selectedIconScale: 1.0,
      indicatorSize: const Size.fromWidth(100.0),
      customIconBuilder: (context, local, global) {
        final c = Theme.of(context).colorScheme;
        return Text(
          labelBuilder(local.value),
          style: TextStyle(
            fontSize: 12,
            // color: c.primary
            color: Color.lerp(
              c.onSecondary,
              c.primary,
              local.animationValue
            )
          )
        );
      },
      borderWidth: 4.0,
      iconOpacity: 1.0,
      iconAnimationType: AnimationType.onHover,
      style: switchStyle,
      onChanged: onChanged
    );
  }
}