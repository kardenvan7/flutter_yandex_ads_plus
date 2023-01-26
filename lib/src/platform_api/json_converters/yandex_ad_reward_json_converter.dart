import 'package:flutter_yandex_ads_plus/src/core/reward.dart';

class YandexAdRewardFactory {
  const YandexAdRewardFactory._();

  static YandexAdReward fromJson(Map json) {
    return YandexAdReward(
      amount: json['amount'] as int,
      type: json['type'] as String,
    );
  }
}
