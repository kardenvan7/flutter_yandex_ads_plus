// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_ad_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BasicAdEvent _$$_BasicAdEventFromJson(Map json) => _$_BasicAdEvent(
      viewUid: json['view_uid'] as String,
      type: const BasicAdEventTypeConverter().fromJson(json['type'] as String),
      parameters: json['parameters'] as Map?,
    );

Map<String, dynamic> _$$_BasicAdEventToJson(_$_BasicAdEvent instance) =>
    <String, dynamic>{
      'view_uid': instance.viewUid,
      'type': const BasicAdEventTypeConverter().toJson(instance.type),
      'parameters': instance.parameters,
    };
