import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/widgets/mobile_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

import '../../../constants/text_style.dart';
import '../../../models/movie.dart';

class TrailerPlayerScreen extends StatefulWidget {
  final Movie movie;
  const TrailerPlayerScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<TrailerPlayerScreen> createState() => _TrailerPlayerScreenState();
}

class _TrailerPlayerScreenState extends State<TrailerPlayerScreen> {
  late final PodPlayerController controller;
  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom:
          PlayVideoFrom.youtube('https://youtu.be/${widget.movie.trailer}'),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorDark,
      appBar: const CustomAppBar(
        title: 'Trailer',
        showClose: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PodVideoPlayer(
              controller: controller,
              podProgressBarConfig: const PodProgressBarConfig(
                backgroundColor: kAccentColor,
                circleHandlerColor: kAccentColor,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    '${widget.movie.title} (${widget.movie.year})',
                    style: kBarTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(
                    thickness: 2.0,
                    color: kSecondaryColorDark,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Synopsis',
                    style: kBarTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.movie.introDes,
                    style: kMobileBodyTextStyleGrey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
