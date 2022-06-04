import 'package:chill_hub/constants/text_style.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? icon;
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kSecondaryColorDark,
      title: Text(title, style: kBarTextStyle),
      centerTitle: true,
      elevation: 3.0,
      actions: [icon!],
    );
  }
}
