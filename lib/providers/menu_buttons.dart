import '../models/menu_btn.dart';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuButtons with ChangeNotifier {
  List<MenuBtn> buttonsData = [
    MenuBtn(
      icon: Icons.home_rounded,
      title: 'Home',
      isSelected: true,
    ),
  ];

  // List<MenuBtn> libButtonsData = [
  //   MenuBtn(
  //     icon: Icons.watch_later_rounded,
  //     title: 'Watch Later',
  //   ),
  //   MenuBtn(
  //     icon: Icons.favorite_rounded,
  //     title: 'Favourites',
  //   ),
  //   MenuBtn(
  //     icon: Icons.download_rounded,
  //     title: 'Downloaded',
  //   ),
  // ];

  List<MenuBtn> genButtonsData = [
    MenuBtn(
      icon: MdiIcons.information,
      title: 'About',
    ),
  ];

  void selectBtn(MenuBtn btn) {
    List<MenuBtn> _btns = [];
    buttonsData.forEach((element) {
      _btns.add(element);
    });

    genButtonsData.forEach((element) {
      _btns.add(element);
    });

    _btns.forEach((element) {
      element.isSelected = false;
    });

    btn.isSelected = true;
    notifyListeners();
  }
}
