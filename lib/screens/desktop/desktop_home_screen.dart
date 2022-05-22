import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/providers/menu_buttons.dart';
import 'package:chill_hub/providers/movie_categories.dart';
import 'package:chill_hub/providers/movie_views.dart';
import 'package:chill_hub/providers/movies.dart';
import 'package:chill_hub/screens/desktop/widgets/latest_movies_widget.dart';
import 'package:chill_hub/screens/desktop/widgets/menu_btn_widget.dart';
import 'package:chill_hub/screens/desktop/widgets/movie_details.dart';
import 'package:chill_hub/screens/desktop/widgets/movie_list.dart';
import 'package:chill_hub/screens/desktop/widgets/movie_search.dart';
import 'package:chill_hub/widgets/footer_info.dart';
import 'package:chill_hub/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/movie_card.dart';

class DesktopHomeScreen extends StatefulWidget {
  const DesktopHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends State<DesktopHomeScreen> {
  int pageNumber = 1;

  String genre = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: kSecondaryColorDark,
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Icon(
                          MdiIcons.filmstrip,
                          color: kBodyTextStyleGrey.color,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Chill Hub',
                          style: kBodyTextStyleGrey.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      'MENU',
                      style: kBodyTextStyleGrey.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Consumer<MenuButtons>(
                    builder: (context, btnData, __) => Column(
                      children: btnData.buttonsData
                          .map(
                            (btn) => MenuBtnWidget(
                              btn: btn,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  // const SizedBox(height: 20),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10, right: 10),
                  //   child: Text(
                  //     'LIBRARY',
                  //     style: kBodyTextStyleGrey.copyWith(
                  //       fontWeight: FontWeight.bold,
                  //       letterSpacing: 2,
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 5),
                  // Consumer<MenuButtons>(
                  //   builder: (context, btnData, __) => Column(
                  //     children: btnData.libButtonsData
                  //         .map(
                  //           (btn) => MenuBtnWidget(
                  //             btn: btn,
                  //           ),
                  //         )
                  //         .toList(),
                  //   ),
                  // ),
                  //  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      'GENERAL',
                      style: kBodyTextStyleGrey.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Consumer<MenuButtons>(
                    builder: (context, btnData, __) => Column(
                      children: btnData.genButtonsData
                          .map(
                            (btn) => MenuBtnWidget(
                              btn: btn,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const Spacer(),
                  // const FooterInfo(),
                ],
              ),
            ),
          ),
          Consumer<MovieViews>(
            builder: (context, view, __) {
              Widget _widget;
              if (view.isMovieDetails) {
                _widget = const MovieDetails();
              } else if (view.isSearch) {
                _widget = const MovieSearch();
              } else {
                _widget = const MovieList();
              }
              return Expanded(
                flex: 6,
                child: _widget,
              );
            },
          ),
        ],
      ),
    );
  }
}
