import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/models/menu_btn.dart';
import 'package:chill_hub/providers/menu_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuBtnWidget extends StatelessWidget {
  final MenuBtn btn;

  const MenuBtnWidget({
    Key? key,
    required this.btn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<MenuButtons>(context, listen: false).selectBtn(btn);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          height: 50,
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                btn.icon,
                color: btn.isSelected ? kAccentColor : kBodyTextStyleGrey.color,
                size: 25.0,
              ),
              const SizedBox(width: 10),
              Text(
                btn.title,
                style: kBodyTextStyleGrey.copyWith(
                  color:
                      btn.isSelected ? kAccentColor : kBodyTextStyleGrey.color,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .5,
                ),
              ),
              const Spacer(),
              btn.isSelected
                  ? Container(
                      width: 4,
                      height: 30,
                      color: kAccentColor,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
