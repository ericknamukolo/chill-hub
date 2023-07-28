import 'package:purchases_flutter/purchases_flutter.dart';

import '../constants/constants.dart';

class Subscriptions {
  static Future init() async {
    await Purchases.setLogLevel(LogLevel.debug);
    await Purchases.setup(revenueCatAPIKey);
  }

  static Future getOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      var res = await Purchases.purchasePackage(offerings.current!.lifetime!);
      logger.i(res);
    } catch (e) {
      rethrow;
    }
  }
}
