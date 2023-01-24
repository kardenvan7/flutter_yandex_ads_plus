import 'package:flutter_yandex_ads_plus/src/core/reward.dart';

typedef YandexAdErrorCallback = void Function(int? code, String? description);
typedef YandexAdImpressionCallback = void Function(String? impression);
typedef RewardedYandexAdOnRewardCallback = void Function(YandexAdReward reward);
