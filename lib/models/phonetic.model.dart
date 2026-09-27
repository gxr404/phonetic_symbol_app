import 'package:json_annotation/json_annotation.dart';

part 'phonetic.model.g.dart';


sealed class PhoneticType {
  const PhoneticType();
}

sealed class DetailPhoneticType {
  const DetailPhoneticType();
}


enum PhoneticCategory {
  vowel,
  consonant,
}

/// 单元音 / 双元音
enum VowelType implements PhoneticType {
  /// 单元音
  monophthong,
  /// 双元音
  diphthong,
}

/// 前 / 中 / 后元音
enum VowelPosition implements DetailPhoneticType {
  /// 前元音
  front,
  /// 中元音
  central,
  /// 后元音
  back,
}

/// 双元音类型
enum DiphthongType implements DetailPhoneticType {
  /// 开合双元音
  closing,
  /// 集中双元音
  centring,
}

/// 元音高度
@JsonEnum(fieldRename: FieldRename.snake)
enum VowelHeight {
  close,
  nearClose,
  closeMid,
  mid,
  openMid,
  nearOpen,
  open,
}

/// 舌位前后
enum VowelBackness {
  /// 
  front,
  /// 
  central,
  /// 
  back,
}

/// 长短
enum VowelLength {
  short,
  long,
}

/// 辅音清浊
enum ConsonantVoicing implements PhoneticType {
  /// 浊音
  voiced,
  /// 清音
  voiceless,
}

// @JsonEnum()
// enum Voicing {
//   voiced,
//   voiceless,
// }
            // "description": "发音方式\n plosive: 爆破音\nfricative: 摩擦音 \naffricate: 破擦音 \nnasal: 鼻音 \napproximant: 近音 \nlateral: 边近音/舌侧音",

/// 发音方式
@JsonEnum(fieldRename: FieldRename.snake)
enum ConsonantManner implements DetailPhoneticType {
  /// 爆破音
  plosive,
  /// 摩擦音
  fricative,
  /// 破擦音
  affricate,
  /// 鼻音
  nasal,
  /// 边近音/舌侧音
  lateral,
  /// 近音
  approximant,
}

/// 发音部位
@JsonEnum(fieldRename: FieldRename.snake)
enum ConsonantPlace {
  bilabial,
  labiodental,
  dental,
  alveolar,
  postAlveolar,
  palatal,
  velar,
  labialVelar,
  glottal,
}

/// 近音的进一步分类
/// 目前主要给 w / j 使用
enum ApproximantType {
  semivowel,
}


@JsonEnum(fieldRename: FieldRename.snake)
enum PhoneticSubCategory {
  monophthong,
  diphthong,
  plosive,
  affricate,
  fricative,
  nasal,
  approximant,
  lateralApproximant,
}


@JsonSerializable(createJsonSchema: true)
class Phonetic {

  final String phonetic;

  @JsonKey(name: 'us_file')

  final String? usFile;

  @JsonKey(name: 'uk_file')

  final String? ukFile;

  final String? alias;

  final PhoneticCategory category;

  final Vowel? vowel;

  final Consonant? consonant;

  final bool? validation;

  const Phonetic({

    required this.phonetic,

    this.usFile,

    this.ukFile,

    this.alias,

    required this.category,

    this.vowel,

    this.consonant,

    this.validation,

  });

  factory Phonetic.fromJson(Map<String, dynamic> json) =>

      _$PhoneticFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneticToJson(this);

}

@JsonSerializable()
class Vowel {
  final VowelType type;

  /// 单元音才有
  final VowelPosition? position;

  /// 单元音才有
  final VowelHeight? height;

  /// 单元音才有
  final VowelBackness? backness;

  /// 单元音才有
  final bool? rounded;

  /// 单元音才有
  final VowelLength? length;

  /// 双元音才有
  @JsonKey(name: 'diphthong_type')
  final DiphthongType? diphthongType;

  /// 双元音起点
  final VowelPoint? start;

  /// 双元音终点
  final VowelPoint? end;

  const Vowel({
    required this.type,
    this.position,
    this.height,
    this.backness,
    this.rounded,
    this.length,
    this.diphthongType,
    this.start,
    this.end,
  });

  factory Vowel.fromJson(Map<String, dynamic> json) =>
      _$VowelFromJson(json);

  Map<String, dynamic> toJson() => _$VowelToJson(this);
}

@JsonSerializable()
class VowelPoint {
  final VowelHeight height;
  final VowelBackness backness;
  final bool rounded;

  const VowelPoint({
    required this.height,
    required this.backness,
    required this.rounded,
  });

  factory VowelPoint.fromJson(Map<String, dynamic> json) =>
      _$VowelPointFromJson(json);

  Map<String, dynamic> toJson() => _$VowelPointToJson(this);
}

@JsonSerializable()
class Consonant {
  final ConsonantVoicing voicing;

  final ConsonantManner manner;

  final ConsonantPlace place;

  @JsonKey(name: 'approximant_type')
  final ApproximantType? approximantType;

  const Consonant({
    required this.voicing,
    required this.manner,
    required this.place,
    this.approximantType,
  });

  factory Consonant.fromJson(Map<String, dynamic> json) =>
      _$ConsonantFromJson(json);

  Map<String, dynamic> toJson() => _$ConsonantToJson(this);
}
