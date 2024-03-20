import 'package:flutter/material.dart';

class AppTheme {
  static const Color secondaryColorS = Color(0xFFFE6936);
  static const Color textColorS = Color(0xFF43B1E5);
  static const Color textColorFormS = Color(0xFF9AAFC0);
  static const Color borderLineTextField = Color(0xFFDFDFDF);
  static const Color hinText = Color(0xFF5B5B5B);
  static const Color whiteS = Color(0xFFfcfcfc);
  static const Color black12 = Colors.black12;
  //static const Color error = Color(0xffF94838);
  static const Color textColorRequest = Color(0xFF838383);
  static const Color primaryColor = Color(0xFF3DBFEF);
  static const Color secondaryColor = Color(0xFFFE6936);
  static const Color white = Color(0xFFfcfcfc);
  static const Color designLine = Color(0xFFD4E4FE);
  static const Color designCircle = Color(0xFFF1DED7);
  static const Color textColor = Color(0xFF43B1E5);
  //static const Color textColorForm = Color(0xFF9AAFC0);
  //Color borderLineTextField = const Color(0xFFDFDFDF);
  static const Color grey = Colors.grey;
  static const Color dividerHorizontalColorLine = Color(0xFFD3D8DD);
  static const Color textColorForm = Color(0xFF0B2840);
  static const Color textColorAbout = Color(0xFF676767);
  static const Color whiteFigma= Color(0xFFFFFFFF);

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppTheme.whiteFigma,
      cardColor: AppTheme.whiteFigma,
      cardTheme: const CardTheme(
        color: AppTheme.whiteFigma
      ),

    );
  }

  static const String iconErrorPath = 'assets/error.svg';
  static const String iconAlertPath = 'assets/alert.svg';
  static const String iconCheckPath = 'assets/success.svg';
}
