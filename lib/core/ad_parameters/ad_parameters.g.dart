// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AdParameters _$$_AdParametersFromJson(Map json) => _$_AdParameters(
      age: json['age'] as String?,
      biddingData: json['bidding_data'] as String?,
      contextQuery: json['context_query'] as String?,
      contextTags: (json['context_tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      gender: json['gender'] as String?,
      custom: (json['custom'] as Map?)?.map(
        (k, e) => MapEntry(k as String, e as String),
      ),
      brightness: _$JsonConverterFromJson<String, Brightness>(
          json['preferred_theme'], const BrightnessJsonConverter().fromJson),
      location: json['location'] == null
          ? null
          : Location.fromJson(
              Map<String, dynamic>.from(json['location'] as Map)),
    );

Map<String, dynamic> _$$_AdParametersToJson(_$_AdParameters instance) =>
    <String, dynamic>{
      'age': instance.age,
      'bidding_data': instance.biddingData,
      'context_query': instance.contextQuery,
      'context_tags': instance.contextTags,
      'gender': instance.gender,
      'custom': instance.custom,
      'preferred_theme': _$JsonConverterToJson<String, Brightness>(
          instance.brightness, const BrightnessJsonConverter().toJson),
      'location': instance.location?.toJson(),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
