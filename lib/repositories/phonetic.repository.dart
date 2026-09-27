import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonetic_symbol_app/models/phonetic.model.dart';

final phoneticRepositoryProvider = Provider(
  (ref) => PhoneticRepository(),
);


class PhoneticGroup {
  final PhoneticCategory category;
  final PhoneticType phoneticType;
  final DetailPhoneticType detailPhoneticType;
  final List<Phonetic> phonetics;

  const PhoneticGroup({
    required this.category,
    required this.phoneticType,
    required this.detailPhoneticType,
    required this.phonetics,
  });

}

class PhoneticRepository {
  Future<List<Phonetic>> getPhonetics() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/phonetic.json',
    );

    final json = jsonDecode(jsonString) as List;

    return json
        .map(
          (item) => Phonetic.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }


}