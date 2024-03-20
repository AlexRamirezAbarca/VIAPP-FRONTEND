import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viapp/env/theme/app_theme.dart';

Widget title({
  double? fontSize = 20,
  required String title,
  FontWeight? fontWeight = FontWeight.bold,
  Color color = AppTheme.primaryColor,
  required String fontName,
}) {
  return Wrap(
    //crossAxisAlignment: CrossAxisAlignment.center,
    //mainAxisAlignment: mainAxisAlignment,

    children: [
      // imagePath != '' ?
      // SvgPicture.asset(imagePath!, width: 30)
      // : const SizedBox(),
      // imagePath != '' ?  const SizedBox(width: 5): const SizedBox(),
      Text(
        title,
        style: GoogleFonts.getFont(fontName,
            color: color, fontSize: fontSize, fontWeight: fontWeight),
        // style: TextStyle(
        //   color: AppTheme().textColor,
        //   fontWeight: fontWeight,
        //   fontSize: fontSize,
        // ),
      ),
    ],
  );
}
