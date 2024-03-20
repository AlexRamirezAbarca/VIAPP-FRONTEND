import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:viapp/env/environment.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/home_page/widgets/layout_home_page.dart';
import 'package:viapp/modules/profile_page/widgets/profile_page_body.dart';
import 'package:viapp/modules/super_admin/widgets/super_admin_home.dart';
import 'package:viapp/modules/super_admin/widgets/view_users_admin_page.dart';
import 'package:viapp/shared/widgets/alert_modal.dart';

class LayoutAdminPage extends StatefulWidget {
  const LayoutAdminPage({super.key, this.requiredStack = true});

  final bool requiredStack;

  @override
  State<LayoutAdminPage> createState() => _LayoutAdminPageState();
}

class _LayoutAdminPageState extends State<LayoutAdminPage> {
  final PageController _pageController = PageController(initialPage: 0);
  String optionSelected = "admin";

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
          ContentWidgetAdmin(size: size, pageController: _pageController),
          _menuTemplateAdmin(),
          if (widget.requiredStack) const AlertModal(),
        ],
      ),
    );
  }
  Positioned _menuTemplateAdmin() {
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
                      if (optionSelected == 'admin') 
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
                          optionSelected = "admin";
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
                    if(optionSelected == 'reports')
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
                          optionSelected = "reports";
                          _navigateToPage(2);
                          setState(() {});
                        },
                        child: SvgPicture.asset('assets/menu_solicitud.svg', height: 32,width: 28,),
                      ),
                    ],
                  )
                ],
              ),
            ));
  }

}

class ContentWidgetAdmin extends StatelessWidget {
  const ContentWidgetAdmin({
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
          color: Color.fromARGB(255, 245, 244, 244),
        ),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: const [
            SuperAdminHome(),
            ProfilePageBody(),
            SuperAdminViewsUser()
          ],
        ),
      ),
    );
  }
}
