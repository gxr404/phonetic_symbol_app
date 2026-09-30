import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonetic_symbol_app/models/phonetic.model.dart';
import 'package:phonetic_symbol_app/widgets/phonetic_item.dart';
import 'package:phonetic_symbol_app/providers/phonetic.provider.dart';

@RoutePage()
class PhoneticPage extends ConsumerWidget {
  const PhoneticPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneticsGroups = ref.watch(phoneticGroupsProvider);
    // final appSettings = ref.watch(appSettingsProvider);
    // appSettings.load();
    final c = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: phoneticsGroups.when(
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('$error'),
            data: (data) {
              // print("==============1111");
              // print(data);
              // print("==============2222");
              return Container(
                padding: .symmetric(vertical: 16, horizontal: 16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // alignment: .start,
                  children: [
                    buildVowelSection(data, c),
                    const SizedBox(height: 10),
                    buildConsonantSection(data, c),
                    const SizedBox(height: 54),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildVowelSection(PhoneticGroups data, ColorScheme c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("元音", style: TextStyle(fontSize: 20, fontWeight: .bold)),
        const SizedBox(height: 20),
        buildWrapSection(
          c: c,
          children: [
            Text("单元音", style: TextStyle(fontSize: 16, fontWeight: .bold)),
            const SizedBox(height: 16),
            ...buildDetailSection(
              c: c,
              title: "前元音",
              children: [
                for (final phonetic
                    in data[PhoneticCategory.vowel]?[VowelType
                            .monophthong]?[VowelPosition.front] ??
                        [])
                  PhoneticItem(phonetic: phonetic),
              ],
            ),
            const SizedBox(height: 12),
            ...buildDetailSection(
              c: c,
              title: "中元音",
              children: [
                for (final phonetic
                    in data[PhoneticCategory.vowel]?[VowelType
                            .monophthong]?[VowelPosition.central] ??
                        [])
                  PhoneticItem(phonetic: phonetic),
              ],
            ),
            const SizedBox(height: 12),

            ...buildDetailSection(
              c: c,
              title: "后元音",
              children: [
                for (final phonetic
                    in data[PhoneticCategory.vowel]?[VowelType
                            .monophthong]?[VowelPosition.back] ??
                        [])
                  PhoneticItem(phonetic: phonetic),
              ],
            ),
            // const SizedBox(height: 10),
          ],
        ),
        const SizedBox(height: 20),
        buildWrapSection(
          c: c,
          children: [
            Text("双元音", style: TextStyle(fontSize: 16, fontWeight: .bold)),
            const SizedBox(height: 12),

            ...buildDetailSection(
              c: c,
              title: "开合双元音",
              children: [
                for (final phonetic
                    in data[PhoneticCategory.vowel]?[VowelType
                            .diphthong]?[DiphthongType.closing] ??
                        [])
                  PhoneticItem(phonetic: phonetic),
              ],
            ),
            const SizedBox(height: 12),
            ...buildDetailSection(
              c: c,
              title: "集中双元音",
              children: [
                for (final phonetic
                    in data[PhoneticCategory.vowel]?[VowelType
                            .diphthong]?[DiphthongType.centring] ??
                        [])
                  PhoneticItem(phonetic: phonetic),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildWrapSection({
    required List<Widget> children,
    required ColorScheme c,
  }) {
    return Container(
      width: double.infinity,
      padding: .symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: c.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  List<Widget> buildDetailSection({
    required String title,
    required List<Widget> children,
    required ColorScheme c,
  }) {
    return [
      Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: c.onSecondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: c.onSecondary,
              fontWeight: .bold,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Wrap(spacing: 8, runSpacing: 8, children: children),
    ];
  }

  Widget buildConsonantSection(PhoneticGroups data, ColorScheme c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("辅音", style: TextStyle(fontSize: 20, fontWeight: .bold)),
        const SizedBox(height: 20),
        buildWrapSection(
          c: c,
          children: [
            Text("清辅音", style: TextStyle(fontSize: 16, fontWeight: .bold)),

            const SizedBox(height: 16),
            ...buildDetailSection(
              c: c,
              title: "爆破音",
              children: [
                for (final phonetic
                    in data[PhoneticCategory.consonant]?[ConsonantVoicing
                            .voiceless]?[ConsonantManner.plosive] ??
                        [])
                  PhoneticItem(phonetic: phonetic),
              ],
            ),
            const SizedBox(height: 12),
            ...buildDetailSection(
              c: c,
              title: "摩擦音",
              children: [
                for (final phonetic
                    in data[PhoneticCategory.consonant]?[ConsonantVoicing
                            .voiceless]?[ConsonantManner.fricative] ??
                        [])
                  PhoneticItem(phonetic: phonetic),
              ],
            ),
            const SizedBox(height: 12),

            ...buildDetailSection(
              c: c,
              title: "破擦音",
              children: [
                for (final phonetic
                    in data[PhoneticCategory.consonant]?[ConsonantVoicing
                            .voiceless]?[ConsonantManner.affricate] ??
                        [])
                  PhoneticItem(phonetic: phonetic),
              ],
            ),
            // const SizedBox(height: 10),
          ],
        ),
        const SizedBox(height: 20),
        buildWrapSection(
          c: c,
          children: [
            Text("浊辅音", style: TextStyle(fontSize: 16, fontWeight: .bold)),
            const SizedBox(height: 16),
            ...buildDetailSection(
              c: c,
              title: "爆破音",
              children: [
                for (final phonetic
                    in data[PhoneticCategory.consonant]?[ConsonantVoicing
                            .voiced]?[ConsonantManner.plosive] ??
                        [])
                  PhoneticItem(phonetic: phonetic),
              ],
            ),
            const SizedBox(height: 12),
            ...buildDetailSection(
              c: c,
              title: "摩擦音",
              children: [
                for (final phonetic
                    in data[PhoneticCategory.consonant]?[ConsonantVoicing
                            .voiced]?[ConsonantManner.fricative] ??
                        [])
                  PhoneticItem(phonetic: phonetic),
              ],
            ),
            const SizedBox(height: 12),

            ...buildDetailSection(
              c: c,
              title: "破擦音",
              children: [
                for (final phonetic
                    in data[PhoneticCategory.consonant]?[ConsonantVoicing
                            .voiced]?[ConsonantManner.affricate] ??
                        [])
                  PhoneticItem(phonetic: phonetic),
              ],
            ),
            const SizedBox(height: 12),

            ...buildDetailSection(
              c: c,
              title: "鼻音",
              children: [
                for (final phonetic
                    in data[PhoneticCategory.consonant]?[ConsonantVoicing
                            .voiced]?[ConsonantManner.nasal] ??
                        [])
                  PhoneticItem(phonetic: phonetic),
              ],
            ),
            const SizedBox(height: 12),

            ...buildDetailSection(
              c: c,
              title: "舌侧音",
              children: [
                for (final phonetic
                    in data[PhoneticCategory.consonant]?[ConsonantVoicing
                            .voiced]?[ConsonantManner.lateral] ??
                        [])
                  PhoneticItem(phonetic: phonetic),
              ],
            ),
            const SizedBox(height: 12),

            ...buildDetailSection(
              c: c,
              title: "半元音",
              children: [
                for (final phonetic
                    in data[PhoneticCategory.consonant]?[ConsonantVoicing
                            .voiced]?[ConsonantManner.approximant] ??
                        [])
                  PhoneticItem(phonetic: phonetic),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
