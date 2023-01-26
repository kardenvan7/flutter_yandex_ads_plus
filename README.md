# A Flutter plugin for Yandex Ads SDK

Navigation
* [Requirements](#requirements)
* [Features](#features)
* [Examples](#examples)
* [Usage](#usage)

## Requirements

|             | Android | iOS  |
|-------------|---------|------|
| **Support** | SDK 21+ | 11.0+ |

## Features

| Feature                        | Android | iOS | macOS | Web | Windows | Linux |
| ------------------------------ | :-----: | :-: | :---: | :-: | :-----: | :---: |
| Banner Ad               | ✅      | ✅  |    ||     |
| Native Ad               | ✅      | ✅  |    ||     |
| Interstitial Ad               | ✅      | ✅  |    ||     |
| Rewarded Ad               | ✅      | ✅  |    ||     |

## Examples
Banner Ad Widget| Native Ad Widget |Interstitial Ad| Rewarded Ad |
:-------------------------:|:-------------------------:|:---------------:|:-:|
![Banner](https://github.com/kardenvan7/flutter_yandex_ads_plus/blob/0.6.0/doc/banner_example.jpg?raw=true)  |  ![Native](https://github.com/kardenvan7/flutter_yandex_ads_plus/blob/0.6.0/doc/native_example.jpg?raw=true) | ![Interstitial](https://github.com/kardenvan7/flutter_yandex_ads_plus/blob/0.6.0/doc/interstitial_example.jpg?raw=true) | ![Reward](https://github.com/kardenvan7/flutter_yandex_ads_plus/blob/0.6.0/doc/rewarded_example.jpg?raw=true)

## Usage

This section has examples of code for the following tasks:

* [Banner Ad Widget](#bannеr-ad-widget)
* [Native Ad Widget](#native-ad-widget)
* [Interstitial Ad](#interstitial-ad)
* [Rewarded Ad](#rewarded-ad)
* [Configuration](#configuration)

### Bannеr Ad Widget
```dart
BannerYandexAdView(
height: 250,    // Height of the ad. Has to be explicitly restricted.
id: 'R-M-DEMO-300x250',    // AdUid given by ad provider
listener: BannerAdEventListener(    // Listener for ad events
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
  id: 'demo-native-app-yandex',    // AdUid given by ad provider
  height: 170,    // Height of the ad. Has to be explicitly restricted.
  width: 300,    // Width of the ad
  parameters: const YandexAdParameters( // Additional ad load parameters
    custom: {
      'adfx-p1': 'asdx',
      'adfx-p2': 'asdc',
    },
  ),
  listener: NativeAdEventListener(    // Listener for ad events
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
    _ad = InterstitialYandexAd(          // Instance of the ad
      adId: "demo-interstitial-yandex",
    );

    _ad?.load(                           // Loading ad
      listener: InterstitialAdEventListener(
        onAdLoaded: () {
          debugPrint('INTERSTITIAL AD LOADED');
          _ad?.show();                   // Showing ad after it is loaded
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
    _ad?.dispose();          // Disposing ad instance when it is no longer needed
    super.dispose();
  }
}

```

### Rewarded Ad
```dart
class _RewardedAdTabViewState extends State<RewardedAdTabView> {
  RewardedYandexAd? _ad;

  Future<void> _onAdShowPressed() async {
    _ad = RewardedYandexAd(               // Instance of the ad
      adId: "demo-rewarded-yandex",
    );

    _ad?.load(                            // Loading ad
      listener: RewardedAdEventListener(
        onAdLoaded: () {
          debugPrint('REWARDED AD LOADED');
          _ad?.show();                    // Showing ad after it is loaded
        },
        onAdFailedToLoad: (int? code, String? description) {
          debugPrint(
            'REWARDED AD FAILED TO LOAD: CODE $code, DESC: $description',
          );
        },
        onRewarded: (YandexAdReward reward) {    // Receiving a reward
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
    _ad?.dispose();          // Disposing ad instance when it is no longer needed
    super.dispose();
  }
}
```

### Configuration

```dart
void _setUserConsent(bool value) {
  FlutterYandexAdsPlus.setUserConsent(value); // Sets user consent
}

void _setEnableLogging(bool value) {
  FlutterYandexAdsPlus.enableLogging(value); // Enables/disables debug logging. Disabled by default
}

void _setLocationConsent(bool value) {
  FlutterYandexAdsPlus.setLocationConsent(value); // Sets location consent given by user
}

void _setEnableDebugErrorIndicator(bool value) {
  FlutterYandexAdsPlus.enableDebugErrorIndicator(value); // Enables/disables error indicator for ads in debug mode
}

void _setAgeRestrictedUser(bool value) {
  FlutterYandexAdsPlus.setAgeRestrictedUser(value); // Sets age restriction
}

Future<void> _getNativeLibraryVersion() async {
  final String version = await FlutterYandexAdsPlus.getNativeLibraryVersion(); // Returns native library version
  debugPrint(version);
}
```