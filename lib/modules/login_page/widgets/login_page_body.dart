import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/change_password_page/pages/change_password.dart';
import 'package:viapp/modules/login_page/services/change_password_service.dart';
import 'package:viapp/modules/login_page/services/login_service.dart';
import 'package:viapp/modules/register_page/pages/register_page.dart';
import 'package:viapp/shared/providers/functional_provider.dart';
import 'package:viapp/shared/widgets/alerts_template.dart';
import 'package:viapp/shared/widgets/filled_button.dart';
import 'package:viapp/shared/widgets/placeholder.dart';
import 'package:viapp/shared/widgets/text_form_field.dart';
import 'package:viapp/shared/widgets/title.dart';

import '../../../shared/helpers/global_helper.dart';
import '../../../shared/widgets/text_button_text.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  AppTheme appTheme = AppTheme();
  final _loginService = LoginService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController usernameChangePassword = TextEditingController();
  bool snap = false;
  bool floating = false;
  bool showPassword = false;
  GlobalHelper globalHelper = GlobalHelper();
  final _changePasswordServices = ChangePasswordServices();
  bool changePagePassword = false;

  void login({required Map<String, String> body}) async {
    await _loginService.login(context, body);
  }

  void validateChangePassword(
      {required Map<String, String> body,
      required GlobalKey<State<StatefulWidget>> keyPage, required String username}) async {
    final successChangePasswordAlertKey = GlobalHelper.genKey();
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final response = await _changePasswordServices.validateEmailChangePassword(
        context, body);
    if (!response.error) {
      fp.dismissAlert(key: keyPage);
      fp.showAlert(
        key: successChangePasswordAlertKey,
        content: AlertGeneric(
          content: SuccessInformation(
            keyToClose: successChangePasswordAlertKey,
            message: response.message,
            onPressed: () {
              fp.dismissAlert(key: successChangePasswordAlertKey);
              final keyPageChangePassword = GlobalHelper.genKey();
              fp.addPage(
                key: keyPageChangePassword,
                content: ChangePassword(
                  keyPage: keyPageChangePassword,
                  key: keyPageChangePassword,
                  username: username,
                ),
              );
            },
          ),
        ),
      );
      usernameChangePassword.clear();
    } else {
      fp.dismissAlert(key: keyPage);
      usernameChangePassword.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fp = Provider.of<FunctionalProvider>(context, listen: false);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: AppTheme.primaryColor,
            child: Align(
              alignment: const Alignment(0, -0.5),
              child: Text(
                'hola .',
                style: GoogleFonts.archivoBlack(
                    height: 1,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                    color: AppTheme.white),
              ),
            ),
          ),
          FadeInUp(
            delay: const Duration(milliseconds: 600),
            child: Align(
              alignment: const Alignment(0, 1),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                child: Container(
                  height: MediaQuery.of(context).size.height / 2 + 90,
                  width: MediaQuery.of(context).size.width,
                  color: AppTheme.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 25),
                          title(
                              fontName: 'Roboto',
                              title: 'Iniciar Sesión',
                              color: AppTheme.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                          const SizedBox(height: 30),
                          Padding(
                              padding:
                                  EdgeInsets.only(left: size.width * 0.050),
                              child: placeHolderWidget(placeholder: 'Usuario')),
                          const SizedBox(height: 5),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: CustomTextField(
                              controller: _usernameController,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                              padding:
                                  EdgeInsets.only(left: size.width * 0.050),
                              child:
                                  placeHolderWidget(placeholder: 'Contraseña')),
                          const SizedBox(height: 5),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: CustomTextField(
                              controller: _passwordController,
                              obscureText: !showPassword,
                              suffixIcon: IconButton(
                                color: AppTheme.textColorFormS,
                                icon: !showPassword
                                    ? const Icon(Icons.remove_red_eye_outlined)
                                    : const Icon(Icons.visibility_off_outlined),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 35),
                          TextButtonWidget(
                            text: '¿Olvidaste tu contraseña?',
                            size: 14,
                            textColor: AppTheme.textColorFormS,
                            onPressed: () {
                              final keyChangePasswordModal =
                                  GlobalHelper.genKey();
                              fp.showAlert(
                                  key: keyChangePasswordModal,
                                  content: AlertGeneric(
                                      content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: size.height * 0.015),
                                      SizedBox(height: size.height * 0.03),
                                      title(
                                          title: "Olvidé mi contraseña",
                                          fontWeight: FontWeight.bold,
                                          fontName: 'Roboto',
                                          color: AppTheme.secondaryColor),
                                      SizedBox(height: size.height * 0.04),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.05),
                                        child: placeHolderWidget(
                                          placeholder: 'Usuario',
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.006),
                                      CustomTextField(
                                        controller: usernameChangePassword,
                                        maxLines: 1,
                                      ),
                                      SizedBox(height: size.height * 0.006),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextButtonWidget(
                                            onPressed: () {
                                              fp.dismissAlert(
                                                  key: keyChangePasswordModal);
                                            },
                                            text: 'Cancelar',
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                AppTheme.secondaryColor,
                                            size: 15,
                                            textColor: AppTheme.secondaryColor,
                                          ),
                                          FilledButtonWidget(
                                            onPressed: () {
                                              final bodyUsername = {
                                                "user_name":
                                                    usernameChangePassword.text
                                                        .trim(),
                                              };
                                              validateChangePassword(
                                                  keyPage:
                                                      keyChangePasswordModal,
                                                  body: bodyUsername,
                                                  username: usernameChangePassword.text);
                                            },
                                            text: 'Aceptar',
                                            color: AppTheme.primaryColor,
                                            width: 120,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: size.height * 0.01),
                                    ],
                                  )));
                            },
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '¿No tienes cuenta?',
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: AppTheme.textColorFormS),
                              ),
                              const SizedBox(width: 5),
                              TextButtonWidget(
                                textColor: AppTheme.textColorFormS,
                                text: 'Registrate',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                size: 14,
                                decorationColor: AppTheme.textColorFormS,
                                onPressed: () {
                                  final keyPageRegister = GlobalHelper.genKey();
                                  fp.addPage(
                                    key: keyPageRegister,
                                    content: RegisterPage(
                                      keyPage: keyPageRegister,
                                      key: keyPageRegister,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 45),
                          FilledButtonWidget(
                            width: 170,
                            height: 45,
                            text: 'Iniciar sesión',
                            onPressed: () {
                              final keyAlertError = GlobalHelper.genKey();
                              if (_usernameController.text.trim() == '' ||
                                  _passwordController.text.trim() == '') {
                                fp.showAlert(
                                  key: keyAlertError,
                                  content: AlertGeneric(
                                    keyToClose: keyAlertError,
                                    content: ErrorGeneric(
                                      keyToClose: keyAlertError,
                                      message:
                                          'Por favor, llena los campos requeridos para poder iniciar sesión',
                                    ),
                                  ),
                                );
                              } else {
                                final body = {
                                  "user_name": _usernameController.text.trim(),
                                  "password": _passwordController.text.trim()
                                };
                                login(body: body);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
