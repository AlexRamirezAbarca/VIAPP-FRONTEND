import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viapp/env/environment.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/about_page/pages/about_page.dart';
import 'package:viapp/modules/home_page/widgets/home_page_body.dart';
import 'package:viapp/modules/profile_page/widgets/profile_page_body.dart';
import 'package:viapp/shared/widgets/alert_modal.dart';
import '../../splash_page/widgets/splash_page_body.dart';

class LayoutHomePage extends StatefulWidget {
  const LayoutHomePage({super.key, this.requiredStack = true});

  final bool requiredStack;

  @override
  State<LayoutHomePage> createState() => _LayoutHomePageState();
}

class _LayoutHomePageState extends State<LayoutHomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  String optionSelected = "home";

  void _navigateToPage(int page) {
    debugPrint("Page: $page");
    if (_pageController.hasClients) {
      setState(() {
        if (page > 1) {
          debugPrint('Estamos en la page: $page');
        }
      });
      _pageController.jumpToPage(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    String tittleApp = Environment().config!.tittleAppName;
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Stack(
        children: <Widget>[
          TitleLayoutHomePage(size: size, tittleApp: tittleApp),
          ContentWidget(size: size, pageController: _pageController),
          _menuTemplate(),
          if (widget.requiredStack) const AlertModal(),
        ],
      ),
    );
  }

  Positioned _menuTemplate() {
    return Positioned(
            bottom: 30,
            left: 10,
            right: 10,
            child: Container(
              height: 50,
              width: 380,
              decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(38.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (optionSelected == 'profile') 
                      FadeInUp(
                        child: Container(
                          height: 3,
                          width: 25,
                          color: AppTheme.secondaryColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      GestureDetector(
                        onTap: () {
                          debugPrint('PROFILE BUTTON');
                          optionSelected = "profile";
                          _navigateToPage(1);
                          setState(() {});
                        },
                        child: SvgPicture.asset('assets/profile.svg'),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (optionSelected == 'home') 
                      FadeInUp(
                        child: Container(
                          height: 3,
                          width: 25,
                          color: AppTheme.secondaryColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      GestureDetector(
                        onTap: () {
                          debugPrint('HOME BUTTON');
                          optionSelected = "home";
                          _navigateToPage(0);
                          setState(() {});
                        },
                        child: SvgPicture.asset('assets/home.svg'),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    if(optionSelected == 'about')
                    FadeInUp(
                      child: Container(
                          height: 3,
                          width: 25,
                          color: AppTheme.secondaryColor,
                        ),
                    ),
                      const SizedBox(height: 3),
                      GestureDetector(
                        onTap: () {
                          debugPrint('ABOUT BUTTON');
                          optionSelected = "about";
                          _navigateToPage(2);
                          setState(() {});
                        },
                        child: SvgPicture.asset('assets/about.svg'),
                      ),
                    ],
                  )
                ],
              ),
            ));
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    super.key,
    required this.size,
    required PageController pageController,
  }) : _pageController = pageController;

  final Size size;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      width: size.width,
      height: size.height,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: const [
            HomePageBody(),
            ProfilePageBody(),
            AboutPage()
          ],
        ),
      ),
    );
  }
}

// class MenuTemplateHomePage extends StatelessWidget {

class TitleLayoutHomePage extends StatelessWidget {
  const TitleLayoutHomePage({
    super.key,
    required this.size,
    required this.tittleApp,
  });

  final Size size;
  final String tittleApp;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.5,
      left: 45,
      right: 45,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          color: AppTheme.primaryColor,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            TittleApp(
              tittleApp: tittleApp,
              sizeText: 30,
              appTheme: AppTheme(),
            ),
            Row(
              children: [
                const SizedBox(width: 101),
                LineDesign(
                  appTheme: AppTheme(),
                  sizeHeightLine: 5,
                  sizeWidthLine: 50,
                  sizeHeightCircle: 5,
                  sizeWidthCircle: 5,
                  splashValidator: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
