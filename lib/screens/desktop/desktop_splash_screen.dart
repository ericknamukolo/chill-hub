import 'dart:async';

import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/screens/desktop/desktop_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DesktopSplashScreen extends StatefulWidget {
  const DesktopSplashScreen({Key? key}) : super(key: key);

  @override
  State<DesktopSplashScreen> createState() => _DesktopSplashScreenState();
}

class _DesktopSplashScreenState extends State<DesktopSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => const DesktopHomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorDark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Image.asset('assets/logo.png')),
          const Center(
            child: SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: kAccentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
