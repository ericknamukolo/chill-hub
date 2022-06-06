import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/screens/mobile/trailer_player_screen.dart';
import 'package:chill_hub/widgets/mobile_widgets/cutsom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../models/movie.dart';
import '../../widgets/desktop_widgets/download_dialog.dart';
import '../../widgets/mobile_widgets/mobile_download_dialog.dart';
import '../../widgets/mobile_widgets/movie_details_card.dart';

class MobileMovieDetails extends StatefulWidget {
  final Movie movie;
  const MobileMovieDetails({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MobileMovieDetails> createState() => _MobileMovieDetailsState();
}

class _MobileMovieDetailsState extends State<MobileMovieDetails> {
  int progress = 0;
  ReceivePort receivePort = ReceivePort();
  @override
  void initState() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, 'download');
    receivePort.listen((message) {
      setState(() {
        progress = message;
      });
    });
    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  static downloadCallback(id, status, progress) {
    SendPort sendPort = IsolateNameServer.lookupPortByName('download')!;
    sendPort.send(progress);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorDark,
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          backgroundColor: kAccentColor,
          onPressed: () async {
            var downloadsPath = await AndroidPathProvider.downloadsPath;

            await FlutterDownloader.enqueue(
              fileName: '${widget.movie.title}.torrent',
              url: widget.movie.torrents[0].url,
              savedDir: downloadsPath,
              showNotification:
                  true, // show download progress in status bar (for Android)
              openFileFromNotification:
                  true, // click on notification to open downloaded file (for Android)
            );

            // showDialog(
            //     context: context,
            //     builder: (context) => MobileDownloadDialog(
            //           torrents: widget.movie.torrents,
            //         ));
          },
          child: const GlowIcon(
            Icons.download_rounded,
            color: Colors.white,
          ),
        ),
      ),
      appBar: CustomAppBar(
        title: 'Movie Details',
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: widget.movie.id,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 340,
                      width: 210,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: NetworkImage(widget.movie.coverImg),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 340,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MovieDetailsCard(
                            title: 'Genre',
                            icon: Icons.movie_creation_rounded,
                            content: widget.movie.genres.join(' | '),
                          ),
                          MovieDetailsCard(
                            title: 'Duration',
                            icon: Icons.timer_rounded,
                            content: '${widget.movie.runtime} Minutes',
                          ),
                          MovieDetailsCard(
                            title: 'Rating',
                            icon: Icons.star_rounded,
                            content: '${widget.movie.rating} / 10',
                          ),
                          MovieDetailsCard(
                            title: 'Trailer',
                            icon: MdiIcons.youtube,
                            content: widget.movie.trailer == ''
                                ? 'Not Available'
                                : 'Watch Trailer',
                            click: () {
                              if (widget.movie.trailer != '') {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => TrailerPlayerScreen(
                                        movie: widget.movie),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
      ),
    );
  }
}
