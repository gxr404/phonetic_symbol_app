// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
  theme: $enumDecode(_$AppThemeEnumMap, json['theme']),
  pronounce: $enumDecode(_$PronounceEnumMap, json['pronounce']),
);

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
  'theme': _$AppThemeEnumMap[instance.theme]!,
  'pronounce': _$PronounceEnumMap[instance.pronounce]!,
};

const _$SettingsJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'theme': {'type': 'object'},
    'pronounce': {'type': 'object'},
  },
  'required': ['theme', 'pronounce'],
};

const _$AppThemeEnumMap = {AppTheme.light: 'light', AppTheme.dark: 'dark'};

const _$PronounceEnumMap = {Pronounce.us: 'us', Pronounce.uk: 'uk'};
