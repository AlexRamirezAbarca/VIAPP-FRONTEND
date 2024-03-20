import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viapp/env/environment.dart';

import '../../../env/theme/app_theme.dart';

class SplashPageBody extends StatefulWidget {
  const SplashPageBody({super.key});

  @override
  State<SplashPageBody> createState() => _SplashPageBodyState();
}

class _SplashPageBodyState extends State<SplashPageBody> {

  AppTheme appTheme = AppTheme();
  String tittleApp = Environment().config!.tittleAppName;
  int? sizeText ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          TittleApp(tittleApp: tittleApp, appTheme: appTheme, sizeText: 50),
          LineDesign(appTheme: appTheme, sizeHeightLine: 8, sizeWidthLine: 80, sizeHeightCircle: 8,sizeWidthCircle: 8,splashValidator: true,)
        ] 
        ),
    );
  }
}

class LineDesign extends StatelessWidget {
  const LineDesign({
    super.key,
    required this.appTheme, 
    required this.sizeHeightLine, 
    required this.sizeWidthLine, 
    required this.sizeHeightCircle, 
    required this.sizeWidthCircle,
    required this.splashValidator
    
  });

  final AppTheme appTheme;
  final double sizeHeightLine ;    //8
  final double sizeWidthLine ;     //80
  final double sizeHeightCircle;   //8
  final double sizeWidthCircle;     //8
  final bool splashValidator ;
  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        splashValidator ? const SizedBox(width: 135) : const SizedBox(width: 15),
        FadeInLeft(
          animate: true,
          duration: const Duration(milliseconds : 600),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: AppTheme.designLine,
              height:sizeHeightLine ,
              width: sizeWidthLine,
            ),
          ),
        ),
        const SizedBox(width: 8),
        FadeInLeft(
          animate: true,
          duration: const Duration(milliseconds : 800),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: AppTheme.designCircle,
              height:sizeHeightCircle ,
              width: sizeWidthCircle,
            ),
          ),
        ),
        const SizedBox(width: 8),
        FadeInLeft(
          animate: true,
          duration: const Duration(milliseconds : 1200),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: AppTheme.designCircle,
              height:sizeHeightCircle ,
              width: sizeWidthCircle,
            ),
          ),
        ),
        const SizedBox(width: 8),
        FadeInLeft(
          animate: true,
          duration: const Duration(milliseconds : 1400),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: AppTheme.designCircle,
              height:sizeHeightCircle ,
              width: sizeWidthCircle,
            ),
          ),
        ),
      ],
    );
  }
}

class TittleApp extends StatelessWidget {
  const TittleApp({
    super.key,
    required this.tittleApp,
    required this.appTheme,
    required this.sizeText
  });

  final String tittleApp;
  final AppTheme appTheme;
  final double sizeText;

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      animate: true,
      duration: const Duration(milliseconds: 500),
      child: Text(
        tittleApp,
        style: GoogleFonts.archivoBlack(
            height: 1,
            fontSize: sizeText,
            fontWeight: FontWeight.bold,
            letterSpacing: -1,
            color: AppTheme.white),
      ),
    );
  }
}
