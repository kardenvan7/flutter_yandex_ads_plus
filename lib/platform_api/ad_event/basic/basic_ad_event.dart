import 'package:freezed_annotation/freezed_annotation.dart';

part 'basic_ad_event.freezed.dart';
part 'basic_ad_event.g.dart';

@freezed
class BasicAdEvent with _$BasicAdEvent {
  const BasicAdEvent._();

  const factory BasicAdEvent({
    required String viewUid,
    @BasicAdEventTypeConverter() required BasicAdEventType type,
    Map? parameters,
  }) = _BasicAdEvent;

  factory BasicAdEvent.fromJson(Map<String, dynamic> json) =>
      _$BasicAdEventFromJson(json);
}

enum BasicAdEventType {
  onAdLoaded('onAdLoaded'),
  onAdFailedToLoad('onAdFailedToLoad'),
  onImpression('onImpression'),
  onLeftApplication('onLeftApplication'),
  onReturnedToApplication('onReturnedToApplication'),
  onAdClicked('onAdClicked');

  const BasicAdEventType(this.value);

  final String value;
}

class BasicAdEventTypeConverter
    extends JsonConverter<BasicAdEventType, String> {
  const BasicAdEventTypeConverter();

  @override
  BasicAdEventType fromJson(json) {
    return BasicAdEventType.values.firstWhere(
      (element) => element.value == json,
    );
  }

  @override
  String toJson(object) {
    return object.value;
  }
}
