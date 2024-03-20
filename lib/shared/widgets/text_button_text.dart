import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TextButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double size;
  final Color? decorationColor;
  final TextDecoration? decoration;
  final Color textColor ;
  final FontWeight? fontWeight;

  const TextButtonWidget(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.size,
      this.decorationColor,
      this.decoration,
      required this.textColor,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontWeight: fontWeight,
          color: textColor,
          fontSize: size,
          decoration: decoration,
          decorationColor: decorationColor,
        ),
      ),
    );
  }
}
