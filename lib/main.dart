import 'dart:io';
import 'dart:ui';
import 'package:chill_hub/providers/menu_buttons.dart';
import 'package:chill_hub/providers/movie_categories.dart';
import 'package:chill_hub/providers/movie_views.dart';
import 'package:chill_hub/providers/movies.dart';
import 'package:chill_hub/screens/desktop/desktop_splash_screen.dart';
import 'package:chill_hub/screens/mobile/mobile_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:bot_toast/bot_toast.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) {
    MobileAds.instance.initialize();
    await FlutterDownloader.initialize();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const ChillHub());
}

class ChillHub extends StatelessWidget {
  const ChillHub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Movies()),
        ChangeNotifierProvider(create: (context) => MovieCategories()),
        ChangeNotifierProvider(create: (context) => MenuButtons()),
        ChangeNotifierProvider(create: (context) => MovieViews()),
      ],
      child: MaterialApp(
        title: 'Chill Hub',
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        navigatorObservers: [
          BotToastNavigatorObserver(),
        ],
        scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData(
          fontFamily: 'VarelaRound',
          brightness: Brightness.dark,
        ),
        home: Platform.isAndroid || Platform.isIOS
            ? const MobileSplashScreen()
            : const DesktopSplashScreen(),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
