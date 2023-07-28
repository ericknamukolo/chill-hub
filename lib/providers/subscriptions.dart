import 'package:purchases_flutter/purchases_flutter.dart';

import '../constants/constants.dart';

class Subscriptions {
  static Future init() async {
    await Purchases.setLogLevel(LogLevel.debug);
    await Purchases.setup(revenueCatAPIKey);
  }

  static Future<List<Offering>> getOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      return offerings.all.values.toList();
    } catch (e) {
      rethrow;
    }
  }
}
