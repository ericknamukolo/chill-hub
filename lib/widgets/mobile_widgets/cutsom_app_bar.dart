import 'package:chill_hub/constants/text_style.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showClose;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.showClose = false,
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
      actions: [
        showClose
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
