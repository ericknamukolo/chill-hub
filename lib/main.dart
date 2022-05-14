import 'dart:io';
import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:chill_hub/providers/menu_buttons.dart';
import 'package:chill_hub/providers/movie_categories.dart';
import 'package:chill_hub/providers/movies.dart';
import 'package:chill_hub/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/desktop/desktop_home_screen.dart';

void main() {
  runApp(const ChillHub());
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData(
          fontFamily: 'VarelaRound',
          brightness: Brightness.dark,
        ),
        home: const ResponsiveLayout(
          desktopBody: DesktopHomeScreen(),
          mobileBody: Text('Mobile'),
          tabletBody: Text('Tablet'),
        ),
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
