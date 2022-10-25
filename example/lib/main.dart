import 'dart:io';

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

class BannerScreen extends StatelessWidget {
  const BannerScreen({
    Key? key,
    required this.ads,
  }) : super(key: key);

  final FlutterYandexAds ads;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Banner'),
        SizedBox(
          height: 300,
          width: 300,
          child: BannerAdView(
            id: Platform.isIOS ? 'R-M-208189-28' : 'R-M-208186-29',
            ads: ads,
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
            height: 250,
            width: 300,
          ),
        ),
      ],
    );
  }
}
