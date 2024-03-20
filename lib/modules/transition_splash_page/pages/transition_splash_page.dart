import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/transition_splash_page/widgets/transition_splash_1_body.dart';
import 'package:viapp/modules/transition_splash_page/widgets/transition_splash_2_body.dart';
import 'package:viapp/shared/models/login_response.dart';
import 'package:viapp/shared/secure/user_data_storage.dart';

import '../../../shared/helpers/global_helper.dart';

class TransitionSplashPage extends StatefulWidget {
  const TransitionSplashPage({Key? key}) : super(key: key);

  @override
  State<TransitionSplashPage> createState() => _TransitionSplashPageState();
}

class _TransitionSplashPageState extends State<TransitionSplashPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late int superUser;

  @override
  void initState() {
    super.initState();
    userInformation();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  void userInformation() async {
    LoginResponse? userData = await UserDataStorage().getUserData();
    superUser = userData!.user.superUser;
    inspect(superUser);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: const [
              TransitionPage1(),
              TransitionPage2(),
              // Agrega más páginas según sea necesario
            ],
          ),
          Positioned(
            bottom: 130,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                2, // Cambia este valor según la cantidad total de páginas
                (index) => buildPageIndicator(index),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: GestureDetector(
              onTap: (){
                if (superUser == 1 ) {
                  inspect('Soy super Usuario');
                  GlobalHelper.navigateToPage(context, '/super_admin');
                }else{
                   GlobalHelper.navigateToPage(context, '/home_page');
                }
               
              },
              child: Row(
                children: [
                  Text('Saltar',
                      style: GoogleFonts.roboto(
                        color: AppTheme.white,
                        fontSize: 18
                        )),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: AppTheme.white,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPageIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: _currentPage == index ? 16.0 : 8.0,
      height: 10.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? AppTheme.white : AppTheme.grey,
      ),
    );
  }
}
