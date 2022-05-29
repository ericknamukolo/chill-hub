import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../constants/colors.dart';
import '../constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterInfo extends StatefulWidget {
  const FooterInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<FooterInfo> createState() => _FooterInfoState();
}

class _FooterInfoState extends State<FooterInfo> {
  bool _isHovered = false;
  bool _isBtnHovered = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) {
              setState(() {
                _isBtnHovered = true;
              });
            },
            onExit: (_) {
              setState(() {
                _isBtnHovered = false;
              });
            },
            child: GestureDetector(
              onTap: () async {
                Uri url = Uri.parse('https://ko-fi.com/erickmndev');
                await launchUrl(url);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: _isBtnHovered
                      ? Theme.of(context).errorColor
                      : const Color(0xff29abe0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.coffee_rounded,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Ko-Fi',
                      style: kBodyTextStyleWhite.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Text(
            'Designed & Built by',
            style: kBodyTextStyleWhite,
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) {
              setState(() {
                _isHovered = true;
              });
            },
            onExit: (_) {
              setState(() {
                _isHovered = false;
              });
            },
            child: GestureDetector(
              onTap: () async {
                Uri url = Uri.parse('https://ericknamukolo.github.io/');
                await launchUrl(url);
              },
              child: Text(
                'Erick Namukolo',
                style: kBodyTextStyleGrey.copyWith(
                  color: _isHovered ? kAccentColor : kBodyTextStyleGrey.color,
                ),
              ),
            ),
          ),
          Text(
            '© Erick Namukolo, 2022',
            style: kBodyTextStyleGrey.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
