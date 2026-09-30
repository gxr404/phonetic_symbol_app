import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:phonetic_symbol_app/models/phonetic.model.dart';
import 'package:phonetic_symbol_app/models/settings.model.dart';
import 'package:phonetic_symbol_app/providers/settings.provider.dart';
import 'package:phonetic_symbol_app/theme/colors.dart';
import 'package:super_tooltip/super_tooltip.dart';

class PhoneticItem extends ConsumerStatefulWidget {
  final Phonetic phonetic;

  const PhoneticItem({super.key, required this.phonetic});

  @override
  ConsumerState<PhoneticItem> createState() => _PhoneticItemState();
}

class _PhoneticItemState extends ConsumerState<PhoneticItem> {
  late final AudioPlayer audioPlayer;
  late final SuperTooltipController _controller;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _controller = SuperTooltipController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> playAudio(String? audioFile) async {
    final phonetic = widget.phonetic;

    try {
      if (audioFile == null || audioFile.isEmpty) {
        throw StateError(
          'Audio file not found for phonetic: ${phonetic.phonetic}',
        );
      }
      final path = 'assets/phonetic_audio/$audioFile';
      print('AUDIO PATH = [$path]');
      print('AUDIO PATH LENGTH = ${path.length}');
      await audioPlayer.setAsset(
        // 'assets/phonetic_audio/test.m4a'
        // 'assets/phonetic_audio/j_uk.m4a',
        path,
      );
      await audioPlayer.play();
    } catch (e, s) {
      print("-------------------");
      print(e);
      print(s);
      print("-------------------");
    }
  }

  @override
  Widget build(BuildContext context) {
    final phonetic = widget.phonetic;
    final c = Theme.of(context).colorScheme;
    final phoneticColors = Theme.of(context).extension<PhoneticColors>()!;
    final Color bgColor = getColorType(phoneticColors);
    final settings = ref.watch(settingsNotifierProvider).requireValue;

    return SuperTooltip(
      controller: _controller,
      positionConfig: PositionConfiguration(
        preferredDirection: TooltipDirection.auto,
      ),
      interactionConfig: const InteractionConfiguration(
        // hideOnTap: true
        showOnTap: false,
      ),
      arrowConfig: ArrowConfiguration(tipDistance: 16.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              text: '美式发音',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              final audioFile = settings.pronounce == Pronounce.uk
                ? phonetic.ukFile
                : phonetic.usFile;
              playAudio(audioFile);
            },
            onLongPress: () {
              // TODO: tips音标备注信息
              // _controller.showTooltip();
            },
            child: Center(
              child: Text(
                phonetic.phonetic,
                textAlign: .center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: GoogleFonts.notoSans().fontFamily,
                  fontWeight: FontWeight.bold,
                  color: c.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color getColorType(PhoneticColors phoneticColors) {
    final phonetic = widget.phonetic;

    if (phonetic.category == PhoneticCategory.vowel) {
      if (phonetic.vowel!.type == VowelType.monophthong) {
        // 单元音
        switch (phonetic.vowel!.position!) {
          case VowelPosition.front:
            return phoneticColors.colors.frontVowel;
          case VowelPosition.central:
            return phoneticColors.colors.centralVowel;
          case VowelPosition.back:
            return phoneticColors.colors.backVowel;
        }
      } else {
        // 双元音
        if (phonetic.vowel!.diphthongType! == DiphthongType.centring) {
          return phoneticColors.colors.centringVowel;
        }
        return phoneticColors.colors.closingVowel;
      }
    }

    switch (phonetic.consonant!.manner) {
      case ConsonantManner.plosive:
        return phoneticColors.colors.plosive;
      case ConsonantManner.affricate:
        return phoneticColors.colors.affricate;
      case ConsonantManner.approximant:
        return phoneticColors.colors.approximant;
      case ConsonantManner.fricative:
        return phoneticColors.colors.fricative;
      case ConsonantManner.lateral:
        return phoneticColors.colors.lateral;
      case ConsonantManner.nasal:
        return phoneticColors.colors.nasal;
    }
  }
}
