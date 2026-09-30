import 'package:flutter/material.dart';

class AppColors {
  static const phonetic = Color(0xFF2196F3);
}

class PhoneticColors extends ThemeExtension<PhoneticColors> {
  final ({
    Color vowel,
    Color consonant,
    Color diphthong,
    Color frontVowel,
    Color centralVowel,
    Color backVowel,
    Color closingVowel,
    Color centringVowel,
    Color plosive,
    Color fricative,
    Color affricate,
    Color nasal,
    Color lateral,
    Color approximant,
  }) colors;
  const PhoneticColors(this.colors);

  @override
  PhoneticColors copyWith({
    PhoneticColors? colors,
  }) {
    return colors ?? this;
  }

  @override
  PhoneticColors lerp(
    covariant PhoneticColors? other,
    double t,
  ) {
    return other ?? this;

  }
}

const lightPhoneticColors = (
  vowel: Color(0xFF5B7C99),
  consonant: Color(0xFF9A7660),
  diphthong: Color(0xFF806B8F),
  frontVowel: Color(0xFF4F6F8F),
  centralVowel: Color(0xFF527D7D),
  backVowel: Color(0xFF657D68),
  closingVowel: Color(0xFF7A805D),
  centringVowel: Color(0xFF8A705F),
  plosive: Color(0xFF916F55),
  fricative: Color(0xFF8C6260),
  affricate: Color(0xFF756681),
  nasal: Color(0xFF65718A),
  lateral: Color(0xFF596A78),
  approximant: Color(0xFF6E7378),
);

const darkPhoneticColors = (
  vowel: Color(0xFF8BA9C2),
  // consonant: Color(0xFFB69A87),
  consonant: Colors.red,
  diphthong: Color(0xFFA28FB0),
  frontVowel: Color(0xFF8FAAC4),
  centralVowel: Color(0xFF8FB5B5),
  backVowel: Color(0xFF9CAF9E),
  closingVowel: Color(0xFFAEB18A),
  centringVowel: Color(0xFFB89B86),
  plosive: Color(0xFFB99A7D),
  fricative: Color(0xFFB99190),
  affricate: Color(0xFFA99BB5),
  nasal: Color(0xFF98A5C0),
  lateral: Color(0xFF92A4B2),
  approximant: Color(0xFFA3A7AB),
);
