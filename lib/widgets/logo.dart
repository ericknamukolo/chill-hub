import 'package:chill_hub/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Chill',
          style: GoogleFonts.patrickHand(
            fontSize: 60,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Hub',
          style: GoogleFonts.patrickHand(
            fontSize: 60,
            color: kSecondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 2),
        const Icon(
          MdiIcons.filmstrip,
          color: kSecondaryColor,
          size: 60,
        ),
      ],
    );
  }
}
