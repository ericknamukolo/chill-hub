import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constants/ad_units.dart';

class AdManager {
  static void loadInterstitialAd({required String adUnit}) {
    InterstitialAd.load(
      adUnitId: adUnit,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) async {
          InterstitialAd loadedAd = ad;
          await loadedAd.show();
        },
        onAdFailedToLoad: (ad) {},
      ),
    );
  }

  static void loadAppOpenAd() {
    AppOpenAd.load(
      adUnitId: AdUnits.appOpen,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) async {
            AppOpenAd loadedAd = ad;
            await loadedAd.show();
          },
          onAdFailedToLoad: (ad) {}),
      orientation: AppOpenAd.orientationPortrait,
    );
  }
}
