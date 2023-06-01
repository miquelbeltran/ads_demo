import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({super.key});

  @override
  State<AdBanner> createState() => _AdBannerState();
}


class _AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;

  static const testAdUnit = 'ca-app-pub-3940256099942544/6300978111';
  static const app_336x280 = 'unit goes here';

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  /// Loads a banner ad.
  void _loadAd() {
    _bannerAd = BannerAd(
      adUnitId: app_336x280,
      request: const AdRequest(),
      size: AdSize.mediumRectangle,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          print('Ad loaded: ${ad.adUnitId}');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          print('BannerAd failed to load: ${ad.adUnitId}, error: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {
          print('Ad opened: ${ad.adUnitId}');
        },
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {
          print('Ad closed: ${ad.adUnitId}');
        },
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {
          print('Ad displayed: ${ad.adUnitId}');
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = const SizedBox();
    if (_bannerAd != null) {
      child = Center(
        child: SizedBox(
          width: _bannerAd!.size.width.toDouble(),
          height: _bannerAd!.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd!),
        ),
      );
    }
    return Container(
      height: 300,
      color: Colors.grey,
      child: child,
    );
  }
}
