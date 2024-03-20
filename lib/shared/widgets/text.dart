import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viapp/env/theme/app_theme.dart';

Text textWidget({required String title, Color? color = AppTheme.hinText, double? fontSize = 14, FontWeight? fontWeight = FontWeight.w400, TextAlign? textAlign}) {
    return Text(
      textAlign: textAlign,
      title,
      style: GoogleFonts.roboto(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }