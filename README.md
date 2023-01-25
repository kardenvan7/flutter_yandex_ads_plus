# A Flutter plugin for Yandex Ads SDK.

## Requirements:

|             | Android | iOS  |
|-------------|---------|------|
| **Support** | SDK 21+ | 11.0+ |

## Features

| Feature                        | Android | iOS | macOS | Web | Windows | Linux |
| ------------------------------ | :-----: | :-: | :---: | :-: | :-----: | :---: |
| Banner                | ✅      | ✅  |    ||     |
| Native                | ✅      | ✅  |    ||     |
| Interstitial                | ✅      | ✅  |    ||     |
| Rewarded                | ✅      | ✅  |    ||     |
## Ad examples
Banner Ad Widget| Native Ad Widget |Interstitial Ad| Rewarded Ad |
:-------------------------:|:-------------------------:|:---------------:|:-:|
![Banner](https://github.com/kardenvan7/flutter_yandex_ads_plus/blob/0.6.0/doc/banner_example.jpg?raw=true)  |  ![Native](https://github.com/kardenvan7/flutter_yandex_ads_plus/blob/0.6.0/doc/native_example.jpg?raw=true) | ![Interstitial](https://github.com/kardenvan7/flutter_yandex_ads_plus/blob/0.6.0/doc/interstitial_example.jpg?raw=true) | ![Reward](https://github.com/kardenvan7/flutter_yandex_ads_plus/blob/0.6.0/doc/rewarded_example.jpg?raw=true)

## Usage

This section has examples of code for the following tasks:

* [Banner Ad Widget](#bannеr-ad-widget)
* [Native Ad Widget](#native-ad-widget)
* [Interstitial Ad](#interstitial-ad)
* [Rewarded Ad](#rewarded-ad)
* [SDK Configuration](#sdk-configuration)

### Bannеr Ad Widget
```dart
BannerYandexAdView(
  height: 250,
  id: 'R-M-DEMO-300x250',
  iosSettings: const IosBannerAdViewSettings(
    translatesAutoResizingMaskIntoConstraints: true,
  ),
  listener: BannerAdEventListener(
    onAdLoaded: () {
      debugPrint('BANNER AD LOADED');
    },
    onAdFailedToLoad: (int? code, String? description) {
      debugPrint(
        'BANNER AD FAILED TO LOAD: CODE $code, DESC: $description',
      );
    },
  ),
),
```

### Native Ad Widget
```dart
NativeYandexAdView(
  id: 'demo-native-app-yandex',
  height: 170,
  width: 300,
  parameters: const YandexAdParameters(
    custom: {
      'adfx-p1': 'asdx',
      'adfx-p2': 'asdc',
    },
  ),
  listener: NativeAdEventListener(
    onAdLoaded: () {
      debugPrint('NATIVE AD LOADED');
    },
    onAdFailedToLoad: (int? code, String? description) {
      debugPrint(
        'NATIVE AD FAILED TO LOAD: CODE $code, DESC: $description',
      );
    },
  ),
),
```

### Interstitial Ad
```dart
class InterstitialAdTabView extends StatefulWidget {
  const InterstitialAdTabView({Key? key}) : super(key: key);

  @override
  State<InterstitialAdTabView> createState() => _InterstitialAdTabViewState();
}

class _InterstitialAdTabViewState extends State<InterstitialAdTabView> {
  InterstitialYandexAd? _ad;

  Future<void> _onAdShowPressed() async {
    _ad = InterstitialYandexAd(
      adId: "demo-interstitial-yandex",
    );

    _ad?.load(
      listener: InterstitialAdEventListener(
        onAdLoaded: () {
          debugPrint('INTERSTITIAL AD LOADED');
          _ad?.show();
        },
        onAdFailedToLoad: (int? code, String? description) {
          debugPrint(
            'INTERSTITIAL AD FAILED TO LOAD: CODE $code, DESC: $description',
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _onAdShowPressed,
        child: const Text("Show interstitial ad"),
      ),
    );
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }
}

```

### Rewarded Ad
```dart
class _RewardedAdTabViewState extends State<RewardedAdTabView> {
  RewardedYandexAd? _ad;

  Future<void> _onAdShowPressed() async {
    _ad = RewardedYandexAd(
      adId: "demo-rewarded-yandex",
    );

    _ad?.load(
      listener: RewardedAdEventListener(
        onAdLoaded: () {
          debugPrint('REWARDED AD LOADED');
          _ad?.show();
        },
        onAdFailedToLoad: (int? code, String? description) {
          debugPrint(
            'REWARDED AD FAILED TO LOAD: CODE $code, DESC: $description',
          );
        },
        onRewarded: (YandexAdReward reward) {
          debugPrint(
            'REWARD RECEIVED:\nAMOUNT: ${reward.amount}\nTYPE: ${reward.type}',
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _onAdShowPressed,
        child: const Text("Show rewarded ad"),
      ),
    );
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }
}
```

### SDK Configuration

```dart
void _setUserConsent(bool value) {
  FlutterYandexAdsPlus.setUserConsent(value);
}

void _setEnableLogging(bool value) {
  FlutterYandexAdsPlus.enableLogging(value);
}

void _setLocationConsent(bool value) {
  FlutterYandexAdsPlus.setLocationConsent(value);
}

void _setEnableDebugErrorIndicator(bool value) {
  FlutterYandexAdsPlus.enableDebugErrorIndicator(value);
}

void _setAgeRestrictedUser(bool value) {
  FlutterYandexAdsPlus.setAgeRestrictedUser(value);
}

Future<void> _getNativeLibraryVersion() async {
  final String version = await FlutterYandexAdsPlus.getNativeLibraryVersion();
}
```