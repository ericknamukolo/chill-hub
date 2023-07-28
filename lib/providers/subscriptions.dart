import 'package:flutter/services.dart';
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
    } on PlatformException catch (e) {
      logger.i(e);
      PurchasesErrorCode errCode = PurchasesErrorHelper.getErrorCode(e);
      if (errCode == PurchasesErrorCode.productAlreadyPurchasedError) {
        Toast.showToast(
            message: 'Product has already been purchased', type: 'error');
      } else if (errCode == PurchasesErrorCode.purchaseCancelledError) {
        Toast.showToast(message: 'Purchase cancelled', type: 'error');
      }
    }
  }
}
