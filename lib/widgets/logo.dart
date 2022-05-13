import 'package:chill_hub/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Chill',
          style: GoogleFonts.dosis(
            fontSize: 45,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          ' Hub',
          style: GoogleFonts.dosis(
            fontSize: 45,
            color: kAccentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 2),
        const Icon(
          Icons.cloud,
          color: kAccentColor,
        ),
      ],
    );
  }
}
