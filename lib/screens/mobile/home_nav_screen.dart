import 'package:chill_hub/constants/text_style.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              decoration: BoxDecoration(
                color: kSecondaryColorDark,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text('All', style: kBodyTextStyleGrey),
            ),
          ],
        ),
      ),
    );
  }
}
