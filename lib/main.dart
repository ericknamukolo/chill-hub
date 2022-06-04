import 'dart:io';
import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:chill_hub/providers/menu_buttons.dart';
import 'package:chill_hub/providers/movie_categories.dart';
import 'package:chill_hub/providers/movie_views.dart';
import 'package:chill_hub/providers/movies.dart';
import 'package:chill_hub/screens/desktop/desktop_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/desktop/desktop_home_screen.dart';

Future<void> main() async {
  runApp(const ChillHub());
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    doWhenWindowReady(() {
      final win = appWindow;
      win.title = 'Chill Hub';
      win.minSize = const Size(1200, 700);
      win.show();
    });
  }
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
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData(
          fontFamily: 'VarelaRound',
          brightness: Brightness.dark,
        ),
        home: const DesktopSplashScreen(),
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
