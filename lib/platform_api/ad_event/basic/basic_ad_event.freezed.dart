// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basic_ad_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BasicAdEvent _$BasicAdEventFromJson(Map<String, dynamic> json) {
  return _BasicAdEvent.fromJson(json);
}

/// @nodoc
mixin _$BasicAdEvent {
  String get viewUid => throw _privateConstructorUsedError;
  @BasicAdEventTypeConverter()
  BasicAdEventType get type => throw _privateConstructorUsedError;
  Map<dynamic, dynamic>? get parameters => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BasicAdEventCopyWith<BasicAdEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BasicAdEventCopyWith<$Res> {
  factory $BasicAdEventCopyWith(
          BasicAdEvent value, $Res Function(BasicAdEvent) then) =
      _$BasicAdEventCopyWithImpl<$Res, BasicAdEvent>;
  @useResult
  $Res call(
      {String viewUid,
      @BasicAdEventTypeConverter() BasicAdEventType type,
      Map<dynamic, dynamic>? parameters});
}

/// @nodoc
class _$BasicAdEventCopyWithImpl<$Res, $Val extends BasicAdEvent>
    implements $BasicAdEventCopyWith<$Res> {
  _$BasicAdEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? viewUid = null,
    Object? type = null,
    Object? parameters = freezed,
  }) {
    return _then(_value.copyWith(
      viewUid: null == viewUid
          ? _value.viewUid
          : viewUid // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BasicAdEventType,
      parameters: freezed == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BasicAdEventCopyWith<$Res>
    implements $BasicAdEventCopyWith<$Res> {
  factory _$$_BasicAdEventCopyWith(
          _$_BasicAdEvent value, $Res Function(_$_BasicAdEvent) then) =
      __$$_BasicAdEventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String viewUid,
      @BasicAdEventTypeConverter() BasicAdEventType type,
      Map<dynamic, dynamic>? parameters});
}

/// @nodoc
class __$$_BasicAdEventCopyWithImpl<$Res>
    extends _$BasicAdEventCopyWithImpl<$Res, _$_BasicAdEvent>
    implements _$$_BasicAdEventCopyWith<$Res> {
  __$$_BasicAdEventCopyWithImpl(
      _$_BasicAdEvent _value, $Res Function(_$_BasicAdEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? viewUid = null,
    Object? type = null,
    Object? parameters = freezed,
  }) {
    return _then(_$_BasicAdEvent(
      viewUid: null == viewUid
          ? _value.viewUid
          : viewUid // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BasicAdEventType,
      parameters: freezed == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BasicAdEvent extends _BasicAdEvent {
  const _$_BasicAdEvent(
      {required this.viewUid,
      @BasicAdEventTypeConverter() required this.type,
      final Map<dynamic, dynamic>? parameters})
      : _parameters = parameters,
        super._();

  factory _$_BasicAdEvent.fromJson(Map<String, dynamic> json) =>
      _$$_BasicAdEventFromJson(json);

  @override
  final String viewUid;
  @override
  @BasicAdEventTypeConverter()
  final BasicAdEventType type;
  final Map<dynamic, dynamic>? _parameters;
  @override
  Map<dynamic, dynamic>? get parameters {
    final value = _parameters;
    if (value == null) return null;
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'BasicAdEvent(viewUid: $viewUid, type: $type, parameters: $parameters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BasicAdEvent &&
            (identical(other.viewUid, viewUid) || other.viewUid == viewUid) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, viewUid, type,
      const DeepCollectionEquality().hash(_parameters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BasicAdEventCopyWith<_$_BasicAdEvent> get copyWith =>
      __$$_BasicAdEventCopyWithImpl<_$_BasicAdEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BasicAdEventToJson(
      this,
    );
  }
}

abstract class _BasicAdEvent extends BasicAdEvent {
  const factory _BasicAdEvent(
      {required final String viewUid,
      @BasicAdEventTypeConverter() required final BasicAdEventType type,
      final Map<dynamic, dynamic>? parameters}) = _$_BasicAdEvent;
  const _BasicAdEvent._() : super._();

  factory _BasicAdEvent.fromJson(Map<String, dynamic> json) =
      _$_BasicAdEvent.fromJson;

  @override
  String get viewUid;
  @override
  @BasicAdEventTypeConverter()
  BasicAdEventType get type;
  @override
  Map<dynamic, dynamic>? get parameters;
  @override
  @JsonKey(ignore: true)
  _$$_BasicAdEventCopyWith<_$_BasicAdEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
