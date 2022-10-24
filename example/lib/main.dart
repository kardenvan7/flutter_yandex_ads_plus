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

class BannerScreen extends StatefulWidget {
  const BannerScreen({
    Key? key,
    required this.ads,
  }) : super(key: key);

  final FlutterYandexAds ads;

  @override
  _BannerScreenState createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Banner'),
        SizedBox(
          height: 400,
          child: BannerAdView(
            id: 'R-M-208186-29',
            ads: widget.ads,
          ),
        ),
      ],
    );
  }
}

class NativeScreen extends StatefulWidget {
  const NativeScreen({
    Key? key,
    required this.ads,
  }) : super(key: key);

  final FlutterYandexAds ads;

  @override
  _NativeScreenState createState() => _NativeScreenState();
}

class _NativeScreenState extends State<NativeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Native'),
        SizedBox(
          height: 400,
          child: NativeAdView(
            id: 'R-M-208186-37',
          ),
        ),
      ],
    );
  }
}
