import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yandex_ads_plus/flutter_yandex_ads_plus.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  FlutterYandexAds ads = FlutterYandexAds();

  @override
  void initState() {
    super.initState();

    ads.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.light,
      ),
      themeMode: ThemeMode.light,
      home: DefaultTabController(
        length: 2,
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
              ],
            ),
            body: TabBarView(
              children: [
                NativeScreen(ads: ads),
                BannerScreen(ads: ads),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BannerScreen extends StatefulWidget {
  const BannerScreen({
    Key? key,
    required this.ads,
  }) : super(key: key);

  final FlutterYandexAds ads;

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  String? _deviceId;
  bool _infoRetrieved = false;

  @override
  void initState() {
    super.initState();
    final infoPlugin = DeviceInfoPlugin();

    if (Platform.isIOS) {
      infoPlugin.iosInfo.then(
        (value) => setState(
          () {
            _infoRetrieved = true;
            _deviceId = value.identifierForVendor;
          },
        ),
      );
    } else if (Platform.isAndroid) {
      infoPlugin.androidInfo.then(
        (value) => setState(
          () {
            _infoRetrieved = true;
            _deviceId = value.id;
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Banner'),
        Visibility(
          visible: _infoRetrieved,
          child: SizedBox(
            height: 300,
            width: 300,
            child: BannerAdView(
              id: Platform.isIOS ? 'R-M-208189-24' : 'R-M-208186-25',
              ads: widget.ads,
              additionalLoadParams: Platform.isIOS
                  ? null
                  //      {
                  //         "adf_ownerid": "171817",
                  //         "adf_p1": "ciouy",
                  //         "adf_p2": "fhme",
                  //         "adf_pt": "b",
                  //         "adf_puid24": _deviceId ?? "9",
                  //       }
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

class NativeScreen extends StatelessWidget {
  const NativeScreen({
    Key? key,
    required this.ads,
  }) : super(key: key);

  final FlutterYandexAds ads;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Native'),
        SizedBox(
          child: NativeAdView(
            id: Platform.isIOS ? 'R-M-208189-36' : 'R-M-208186-37',
            height: 300,
            width: 300,
          ),
        ),
      ],
    );
  }
}
