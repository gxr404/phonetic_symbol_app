// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phonetic.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Phonetic _$PhoneticFromJson(Map<String, dynamic> json) => Phonetic(
  phonetic: json['phonetic'] as String,
  usFile: json['us_file'] as String?,
  ukFile: json['uk_file'] as String?,
  alias: json['alias'] as String?,
  category: $enumDecode(_$PhoneticCategoryEnumMap, json['category']),
  vowel: json['vowel'] == null
      ? null
      : Vowel.fromJson(json['vowel'] as Map<String, dynamic>),
  consonant: json['consonant'] == null
      ? null
      : Consonant.fromJson(json['consonant'] as Map<String, dynamic>),
  validation: json['validation'] as bool?,
);

Map<String, dynamic> _$PhoneticToJson(Phonetic instance) => <String, dynamic>{
  'phonetic': instance.phonetic,
  'us_file': instance.usFile,
  'uk_file': instance.ukFile,
  'alias': instance.alias,
  'category': _$PhoneticCategoryEnumMap[instance.category]!,
  'vowel': instance.vowel,
  'consonant': instance.consonant,
  'validation': instance.validation,
};

const _$PhoneticJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'phonetic': {'type': 'string'},
    'us_file': {'type': 'string'},
    'uk_file': {'type': 'string'},
    'alias': {'type': 'string'},
    'category': {'type': 'object'},
    'vowel': {r'$ref': r'#/$defs/Vowel'},
    'consonant': {r'$ref': r'#/$defs/Consonant'},
    'validation': {'type': 'boolean'},
  },
  'required': ['phonetic', 'category'],
  r'$defs': {
    'VowelPoint': {
      'type': 'object',
      'properties': {
        'height': {'type': 'object'},
        'backness': {'type': 'object'},
        'rounded': {'type': 'boolean'},
      },
      'required': ['height', 'backness', 'rounded'],
    },
    'Vowel': {
      'type': 'object',
      'properties': {
        'type': {'type': 'object'},
        'position': {'type': 'object', 'description': '单元音才有'},
        'height': {'type': 'object', 'description': '单元音才有'},
        'backness': {'type': 'object', 'description': '单元音才有'},
        'rounded': {'type': 'boolean', 'description': '单元音才有'},
        'length': {'type': 'object', 'description': '单元音才有'},
        'diphthong_type': {'type': 'object', 'description': '双元音才有'},
        'start': {r'$ref': r'#/$defs/VowelPoint', 'description': '双元音起点'},
        'end': {r'$ref': r'#/$defs/VowelPoint', 'description': '双元音终点'},
      },
      'required': ['type'],
    },
    'Consonant': {
      'type': 'object',
      'properties': {
        'voicing': {'type': 'object'},
        'manner': {'type': 'object'},
        'place': {'type': 'object'},
        'approximant_type': {'type': 'object'},
      },
      'required': ['voicing', 'manner', 'place'],
    },
  },
};

const _$PhoneticCategoryEnumMap = {
  PhoneticCategory.vowel: 'vowel',
  PhoneticCategory.consonant: 'consonant',
};

Vowel _$VowelFromJson(Map<String, dynamic> json) => Vowel(
  type: $enumDecode(_$VowelTypeEnumMap, json['type']),
  position: $enumDecodeNullable(_$VowelPositionEnumMap, json['position']),
  height: $enumDecodeNullable(_$VowelHeightEnumMap, json['height']),
  backness: $enumDecodeNullable(_$VowelBacknessEnumMap, json['backness']),
  rounded: json['rounded'] as bool?,
  length: $enumDecodeNullable(_$VowelLengthEnumMap, json['length']),
  diphthongType: $enumDecodeNullable(
    _$DiphthongTypeEnumMap,
    json['diphthong_type'],
  ),
  start: json['start'] == null
      ? null
      : VowelPoint.fromJson(json['start'] as Map<String, dynamic>),
  end: json['end'] == null
      ? null
      : VowelPoint.fromJson(json['end'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VowelToJson(Vowel instance) => <String, dynamic>{
  'type': _$VowelTypeEnumMap[instance.type]!,
  'position': _$VowelPositionEnumMap[instance.position],
  'height': _$VowelHeightEnumMap[instance.height],
  'backness': _$VowelBacknessEnumMap[instance.backness],
  'rounded': instance.rounded,
  'length': _$VowelLengthEnumMap[instance.length],
  'diphthong_type': _$DiphthongTypeEnumMap[instance.diphthongType],
  'start': instance.start,
  'end': instance.end,
};

const _$VowelTypeEnumMap = {
  VowelType.monophthong: 'monophthong',
  VowelType.diphthong: 'diphthong',
};

const _$VowelPositionEnumMap = {
  VowelPosition.front: 'front',
  VowelPosition.central: 'central',
  VowelPosition.back: 'back',
};

const _$VowelHeightEnumMap = {
  VowelHeight.close: 'close',
  VowelHeight.nearClose: 'near_close',
  VowelHeight.closeMid: 'close_mid',
  VowelHeight.mid: 'mid',
  VowelHeight.openMid: 'open_mid',
  VowelHeight.nearOpen: 'near_open',
  VowelHeight.open: 'open',
};

const _$VowelBacknessEnumMap = {
  VowelBackness.front: 'front',
  VowelBackness.central: 'central',
  VowelBackness.back: 'back',
};

const _$VowelLengthEnumMap = {
  VowelLength.short: 'short',
  VowelLength.long: 'long',
};

const _$DiphthongTypeEnumMap = {
  DiphthongType.closing: 'closing',
  DiphthongType.centring: 'centring',
};

VowelPoint _$VowelPointFromJson(Map<String, dynamic> json) => VowelPoint(
  height: $enumDecode(_$VowelHeightEnumMap, json['height']),
  backness: $enumDecode(_$VowelBacknessEnumMap, json['backness']),
  rounded: json['rounded'] as bool,
);

Map<String, dynamic> _$VowelPointToJson(VowelPoint instance) =>
    <String, dynamic>{
      'height': _$VowelHeightEnumMap[instance.height]!,
      'backness': _$VowelBacknessEnumMap[instance.backness]!,
      'rounded': instance.rounded,
    };

Consonant _$ConsonantFromJson(Map<String, dynamic> json) => Consonant(
  voicing: $enumDecode(_$ConsonantVoicingEnumMap, json['voicing']),
  manner: $enumDecode(_$ConsonantMannerEnumMap, json['manner']),
  place: $enumDecode(_$ConsonantPlaceEnumMap, json['place']),
  approximantType: $enumDecodeNullable(
    _$ApproximantTypeEnumMap,
    json['approximant_type'],
  ),
);

Map<String, dynamic> _$ConsonantToJson(Consonant instance) => <String, dynamic>{
  'voicing': _$ConsonantVoicingEnumMap[instance.voicing]!,
  'manner': _$ConsonantMannerEnumMap[instance.manner]!,
  'place': _$ConsonantPlaceEnumMap[instance.place]!,
  'approximant_type': _$ApproximantTypeEnumMap[instance.approximantType],
};

const _$ConsonantVoicingEnumMap = {
  ConsonantVoicing.voiced: 'voiced',
  ConsonantVoicing.voiceless: 'voiceless',
};

const _$ConsonantMannerEnumMap = {
  ConsonantManner.plosive: 'plosive',
  ConsonantManner.fricative: 'fricative',
  ConsonantManner.affricate: 'affricate',
  ConsonantManner.nasal: 'nasal',
  ConsonantManner.lateral: 'lateral',
  ConsonantManner.approximant: 'approximant',
};

const _$ConsonantPlaceEnumMap = {
  ConsonantPlace.bilabial: 'bilabial',
  ConsonantPlace.labiodental: 'labiodental',
  ConsonantPlace.dental: 'dental',
  ConsonantPlace.alveolar: 'alveolar',
  ConsonantPlace.postAlveolar: 'post_alveolar',
  ConsonantPlace.palatal: 'palatal',
  ConsonantPlace.velar: 'velar',
  ConsonantPlace.labialVelar: 'labial_velar',
  ConsonantPlace.glottal: 'glottal',
};

const _$ApproximantTypeEnumMap = {ApproximantType.semivowel: 'semivowel'};
