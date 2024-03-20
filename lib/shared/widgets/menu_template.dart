import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/shared/helpers/global_helper.dart';

class MenuTemplate extends StatefulWidget {
  const MenuTemplate({super.key});

  @override
  State<MenuTemplate> createState() => _MenuTemplateState();
}

class _MenuTemplateState extends State<MenuTemplate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 380,
      decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(38.5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              debugPrint('PROFILE BUTTON');
            GlobalHelper.navigateToPageRemove(context, '/profile_page');
            },
            child: SvgPicture.asset('assets/profile.svg'),
          ),
          GestureDetector(
            onTap: () {
              debugPrint('HOME BUTTON');
              GlobalHelper.navigateToPageRemove(context, '/home_page');
            },
            child: SvgPicture.asset('assets/home.svg'),
          ),
          GestureDetector(
            onTap: () {
              debugPrint('ABOUT BUTTON');
              GlobalHelper.navigateToPageRemove(context, '/profile_page');
            },
            child: SvgPicture.asset('assets/about.svg'),
          )
        ],
      ),
    );
  }
}
