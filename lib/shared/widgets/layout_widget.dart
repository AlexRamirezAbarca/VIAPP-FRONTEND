import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/shared/widgets/alert_modal.dart';
import '../../env/environment.dart';
import '../../modules/splash_page/widgets/splash_page_body.dart';

class LayoutWidget extends StatefulWidget {
  const LayoutWidget({super.key,
  required this.child,
  this.requiredStack = true});

  final Widget child;
  final bool requiredStack;

  @override
  State<LayoutWidget> createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String tittleApp = Environment().config!.tittleAppName;
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(25))),
                automaticallyImplyLeading: false,
                pinned: true,
                floating: false,
                toolbarHeight: size.height * 0.10,
                centerTitle: true,
                backgroundColor: AppTheme.primaryColor,
                title: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  TittleApp(
                      tittleApp: tittleApp, sizeText: 30, appTheme: AppTheme()),
                  Row(
                    children: [
                      const SizedBox(width: 13),
                      LineDesign(
                        appTheme: AppTheme(),
                        sizeHeightLine: 5,
                        sizeWidthLine: 50,
                        sizeHeightCircle: 5,
                        sizeWidthCircle: 5,
                        splashValidator: true,
                      )
                    ],
                  )
                ]),
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                child: BounceInUp(
                  delay: const Duration(milliseconds: 100),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: widget.child,
                  ),
                ),
              )
            ],
          ),
          if(widget.requiredStack) const AlertModal(),
        ],
      ),
    );
  }
}
