// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ad_parameters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AdParameters _$AdParametersFromJson(Map<String, dynamic> json) {
  return _AdParameters.fromJson(json);
}

/// @nodoc
mixin _$AdParameters {
  String? get age => throw _privateConstructorUsedError;
  String? get biddingData => throw _privateConstructorUsedError;
  String? get contextQuery => throw _privateConstructorUsedError;
  List<String>? get contextTags => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  Map<String, String>? get custom => throw _privateConstructorUsedError;
  @JsonKey(name: "preferred_theme")
  @BrightnessJsonConverter()
  Brightness? get brightness => throw _privateConstructorUsedError;
  Location? get location => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdParametersCopyWith<AdParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdParametersCopyWith<$Res> {
  factory $AdParametersCopyWith(
          AdParameters value, $Res Function(AdParameters) then) =
      _$AdParametersCopyWithImpl<$Res, AdParameters>;
  @useResult
  $Res call(
      {String? age,
      String? biddingData,
      String? contextQuery,
      List<String>? contextTags,
      String? gender,
      Map<String, String>? custom,
      @JsonKey(name: "preferred_theme")
      @BrightnessJsonConverter()
          Brightness? brightness,
      Location? location});

  $LocationCopyWith<$Res>? get location;
}

/// @nodoc
class _$AdParametersCopyWithImpl<$Res, $Val extends AdParameters>
    implements $AdParametersCopyWith<$Res> {
  _$AdParametersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? age = freezed,
    Object? biddingData = freezed,
    Object? contextQuery = freezed,
    Object? contextTags = freezed,
    Object? gender = freezed,
    Object? custom = freezed,
    Object? brightness = freezed,
    Object? location = freezed,
  }) {
    return _then(_value.copyWith(
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String?,
      biddingData: freezed == biddingData
          ? _value.biddingData
          : biddingData // ignore: cast_nullable_to_non_nullable
              as String?,
      contextQuery: freezed == contextQuery
          ? _value.contextQuery
          : contextQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      contextTags: freezed == contextTags
          ? _value.contextTags
          : contextTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      custom: freezed == custom
          ? _value.custom
          : custom // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      brightness: freezed == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as Brightness?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AdParametersCopyWith<$Res>
    implements $AdParametersCopyWith<$Res> {
  factory _$$_AdParametersCopyWith(
          _$_AdParameters value, $Res Function(_$_AdParameters) then) =
      __$$_AdParametersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? age,
      String? biddingData,
      String? contextQuery,
      List<String>? contextTags,
      String? gender,
      Map<String, String>? custom,
      @JsonKey(name: "preferred_theme")
      @BrightnessJsonConverter()
          Brightness? brightness,
      Location? location});

  @override
  $LocationCopyWith<$Res>? get location;
}

/// @nodoc
class __$$_AdParametersCopyWithImpl<$Res>
    extends _$AdParametersCopyWithImpl<$Res, _$_AdParameters>
    implements _$$_AdParametersCopyWith<$Res> {
  __$$_AdParametersCopyWithImpl(
      _$_AdParameters _value, $Res Function(_$_AdParameters) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? age = freezed,
    Object? biddingData = freezed,
    Object? contextQuery = freezed,
    Object? contextTags = freezed,
    Object? gender = freezed,
    Object? custom = freezed,
    Object? brightness = freezed,
    Object? location = freezed,
  }) {
    return _then(_$_AdParameters(
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String?,
      biddingData: freezed == biddingData
          ? _value.biddingData
          : biddingData // ignore: cast_nullable_to_non_nullable
              as String?,
      contextQuery: freezed == contextQuery
          ? _value.contextQuery
          : contextQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      contextTags: freezed == contextTags
          ? _value._contextTags
          : contextTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      custom: freezed == custom
          ? _value._custom
          : custom // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      brightness: freezed == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as Brightness?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AdParameters extends _AdParameters {
  const _$_AdParameters(
      {this.age,
      this.biddingData,
      this.contextQuery,
      final List<String>? contextTags,
      this.gender,
      final Map<String, String>? custom,
      @JsonKey(name: "preferred_theme")
      @BrightnessJsonConverter()
          this.brightness,
      this.location})
      : _contextTags = contextTags,
        _custom = custom,
        super._();

  factory _$_AdParameters.fromJson(Map<String, dynamic> json) =>
      _$$_AdParametersFromJson(json);

  @override
  final String? age;
  @override
  final String? biddingData;
  @override
  final String? contextQuery;
  final List<String>? _contextTags;
  @override
  List<String>? get contextTags {
    final value = _contextTags;
    if (value == null) return null;
    if (_contextTags is EqualUnmodifiableListView) return _contextTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? gender;
  final Map<String, String>? _custom;
  @override
  Map<String, String>? get custom {
    final value = _custom;
    if (value == null) return null;
    if (_custom is EqualUnmodifiableMapView) return _custom;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: "preferred_theme")
  @BrightnessJsonConverter()
  final Brightness? brightness;
  @override
  final Location? location;

  @override
  String toString() {
    return 'AdParameters(age: $age, biddingData: $biddingData, contextQuery: $contextQuery, contextTags: $contextTags, gender: $gender, custom: $custom, brightness: $brightness, location: $location)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AdParameters &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.biddingData, biddingData) ||
                other.biddingData == biddingData) &&
            (identical(other.contextQuery, contextQuery) ||
                other.contextQuery == contextQuery) &&
            const DeepCollectionEquality()
                .equals(other._contextTags, _contextTags) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            const DeepCollectionEquality().equals(other._custom, _custom) &&
            (identical(other.brightness, brightness) ||
                other.brightness == brightness) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      age,
      biddingData,
      contextQuery,
      const DeepCollectionEquality().hash(_contextTags),
      gender,
      const DeepCollectionEquality().hash(_custom),
      brightness,
      location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AdParametersCopyWith<_$_AdParameters> get copyWith =>
      __$$_AdParametersCopyWithImpl<_$_AdParameters>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AdParametersToJson(
      this,
    );
  }
}

abstract class _AdParameters extends AdParameters {
  const factory _AdParameters(
      {final String? age,
      final String? biddingData,
      final String? contextQuery,
      final List<String>? contextTags,
      final String? gender,
      final Map<String, String>? custom,
      @JsonKey(name: "preferred_theme")
      @BrightnessJsonConverter()
          final Brightness? brightness,
      final Location? location}) = _$_AdParameters;
  const _AdParameters._() : super._();

  factory _AdParameters.fromJson(Map<String, dynamic> json) =
      _$_AdParameters.fromJson;

  @override
  String? get age;
  @override
  String? get biddingData;
  @override
  String? get contextQuery;
  @override
  List<String>? get contextTags;
  @override
  String? get gender;
  @override
  Map<String, String>? get custom;
  @override
  @JsonKey(name: "preferred_theme")
  @BrightnessJsonConverter()
  Brightness? get brightness;
  @override
  Location? get location;
  @override
  @JsonKey(ignore: true)
  _$$_AdParametersCopyWith<_$_AdParameters> get copyWith =>
      throw _privateConstructorUsedError;
}
