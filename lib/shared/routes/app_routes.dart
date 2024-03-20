import 'package:flutter/material.dart';
import 'package:viapp/modules/super_admin/pages/super_admin_page.dart';

import '../../modules/home_page/pages/home_page.dart';
import '../../modules/login_page/pages/login_page.dart';
import '../../modules/not_found_page/pages/page_404.dart';
import '../../modules/profile_page/pages/profile_page.dart';
import '../../modules/splash_page/pages/splash_page.dart';
import '../../modules/transition_splash_page/pages/transition_splash_page.dart';
import '../../modules/transition_splash_page/widgets/transition_splash_1_body.dart';
import '../../modules/transition_splash_page/widgets/transition_splash_2_body.dart';

class AppRoutes{
  static const initialRoute = '/splash';
  //final GlobalKey<State<StatefulWidget>> keyPage;
  static Map<String, Widget Function(BuildContext)> routes ={
    '/splash' : (_) => const SplashPage (),
    '/login_page' : (_) => const LoginPage(),
    '/home_page' : (_) => const HomePage(),
    '/transition_page' : (_) => const TransitionSplashPage(),
    '/transition_splash_1' : (_) => const TransitionPage1(),
    '/transition_splash_2' : (_) => const TransitionPage2(),
    '/profile_page' : (_) => const ProfilePage(),
    '/super_admin' : (_) => const SuperAdminPage(),

    
  };


  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const PageNotFound(),
      //builder: (context) => const LoadingPage(),
    );
  }
}