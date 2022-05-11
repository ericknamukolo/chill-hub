import 'dart:ui';

import 'package:chill_hub/providers/movies.dart';
import 'package:chill_hub/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/desktop/desktop_home_screen.dart';

void main() {
  runApp(const ChillHub());
}

class ChillHub extends StatelessWidget {
  const ChillHub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Movies()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData(
          fontFamily: 'VarelaRound',
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
