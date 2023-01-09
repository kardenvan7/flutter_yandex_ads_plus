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
            BannerAdView(
              height: 50,
              id: 'R-M-DEMO-320x50',
              iosSettings: const IosBannerAdViewSettings(
                translatesAutoResizingMaskIntoConstraints: true,
              ),
              onAdLoaded: () {
                debugPrint('SMALL BANNER AD LOADED');
              },
              onAdFailedToLoad: (int code, String description) {
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
            BannerAdView(
              height: 250,
              id: 'R-M-DEMO-300x250',
              iosSettings: const IosBannerAdViewSettings(
                translatesAutoResizingMaskIntoConstraints: true,
              ),
              onAdLoaded: () {
                debugPrint('BIG BANNER AD LOADED');
              },
              onAdFailedToLoad: (int code, String description) {
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
          child: NativeAdView(
            id: 'demo-native-app-yandex',
            height: 300,
            width: 300,
            additionalLoadParameters: const {
              'test': '123',
              'notText': '132',
            },
            onAdLoaded: () {
              debugPrint('NATIVE AD LOADED');
            },
            onAdFailedToLoad: (int code, String description) {
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

  void _onAdShowPressed() {
    FlutterYandexAdsPlus.showInterstitialAd();
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
