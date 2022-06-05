import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/widgets/mobile_widgets/cutsom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

import '../../models/movie.dart';

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
      appBar: CustomAppBar(
        title: 'Trailer',
        icon: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          PodVideoPlayer(
            controller: controller,
            podProgressBarConfig: const PodProgressBarConfig(
              backgroundColor: kAccentColor,
              circleHandlerColor: kAccentColor,
            ),
          ),
        ],
      ),
    );
  }
}
