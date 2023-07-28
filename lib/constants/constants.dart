import 'package:bot_toast/bot_toast.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/mobile_widgets/custom_toast.dart';

enum ToastType { error, success }

class Links {
  static void goToLink(String url) async {
    await launchUrl(Uri.parse('https://www.youtube.com/watch?v=$url'),
        mode: LaunchMode.inAppWebView);
  }
}

String revenueCatAPIKey = 'goog_zYCCcQArBRzRSZzkkrHKNvjpvSO';
var logger = Logger(
  printer: PrettyPrinter(
    colors: true,
    printTime: true,
    printEmojis: true,
  ),
);

class Toast {
  static void showToast({required String message, required String type}) {
    BotToast.showCustomNotification(
        duration: const Duration(seconds: 4),
        toastBuilder: (_) => CustomToast(message: message, type: type));
  }
}
