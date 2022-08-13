import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static void loadInterstitialAd(
      {required Function(dynamic) onLoaded,
      required Function(dynamic) onAdFailedToLoad}) {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
      ),
    );
  }

  static void loadInterstitialVidAd(
      {required Function(dynamic) onLoaded,
      required Function(dynamic) onAdFailedToLoad}) {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/8691691433',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
      ),
    );
  }
}
