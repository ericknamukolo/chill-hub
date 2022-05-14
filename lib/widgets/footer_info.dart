import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
                await launch(
                  'https://ericknamukolo.github.io/',
                );
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
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
