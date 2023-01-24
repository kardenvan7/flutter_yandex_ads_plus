import 'package:flutter_yandex_ads_plus/src/core/reward.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class YandexAdRewardJsonConverter extends JsonConverter<YandexAdReward, Map> {
  @override
  YandexAdReward fromJson(Map json) {
    return YandexAdReward(
      amount: json['amount'] as int,
      type: json['type'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson(YandexAdReward object) {
    return {
      'amount': object.amount,
      'type': object.type,
    };
  }
}
