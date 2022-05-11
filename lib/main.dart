import 'package:chill_hub/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'screens/desktop/desktop_home_screen.dart';

void main() {
  runApp(const ChillHub());
}

class ChillHub extends StatelessWidget {
  const ChillHub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'VarelaRound',
      ),
      home: const ResponsiveLayout(
        desktopBody: DesktopHomeScreen(),
        mobileBody: Text('Mobile'),
        tabletBody: Text('Tablet'),
      ),
    );
  }
}
