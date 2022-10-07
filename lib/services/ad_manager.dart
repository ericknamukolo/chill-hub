import 'package:google_mobile_ads/google_mobile_ads.dart';

String testAd = 'ca-app-pub-3940256099942544/1033173712';
String realAd = 'ca-app-pub-4667865994695089/4708178147';

class AdManager {
  static void loadInterstitialAd(
      {required Function(dynamic) onLoaded,
      required Function(dynamic) onAdFailedToLoad}) {
    InterstitialAd.load(
      adUnitId: testAd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
      ),
    );
  }
}
