// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viapp/modules/profile_page/models/profile_response.dart';
import 'package:viapp/modules/profile_page/services/profile_services.dart';
import 'package:viapp/shared/helpers/global_helper.dart';
import 'package:viapp/shared/models/login_response.dart';
import 'package:viapp/shared/providers/functional_provider.dart';
import 'package:viapp/shared/widgets/alerts_template.dart';
import 'package:viapp/shared/widgets/title.dart';
import '../../../env/environment.dart';
import '../../../env/theme/app_theme.dart';
import '../../../shared/secure/user_data_storage.dart';
import '../../../shared/widgets/placeholder.dart';
import '../../../shared/widgets/text_button_text.dart';

class ProfilePageBody extends StatefulWidget {
  static ProfileResponse? profileResponse;
  const ProfilePageBody({
    super.key,
  });

  @override
  State<ProfilePageBody> createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<ProfilePageBody> {
  String nameUser = '......';
  String lastNameUser = '......';
  String tittleApp = Environment().config!.tittleAppName;
  final profileServices = ProfileServices();

  void userInformation() async {
    LoginResponse? userData = await UserDataStorage().getUserData();
    nameUser = userData!.user.firstName;
    lastNameUser = userData.user.lastName;
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userInformation();
      _getInformationProfile();
    });
    super.initState();
  }

  void _getInformationProfile() async {
    if (ProfilePageBody.profileResponse == null) {
      final response = await profileServices.getProfile(context);
      if (!response.error) {
        ProfilePageBody.profileResponse = response.data!;
        setState(() {});
      } else {
        inspect('NO CARGO NADA');
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final String nameComplete =
        '${ProfilePageBody.profileResponse?.firstName ?? 'Cargando...'} ${ProfilePageBody.profileResponse?.lastName ?? ''}';
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 35, bottom: 15, left: 9, right: 9),
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            ProfilePageBody.profileResponse != null
                ? CircleAvatar(
                    maxRadius: 60,
                    backgroundImage:
                        NetworkImage(ProfilePageBody.profileResponse!.urlPhoto),
                  )
                : const CircleAvatar(
                    maxRadius: 35,
                    backgroundColor: AppTheme.secondaryColorS,
                  ),
            const SizedBox(height: 10),
            title(
                fontName: 'Roboto',
                title: nameComplete,
                fontSize: 18,
                color: AppTheme.primaryColor),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: placeHolderWidget(
                  placeholder: 'Fecha de nacimiento',
                  color: AppTheme.textColorForm),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: placeHolderWidget(
                  placeholder: ProfilePageBody.profileResponse?.birthDate ??
                      'Cargando ..',
                  color: AppTheme.textColorForm,
                  fontWeight: FontWeight.normal),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: _dividerHorizontal(),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: placeHolderWidget(
                placeholder: 'Identidad',
                color: AppTheme.textColorForm,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: placeHolderWidget(
                  placeholder:
                      ProfilePageBody.profileResponse?.identification ??
                          'Cargando ..',
                  color: AppTheme.textColorForm,
                  fontWeight: FontWeight.normal),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: _dividerHorizontal(),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: placeHolderWidget(
                placeholder: 'Teléfono',
                color: AppTheme.textColorForm,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: placeHolderWidget(
                  placeholder:
                      ProfilePageBody.profileResponse?.phone ?? 'Cargando ..',
                  color: AppTheme.textColorForm,
                  fontWeight: FontWeight.normal),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: _dividerHorizontal(),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: placeHolderWidget(
                placeholder: 'Email',
                color: AppTheme.textColorForm,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: placeHolderWidget(
                  placeholder:
                      ProfilePageBody.profileResponse?.email ?? 'Cargando ..',
                  color: AppTheme.textColorForm,
                  fontWeight: FontWeight.normal),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: _dividerHorizontal(),
            ),
            const SizedBox(
              height: 50,
            ),
            TextButtonWidget(
              text: 'Cerrar sesión',
              onPressed: () async {
                final keyLogout = GlobalHelper.genKey();
                fp.showAlert(
                    key: keyLogout,
                    content: AlertGeneric(
                      content: ConfirmContent(
                          message:
                              'Esta seguro que desea cerrar la sesión y borrar el acceso?',
                          confirm: () async {
                            fp.dismissAlert(key: keyLogout);
                            await UserDataStorage().removeUserData();
                            GlobalHelper.navigateToPageRemove(
                                context, '/login_page');
                          },
                          cancel: () {
                            fp.dismissAlert(key: keyLogout);
                          }),
                    ));
              },
              size: 18,
              textColor: AppTheme.secondaryColor,
              decoration: TextDecoration.underline,
              decorationColor: AppTheme.secondaryColorS,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}

Divider _dividerHorizontal() {
  return const Divider(
      color: AppTheme.dividerHorizontalColorLine, thickness: 0.2);
}
