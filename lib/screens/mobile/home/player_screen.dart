import 'dart:io';

import 'package:chill_hub/widgets/mobile_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlayerScreen extends StatefulWidget {
  final String title;
  const PlayerScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title, showClose: true),
      body: WebView(
        initialUrl: 'https://ferrolho.github.io/magnet-player/',
        allowsInlineMediaPlayback: true,
        javascriptMode: JavascriptMode.unrestricted,
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
      ),
    );
  }
}
