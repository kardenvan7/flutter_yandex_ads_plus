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
        length: 5,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Flutter Yandex Ads Plus'),
            ),
            bottomNavigationBar: const TabBar(
              tabs: [
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
                    'Native',
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
                Tab(
                  child: Text(
                    'Rewarded',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Method buttons',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            body: TabBarView(
              children: [
                const BannerAdTabView(),
                const NativeAdTabView(),
                const InterstitialAdTabView(),
                const RewardedAdTabView(),
                MethodButtonsTabView(),
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
              listener: BannerAdEventListener(
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
            ),
            const SizedBox(height: 20),
            BannerYandexAdView(
              height: 250,
              id: 'R-M-DEMO-300x250',
              iosSettings: const IosBannerAdViewSettings(
                translatesAutoResizingMaskIntoConstraints: true,
              ),
              listener: BannerAdEventListener(
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
            listener: NativeAdEventListener(
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
        ),
      ],
    );
  }
}

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
        onAdWillBeShown: () {
          debugPrint('INTERSTITIAL AD WILL APPEAR');
        },
        onAdShown: () {
          debugPrint('INTERSTITIAL AD SHOWN');
        },
        onAdWillBeDismissed: () {
          debugPrint('INTERSTITIAL AD WILL DISAPPEAR');
        },
        onAdDismissed: () {
          debugPrint('INTERSTITIAL AD DISMISSED');
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

class RewardedAdTabView extends StatefulWidget {
  const RewardedAdTabView({Key? key}) : super(key: key);

  @override
  State<RewardedAdTabView> createState() => _RewardedAdTabViewState();
}

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
        onImpression: (String? impression) {
          debugPrint('REWARDED AD IMPRESSION: $impression');
        },
        onAdClicked: () {
          debugPrint('REWARDED AD CLICKED');
        },
        onLeftApplication: () {
          debugPrint('REWARDED AD LEFT APP');
        },
        onReturnedToApplication: () {
          debugPrint('REWARDED AD RETURNED TO APP');
        },
        onAdFailedToAppear: (int? code, String? description) {
          debugPrint(
            'REWARDED AD FAILED TO APPEAR: CODE: $code, DESC: $description',
          );
        },
        onAdWillBeShown: () {
          debugPrint('REWARDED AD WILL APPEAR');
        },
        onAdShown: () {
          debugPrint('REWARDED AD SHOWN');
        },
        onAdWillBeDismissed: () {
          debugPrint('REWARDED AD WILL DISAPPEAR');
        },
        onAdDismissed: () {
          debugPrint('REWARDED AD DISMISSED');
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

class MethodButtonsTabView extends StatelessWidget {
  MethodButtonsTabView({Key? key}) : super(key: key);

  static const double _titleBottomGap = 2;
  static const double _sectionsGap = 24;

  final ValueNotifier<String?> _version = ValueNotifier(null);

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
    _version.value = await FlutterYandexAdsPlus.getNativeLibraryVersion();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('User consent'),
              const SizedBox(height: _titleBottomGap),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _setUserConsent(true),
                    child: const Text('Enable'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => _setUserConsent(false),
                    child: const Text('Disable'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: _sectionsGap),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Logging'),
              const SizedBox(height: _titleBottomGap),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _setEnableLogging(true),
                    child: const Text('Enable'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => _setEnableLogging(false),
                    child: const Text('Disable'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: _sectionsGap),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Location consent'),
              const SizedBox(height: _titleBottomGap),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _setLocationConsent(true),
                    child: const Text('Enable'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => _setLocationConsent(false),
                    child: const Text('Disable'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: _sectionsGap),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Debug error indicator'),
              const SizedBox(height: _titleBottomGap),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _setEnableDebugErrorIndicator(true),
                    child: const Text('Enable'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => _setEnableDebugErrorIndicator(false),
                    child: const Text('Disable'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: _sectionsGap),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('User age restriction'),
              const SizedBox(height: _titleBottomGap),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _setAgeRestrictedUser(true),
                    child: const Text('Enable'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => _setAgeRestrictedUser(false),
                    child: const Text('Disable'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: _sectionsGap),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Native library version'),
              const SizedBox(height: _titleBottomGap),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _getNativeLibraryVersion(),
                    child: const Text('Obtain'),
                  ),
                  const SizedBox(width: 20),
                  ValueListenableBuilder(
                    valueListenable: _version,
                    builder: (BuildContext _, String? value, Widget? __) {
                      return Text(
                        value ?? 'Not obtained',
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
