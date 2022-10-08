import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/text_style.dart';

class AboutNavScreen extends StatefulWidget {
  const AboutNavScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AboutNavScreen> createState() => _AboutNavScreenState();
}

class _AboutNavScreenState extends State<AboutNavScreen> {
  String version = '';
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        version = packageInfo.version;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Icon(
            Icons.local_movies_rounded,
            color: kBodyTextStyleGrey.color,
            size: 45,
          ),
          const SizedBox(height: 10),
          Text(
            'Chill Hub (Made with Flutter & Dart) is a mobile (also available for windows) application that allows you to browse, search and download high - quality movies for FREE.',
            textAlign: TextAlign.center,
            style: kBodyTextStyleGrey.copyWith(
              fontSize: 12,
            ),
          ),
          // GestureDetector(
          //   onTap: () async {
          //     Uri url = Uri.parse('https://ko-fi.com/erickmndev');
          //     await launchUrl(url);
          //   },
          //   child: AnimatedContainer(
          //     duration: const Duration(milliseconds: 300),
          //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          //     padding: const EdgeInsets.symmetric(vertical: 5),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(5.0),
          //       color: const Color(0xff29abe0),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         const Icon(
          //           Icons.coffee_rounded,
          //           size: 20,
          //         ),
          //         const SizedBox(width: 8),
          //         Text(
          //           'Ko-Fi',
          //           style: kBodyTextStyleWhite.copyWith(
          //             fontWeight: FontWeight.bold,
          //             letterSpacing: 3,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          const Spacer(),
          const Text(
            'Designed & Built by',
            style: kBodyTextStyleWhite,
          ),
          GestureDetector(
            onTap: () async {
              Uri url = Uri.parse('https://ericknamukolo.github.io/');
              await launchUrl(url, mode: LaunchMode.externalApplication);
            },
            child: Text(
              '© Erick Namukolo, 2022',
              style: kBodyTextStyleGrey.copyWith(
                fontSize: 12,
              ),
            ),
          ),

          const SizedBox(height: 5.0),
          GestureDetector(
            onTap: () async {
              Uri url =
                  Uri.parse('https://chill-hub-privacy-policy.netlify.app/');
              await launchUrl(url, mode: LaunchMode.externalApplication);
            },
            child: Text(
              'Privacy Policy',
              style: kBodyTextStyleGrey.copyWith(
                fontSize: 12,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            'v $version',
            style: kBodyTextStyleGrey.copyWith(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
