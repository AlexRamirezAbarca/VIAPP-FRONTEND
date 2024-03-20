import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransitionPage2 extends StatefulWidget {
  const TransitionPage2({Key? key}) : super(key: key);

  @override
  State<TransitionPage2> createState() => _TransitionPage2State();
}

class _TransitionPage2State extends State<TransitionPage2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primaryColor,
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.10, // Ajusta el 15% de la altura de la pantalla
            left: 0,
            child: SvgPicture.asset(
              'assets/splash/vector_splash_2.svg',
              height: 570,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.30, // Ajusta el 25% de la altura de la pantalla
            left: 35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crea,',
                  style: GoogleFonts.archivoBlack(
                    fontSize: 50,
                    color: AppTheme.white,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -2,
                    height: 1,
                  ),
                ),
                Text(
                  'gestiona',
                  style: GoogleFonts.archivoBlack(
                    fontSize: 50,
                    color: AppTheme.white,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -2,
                    height: 1,
                  ),
                ),
                Text(
                  'tus',
                  style: GoogleFonts.archivoBlack(
                    fontSize: 50,
                    color: AppTheme.white,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -2,
                    height: 1,
                  ),
                ),
                Text(
                  'solicitudes!',
                  style: GoogleFonts.archivoBlack(
                    fontSize: 50,
                    color: AppTheme.white,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -2,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
