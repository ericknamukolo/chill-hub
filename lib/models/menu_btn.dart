import 'package:flutter/material.dart';

class MenuBtn {
  String title;
  IconData icon;
  bool isSelected;

  MenuBtn({
    required this.icon,
    required this.title,
    this.isSelected = false,
  });
}
