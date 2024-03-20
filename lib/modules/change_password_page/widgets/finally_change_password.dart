import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/change_password_page/services/change_password_code_services.dart';
import 'package:viapp/shared/helpers/global_helper.dart';
import 'package:viapp/shared/providers/functional_provider.dart';
import 'package:viapp/shared/widgets/alerts_template.dart';
import 'package:viapp/shared/widgets/filled_button.dart';
import 'package:viapp/shared/widgets/layout_widget.dart';
import 'package:viapp/shared/widgets/placeholder.dart';
import 'package:viapp/shared/widgets/text_form_field.dart';
import 'package:viapp/shared/widgets/title.dart';

class FinallyChangePassword extends StatefulWidget {
  const FinallyChangePassword(
      {super.key, required this.keyPage, required this.tokenChangePassword});
  final GlobalKey<State<StatefulWidget>> keyPage;
  final String tokenChangePassword;

  @override
  State<FinallyChangePassword> createState() => _FinallyChangePasswordState();
}

class _FinallyChangePasswordState extends State<FinallyChangePassword> {
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();

  final FocusNode _focusNewPassword = FocusNode();
  final FocusNode _focusConfirmNewPassword = FocusNode();

  bool showNewPassword = false;
  bool showNewPasswordConfirmPassword = false;

  final _changePasswordServices = ChangePasswordCodeServices();

  void changePassword({required Map<String, dynamic> body}) async {
    final succesChangePassword = GlobalHelper.genKey();
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final response =
        await _changePasswordServices.sendChangePassword(context, body);

    if (!response.error) {
      fp.showAlert(
        key: succesChangePassword,
        content: AlertGeneric(
          content: SuccessInformation(
            keyToClose: succesChangePassword,
            message: response.message,
            onPressed: () {
              fp.dismissAlert(key: widget.keyPage);
              fp.clearAllAlert();
            },
          ),
        ),
      );
    } else {
      fp.dismissAlert(key: widget.keyPage);
      fp.clearAllAlert();
    }
  }

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    return LayoutWidget(
      requiredStack: false,
      child: Column(
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
            child: title(
                fontName: 'Archivo Black',
                title: 'Falta poco',
                fontSize: width * 0.07,
                color: AppTheme.secondaryColor,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 45),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: title(
                fontName: 'Roboto',
                title:
                    'Ingresa su nueva contraseña con la cual podrá iniciar sesión despúes de haber realizado el cambio.',
                fontSize: width * 0.035,
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 35),
          Padding(
              padding: EdgeInsets.only(left: size.width * 0.13),
              child: placeHolderWidget(placeholder: 'Contraseña')),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: CustomTextField(
              focusNode: _focusNewPassword,
              controller: _newPassword,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              obscureText: !showNewPassword,
              suffixIcon: IconButton(
                icon: Icon(
                  showNewPassword ? Icons.visibility : Icons.visibility_off,
                  color: AppTheme.primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    showNewPassword = !showNewPassword;
                  });
                },
              ),
              onSubmitted: (value) {
                _focusNewPassword.unfocus();
                FocusScope.of(context).requestFocus(_focusConfirmNewPassword);
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
              padding: EdgeInsets.only(left: size.width * 0.13),
              child: placeHolderWidget(placeholder: 'Repetir contraseña')),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: CustomTextField(
              focusNode: _focusConfirmNewPassword,
              controller: _confirmNewPassword,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !showNewPasswordConfirmPassword,
              suffixIcon: IconButton(
                icon: Icon(
                  showNewPasswordConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: AppTheme.primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    showNewPasswordConfirmPassword =
                        !showNewPasswordConfirmPassword;
                  });
                },
              ),
              onSubmitted: (value) {
                _focusConfirmNewPassword.unfocus();
              },
            ),
          ),
          const SizedBox(height: 180),
          FilledButtonWidget(
            width: 170,
            height: 45,
            text: 'Cambiar contraseña',
            onPressed: () {
              final keyAlertError = GlobalHelper.genKey();
              if (_newPassword.text.trim() == '' ||
                  _confirmNewPassword.text.trim() == '') {
                fp.showAlert(
                  key: keyAlertError,
                  content: AlertGeneric(
                    keyToClose: keyAlertError,
                    content: ErrorGeneric(
                      keyToClose: keyAlertError,
                      message:
                          'Por favor, llena los campos requeridos para poder cambiar la contraseña.',
                    ),
                  ),
                );
              } else {
                if (_newPassword.text.trim() ==
                    _confirmNewPassword.text.trim()) {
                  final body = {
                    "password": _confirmNewPassword.text.trim(),
                    "token": widget.tokenChangePassword,
                  };
                  changePassword(body: body);
                } else {
                  final errorPassworKey = GlobalHelper.genKey();
                  fp.showAlert(
                    key: errorPassworKey,
                    content: AlertGeneric(
                      keyToClose: errorPassworKey,
                      content: ErrorGeneric(
                        keyToClose: errorPassworKey,
                        message: 'Las contraseñas que ingresaste no coinciden.',
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
