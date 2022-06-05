import 'dart:async';

import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/screens/mobile/mobile_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileSplashScreen extends StatefulWidget {
  const MobileSplashScreen({Key? key}) : super(key: key);

  @override
  State<MobileSplashScreen> createState() => _MobileSplashScreenState();
}

class _MobileSplashScreenState extends State<MobileSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (context) => const MobileHome()));
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
          Center(
            child: SizedBox(
              child: Image.asset('assets/logo.png'),
              height: 70,
            ),
          ),
          const Center(
            child: SizedBox(
              height: 20,
              width: 20,
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
