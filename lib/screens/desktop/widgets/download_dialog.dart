import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/models/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadDialog extends StatelessWidget {
  final List<Torrent> torrents;
  const DownloadDialog({
    Key? key,
    required this.torrents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: 290,
        decoration: BoxDecoration(
          color: kPrimaryColorDark,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: torrents
              .map((torr) => Container(
                    width: 180,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          torr.size,
                          style: kBodyTextStyleGrey.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Container(
                          height: 100,
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kSecondaryColorDark,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    torr.quality,
                                    style: kBodyTextStyleWhite.copyWith(
                                      color: kAccentColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    torr.type,
                                    style: kBodyTextStyleGrey.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'S ${torr.seeds}',
                                    style: kBodyTextStyleGrey.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    'P ${torr.peers}',
                                    style: kBodyTextStyleGrey.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Theme.of(context).errorColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            Uri url = Uri.parse(torr.url);
                            await launchUrl(url);
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: kAccentColor,
                            fixedSize: const Size.fromHeight(35),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'DOWNLOAD',
                                style: kBodyTextStyleWhite,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        IconButton(
                          onPressed: () async {
                            Uri url = Uri.parse(
                                'magnet:?xt=urn:btih:${torr.hash}&dn=${torr.title}&tr=http://track.one:1234/announce&tr=udp://tracker.opentrackr.org:1337/announce&tr=udp://open.demonii.com:1337/announce&tr=udp://tracker.openbittorrent.com:80&tr=udp://tracker.coppersurfer.tk:6969&tr=udp://glotorrents.pw:6969/announce&tr=udp://torrent.gresille.org:80/announce&tr=udp://p4p.arenabg.com:1337&tr=udp://tracker.leechers-paradise.org:6969');
                            await launchUrl(url);
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            MdiIcons.magnet,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
