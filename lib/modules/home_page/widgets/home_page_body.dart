// ignore_for_file: avoid_unnecessary_containers

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:viapp/env/environment.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/home_page/models/my_requests_response.dart';
import 'package:viapp/modules/home_page/models/requests_response.dart';
import 'package:viapp/modules/home_page/services/requests_services.dart';
import 'package:viapp/modules/home_page/widgets/myrequests_widget.dart';
import 'package:viapp/modules/home_page/widgets/requests_widegt.dart';
import 'package:viapp/shared/models/login_response.dart';
import 'package:viapp/shared/secure/user_data_storage.dart';
import 'package:viapp/shared/widgets/title.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  String nameUser = '......';
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String tittleApp = Environment().config!.tittleAppName;

  final requestServices = RequestServices();

  List<Widget> listRequests = [];

  List<Widget> listMyRequests = [];

  RequestResponse? requestResponse;

  MyRequests? myRequests;

  int togglePosition = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userInformation();
      _getInformationRequests();
      _getInformationMyRequests();
      _pageController.addListener(() {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      });
    });
    super.initState();
  }

  Future<void> _refreshData() async {
    _getInformationRequests();
    _getInformationMyRequests();
    setState(() {});
  }

  void _getInformationRequests() async {
    final response = await requestServices.findRequests(context);
    if (!response.error) {
      requestResponse = response.data!;
      setState(() {});
    } else {
      inspect('NO CARGO NADA');
    }
  }

  void _getInformationMyRequests() async {
    final response = await requestServices.findMyRequests(context);
    if (!response.error) {
      myRequests = response.data!;
      setState(() {});
    } else {
      inspect('NO CARGO NADA');
    }
  }

  void userInformation() async {
    LoginResponse? userData = await UserDataStorage().getUserData();
    nameUser = userData!.user.firstName;
    setState(() {});
  }

  List<Widget> getRequests(int togglePosition) {
    return togglePosition == 0
        ? requestResponse?.requests
                .map<Widget>((e) => RequestsWideget(request: e))
                .toList() ??
            []
        : myRequests?.myRequests
                .map<Widget>((e) => MyRequestWideget(request: e))
                .toList() ??
            [];
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 25),
              child: title(
                  fontName: 'Archivo Black',
                  title: 'Hola, $nameUser',
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0, top: 1),
              child: title(
                  fontName: 'Roboto',
                  title: 'Bienvenida/o a tu app de solicitudes',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppTheme.secondaryColor),
            ),
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.secondaryColor,
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ToggleSwitch(
                      minWidth: 160.0,
                      cornerRadius: 250.0,
                      activeBgColors: const [
                        [AppTheme.white],
                        [AppTheme.white],
                      ],
                      activeFgColor: AppTheme.primaryColor,
                      inactiveBgColor: AppTheme.secondaryColor,
                      inactiveFgColor: Colors.white,
                      initialLabelIndex: togglePosition,
                      totalSwitches: 2,
                      labels: const ['Solicitudes', 'Mis solicitudes'],
                      customTextStyles: [
                        GoogleFonts.roboto(
                            fontSize: 16, fontWeight: FontWeight.w500)
                      ],
                      radiusStyle: true,
                      onToggle: (index) {
                        debugPrint('Estamos en la opción: $index');
                        setState(() {
                          togglePosition = index!;
                        });
                      }),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: SizedBox(
                height: 400,
                child: FlutterCarousel(
                  options: CarouselOptions(
                    clipBehavior: Clip.none,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 10),
                    viewportFraction: 0.6,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    slideIndicator: CircularWaveSlideIndicator(),
                    floatingIndicator: false,
                  ),
                  items: getRequests(togglePosition),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (requestResponse != null &&
                    requestResponse!.requests.isNotEmpty)
                  if (togglePosition == 0)
                    Text(
                      "${_currentPage + 1}/${requestResponse!.requests.length}",
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                if (requestResponse == null ||
                    requestResponse!.requests.isEmpty)
                  const Text(
                    "Cargando....", // Puedes personalizar el mensaje de carga
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
