import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

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
