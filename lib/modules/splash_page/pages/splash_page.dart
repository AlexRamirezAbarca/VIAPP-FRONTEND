// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:viapp/modules/splash_page/widgets/splash_page_body.dart';
import 'package:viapp/shared/helpers/global_helper.dart';
import 'package:viapp/shared/secure/user_data_storage.dart';


import '../../../env/theme/app_theme.dart';
import '../../../shared/routes/app_routes.dart';
import '../../not_found_page/pages/page_404.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  AppTheme appTheme = AppTheme();
  


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verifySessions();
    });
    super.initState(); 
  }


  void _verifySessions() async {
    final userSession = await UserDataStorage().getUserData();

    if(userSession != null){
      if(userSession.user.superUser == 1 ){
        Future.delayed(const Duration(seconds: 3), () => GlobalHelper.navigateToPageRemove(context, '/super_admin'));
      }else{
        Future.delayed(const Duration(seconds: 3), () => GlobalHelper.navigateToPageRemove(context, '/home_page'));
      }
    } else {
      Future.delayed(const Duration(seconds: 3), () => _goTo('/login_page')); 
    }
  }


   _goTo(String routeName) {
    final route = AppRoutes.routes[routeName];
    final page = (route != null) ? route.call(context) : const PageNotFound();
    Navigator.push(
      context,
      PageRouteBuilder(
        fullscreenDialog: true,
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          var fadeTween = Tween(begin: 0.0, end: 1.0);
          var fadeAnimation = animation.drive(fadeTween);
          return FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: offsetAnimation,
              child: child,
            ),
          );
        },
      ),
    );
  }   



  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SplashPageBody()
    );
  }
}