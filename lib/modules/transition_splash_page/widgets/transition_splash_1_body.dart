import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../env/environment.dart';
import '../../../env/theme/app_theme.dart';
import '../../splash_page/widgets/splash_page_body.dart';

class TransitionPage1 extends StatefulWidget {
  const TransitionPage1({Key? key}) : super(key: key);

  @override
  State<TransitionPage1> createState() => _TransitionPage1State();
}

class _TransitionPage1State extends State<TransitionPage1> {
  @override
  Widget build(BuildContext context) {
    double svgTopPadding = MediaQuery.of(context).size.height * 0.1; // Ajusta la distancia desde la parte superior
    String tittleApp = Environment().config!.tittleAppName;
    return Container(
      color: AppTheme.primaryColor,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            top: svgTopPadding,
            right: 0,
            child: SvgPicture.asset(
              'assets/splash/vector_splash_1.svg',
              height: 585,
            ),
          ),
          TextInfoSplashTransition1(tittleApp: tittleApp),
        ],
      ),
    );
  }
}

class TextInfoSplashTransition1 extends StatelessWidget {
  const TextInfoSplashTransition1({
    super.key,
    required this.tittleApp,
  });

  final String tittleApp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, top: MediaQuery.of(context).size.height * 0.25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DESCUBRE',
            style: GoogleFonts.archivoBlack(
              fontSize: 50,
              color: AppTheme.white,
              fontWeight: FontWeight.w400,
              letterSpacing: -2,
              height: 1,
            ),
          ),
          Row(
            children: [
              Text(
                'TODO',
                style: GoogleFonts.archivoBlack(
                  fontSize: 50,
                  color: AppTheme.secondaryColor,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -2,
                  height: 1,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'LO',
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
          Text(
            'QUE',
            style: GoogleFonts.archivoBlack(
              fontSize: 50,
              color: AppTheme.white,
              fontWeight: FontWeight.w400,
              letterSpacing: -2,
              height: 1,
            ),
          ),
          Text(
            'PUEDES',
            style: GoogleFonts.archivoBlack(
              fontSize: 50,
              color: AppTheme.white,
              fontWeight: FontWeight.w400,
              letterSpacing: -2,
              height: 1,
            ),
          ),
          Text(
            'HACER',
            style: GoogleFonts.archivoBlack(
              fontSize: 50,
              color: AppTheme.white,
              fontWeight: FontWeight.w400,
              letterSpacing: -2,
              height: 1,
            ),
          ),
          Text(
            'CON',
            style: GoogleFonts.archivoBlack(
              fontSize: 50,
              color: AppTheme.white,
              fontWeight: FontWeight.w400,
              letterSpacing: -2,
              height: 1,
            ),
          ),
          TittleApp(appTheme: AppTheme(),tittleApp: tittleApp, sizeText: 72),
          LineDesign(appTheme: AppTheme(),sizeHeightLine: 10, sizeWidthLine: 120,sizeHeightCircle: 10,sizeWidthCircle: 10, splashValidator: false,)
        ],
      ),
    );
  }
}
