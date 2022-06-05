import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

import '../../constants/colors.dart';
import '../../constants/text_style.dart';

class MovieDetailsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const MovieDetailsCard({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kSecondaryColorDark,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GlowIcon(
            icon,
            glowColor: Colors.white,
            size: 28,
          ),
          Text(
            title,
            style: kMobileBodyTextStyleGrey,
          ),
          Text(
            'Action,Comedy',
            style: kMobileBodyTextStyleWhite.copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
