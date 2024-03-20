import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viapp/env/theme/app_theme.dart';

class FilledButtonWidget extends StatelessWidget {
  const FilledButtonWidget({
    super.key,
    this.onPressed,
    this.color = AppTheme.secondaryColorS,
    required this.text,
    this.width = double.infinity,
    this.height = 40,
    this.borderRadius = 25,
  });

  final void Function()? onPressed;
  final Color? color;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(Size(width!, height!)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(color),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.roboto(
          color: AppTheme.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        // style: TextStyle(
        //     color: AppTheme().white, fontWeight: FontWeight.w600, fontSize: 15),
      ),
    );
  }
}
