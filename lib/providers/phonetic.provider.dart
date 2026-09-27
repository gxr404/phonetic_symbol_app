import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phonetic_symbol_app/models/phonetic.model.dart';
import 'package:phonetic_symbol_app/repositories/phonetic.repository.dart';

final phoneticProvider = FutureProvider<List<Phonetic>>(
  (ref) => ref.watch(phoneticRepositoryProvider).getPhonetics()
);

Future<Map<
  PhoneticCategory,
  Map<PhoneticType, Map<DetailPhoneticType, List<Phonetic>>>
>> groupPhoneticsByType(List<Phonetic> phonetics) async {
  final result = <
    PhoneticCategory,
    Map<PhoneticType, Map<DetailPhoneticType, List<Phonetic>>>
  >{};

  for (final phonetic in phonetics) {
    // 根据 phonetic 计算这三个分类

    final category = phonetic.category;
    late final PhoneticType phoneticType;
    late final DetailPhoneticType detailPhoneticType;

    switch (category) {
      case PhoneticCategory.vowel:
        final vowel = phonetic.vowel!;
        phoneticType = vowel.type;
        switch (vowel.type) {
          case VowelType.monophthong:
            detailPhoneticType = vowel.position!;
            break;
          case VowelType.diphthong:
            detailPhoneticType = vowel.diphthongType!;
            break;
        }
        break;
      case PhoneticCategory.consonant:
        final consonant = phonetic.consonant!;
        phoneticType = consonant.voicing;
        detailPhoneticType = consonant.manner;
        break;
    }

    result
      .putIfAbsent(
        phonetic.category,
        () => {},
      )
      .putIfAbsent(
        phoneticType,
        () => {},
      )
      .putIfAbsent(
        detailPhoneticType,
        () => [],
      )
      .add(phonetic);

  }

  return result;

}

typedef PhoneticGroups = Map<
  PhoneticCategory,
  Map<PhoneticType, Map<DetailPhoneticType, List<Phonetic>>>
>;
final phoneticGroupsProvider = FutureProvider<PhoneticGroups>(
  (ref) {
    final phonetics = ref.watch(phoneticProvider).valueOrNull;
    if (phonetics == null) {
      return {};
    }
    return groupPhoneticsByType(phonetics);

  },

);