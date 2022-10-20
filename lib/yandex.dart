import 'package:flutter_yandex_ads_plus/pigeons/yandex.dart';

class FlutterYandexAds {
  final api = YandexAdsApi();

  void initialize() {
    api.initialize();
  }

  void setOnAdLoaded(String id, EventType type, Function onAdLoaded) {
    api
        .onAdLoaded(EventRequest(id: id, name: 'onAdLoaded', type: type.name))
        .then((value) {
      onAdLoaded();
    });
  }

  void setOnAdFailedToLoad(
      String id, EventType type, Function onAdFailedToLoad) {
    api
        .onAdFailedToLoad(
            EventRequest(id: id, name: 'onAdFailedToLoad', type: type.name))
        .then((value) {
      onAdFailedToLoad(AdLoadError(
        code: value.code ?? 0,
        description: value.description ?? '',
      ));
    });
  }

  void setOnImpression(String id, EventType type, Function callback) {
    api
        .onImpression(
            EventRequest(id: id, name: 'onImpression', type: type.name))
        .then((value) {
      callback(value.data);
    });
  }

  void setOnAdCLicked(String id, EventType type, Function callback) {
    api
        .onAdClicked(EventRequest(id: id, name: 'onAdClicked', type: type.name))
        .then((value) {
      callback();
    });
  }

  void setOnLeftApplication(String id, EventType type, Function callback) {
    api
        .onLeftApplication(
            EventRequest(id: id, name: 'onLeftApplication', type: type.name))
        .then((value) {
      callback();
    });
  }

  void setOnReturnedToApplication(
      String id, EventType type, Function callback) {
    api
        .onReturnedToApplication(EventRequest(
            id: id, name: 'onReturnedToApplication', type: type.name))
        .then((value) {
      callback();
    });
  }

  void setOnAdShown(String id, EventType type, Function callback) {
    api
        .onAdShown(EventRequest(id: id, name: 'onAdShown', type: type.name))
        .then((value) {
      callback();
    });
  }

  void setOnAdDismissed(String id, EventType type, Function callback) {
    api
        .onAdShown(EventRequest(id: id, name: 'onAdDismissed', type: type.name))
        .then((value) {
      callback();
    });
  }
}

class AdLoadError {
  final int code;
  final String description;

  AdLoadError({required this.code, required this.description});
}

enum EventType {
  banner,
  interstitial,
  native,
  rewarded,
}
