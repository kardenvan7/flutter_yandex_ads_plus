import 'package:flutter/material.dart';
import 'package:flutter_yandex_ads_plus/flutter_yandex_ads_plus.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.light,
      ),
      themeMode: ThemeMode.light,
      home: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Yandex ADS'),
            ),
            bottomNavigationBar: const TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'Native',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Banner',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Interstitial',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            body: const TabBarView(
              children: [
                NativeAdTabView(),
                BannerAdTabView(),
                InterstitialAdTabView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BannerAdTabView extends StatelessWidget {
  const BannerAdTabView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Banner'),
        Column(
          children: [
            BannerYandexAdView(
              height: 50,
              id: 'R-M-DEMO-320x50',
              iosSettings: const IosBannerAdViewSettings(
                translatesAutoResizingMaskIntoConstraints: true,
              ),
              onAdLoaded: () {
                debugPrint('SMALL BANNER AD LOADED');
              },
              onAdFailedToLoad: (int? code, String? description) {
                debugPrint(
                  'SMALL BANNER AD FAILED TO LOAD: CODE $code, DESC: $description',
                );
              },
              onImpression: (String? impression) {
                debugPrint('SMALL BANNER AD IMPRESSION: $impression');
              },
              onAdClicked: () {
                debugPrint('SMALL BANNER AD CLICKED');
              },
              onLeftApplication: () {
                debugPrint('SMALL BANNER AD LEFT APP');
              },
              onReturnedToApplication: () {
                debugPrint('SMALL BANNER RETURNED TO APP');
              },
              willPresentScreen: () {
                debugPrint('SMALL BANNER WILL PRESENT SCREEN');
              },
              didDismissScreen: () {
                debugPrint('SMALL BANNER DID DISMISS SCREEN');
              },
            ),
            const SizedBox(height: 20),
            BannerYandexAdView(
              height: 250,
              id: 'R-M-DEMO-300x250',
              iosSettings: const IosBannerAdViewSettings(
                translatesAutoResizingMaskIntoConstraints: true,
              ),
              onAdLoaded: () {
                debugPrint('BIG BANNER AD LOADED');
              },
              onAdFailedToLoad: (int? code, String? description) {
                debugPrint(
                  'BIG BANNER AD FAILED TO LOAD: CODE $code, DESC: $description',
                );
              },
              onImpression: (String? impression) {
                debugPrint('BIG BANNER AD IMPRESSION: $impression');
              },
              onAdClicked: () {
                debugPrint('BIG BANNER AD CLICKED');
              },
              onLeftApplication: () {
                debugPrint('BIG BANNER AD LEFT APP');
              },
              onReturnedToApplication: () {
                debugPrint('BIG BANNER AD RETURNED TO APP');
              },
              willPresentScreen: () {
                debugPrint('BIG BANNER WILL PRESENT SCREEN');
              },
              didDismissScreen: () {
                debugPrint('BIG BANNER DID DISMISS SCREEN');
              },
            ),
          ],
        ),
      ],
    );
  }
}

class NativeAdTabView extends StatelessWidget {
  const NativeAdTabView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Native'),
        SizedBox(
          child: NativeYandexAdView(
            id: 'demo-native-app-yandex',
            height: 170,
            width: 300,
            parameters: const YandexAdParameters(
              custom: {
                'test': '123',
                'notText': '132',
              },
            ),
            onAdLoaded: () {
              debugPrint('NATIVE AD LOADED');
            },
            onAdFailedToLoad: (int? code, String? description) {
              debugPrint(
                'NATIVE AD FAILED TO LOAD: CODE $code, DESC: $description',
              );
            },
            onImpression: (String? impression) {
              debugPrint('NATIVE AD IMPRESSION: $impression');
            },
            onAdClicked: () {
              debugPrint('NATIVE AD CLICKED');
            },
            onLeftApplication: () {
              debugPrint('NATIVE AD LEFT APP');
            },
            onReturnedToApplication: () {
              debugPrint('NATIVE AD RETURNED TO APP');
            },
            willPresentScreen: () {
              debugPrint('NATIVE AD WILL PRESENT SCREEN');
            },
            didDismissScreen: () {
              debugPrint('NATIVE AD DID DISMISS SCREEN');
            },
            onClose: () {
              debugPrint('NATIVE AD USER CLOSE REQUEST');
            },
          ),
        ),
      ],
    );
  }
}

class InterstitialAdTabView extends StatelessWidget {
  const InterstitialAdTabView({Key? key}) : super(key: key);

  Future<void> _onAdShowPressed() async {
    final ad = InterstitialYandexAd(
      adId: "demo-interstitial-yandex",
    );

    ad.load(
      onAdLoaded: () {
        debugPrint('INTERSTITIAL AD LOADED');
        ad.show();
      },
      onAdFailedToLoad: (int? code, String? description) {
        debugPrint(
          'INTERSTITIAL AD FAILED TO LOAD: CODE $code, DESC: $description',
        );
      },
      onImpression: (String? impression) {
        debugPrint('INTERSTITIAL AD IMPRESSION: $impression');
      },
      onAdClicked: () {
        debugPrint('INTERSTITIAL AD CLICKED');
      },
      onLeftApplication: () {
        debugPrint('INTERSTITIAL AD LEFT APP');
      },
      onReturnedToApplication: () {
        debugPrint('INTERSTITIAL AD RETURNED TO APP');
      },
      onAdFailedToAppear: (int? code, String? description) {
        debugPrint(
          'INTERSTITIAL AD FAILED TO APPEAR: CODE: $code, DESC: $description',
        );
      },
      onAdWillAppear: () {
        debugPrint('INTERSTITIAL AD WILL APPEAR');
      },
      onAdShown: () {
        debugPrint('INTERSTITIAL AD SHOWN');
      },
      onAdWillDisappear: () {
        debugPrint('INTERSTITIAL AD WILL DISAPPEAR');
      },
      onAdDismissed: () {
        debugPrint('INTERSTITIAL AD DISMISSED');
      },
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
}
