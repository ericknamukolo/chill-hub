import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

import '../../constants/colors.dart';
import '../../constants/text_style.dart';

class MovieDetailsCard extends StatelessWidget {
  final String title;
  final String? content;
  final IconData icon;
  final bool isAvailable;
  final Function()? click;
  const MovieDetailsCard({
    Key? key,
    required this.title,
    required this.icon,
    this.content,
    this.isAvailable = false,
    this.click,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: click,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
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
              glowColor: isAvailable ? const Color(0xffFF0000) : Colors.white,
              size: 28,
            ),
            Text(
              title,
              style: kMobileBodyTextStyleGrey,
            ),
            content == null
                ? const SizedBox()
                : FittedBox(
                    child: Text(
                      isAvailable ? content!.toUpperCase() : content!,
                      maxLines: 2,
                      style: kMobileBodyTextStyleWhite.copyWith(fontSize: 10),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
