import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/change_password_page/services/change_password_code_services.dart';
import 'package:viapp/modules/change_password_page/widgets/finally_change_password.dart';
import 'package:viapp/shared/helpers/global_helper.dart';
import 'package:viapp/shared/providers/functional_provider.dart';
import 'package:viapp/shared/widgets/alerts_template.dart';
import 'package:viapp/shared/widgets/filled_button.dart';
import 'package:viapp/shared/widgets/layout_widget.dart';
import 'package:viapp/shared/widgets/text_button_text.dart';
import 'package:viapp/shared/widgets/title.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody(
      {Key? key, required this.keyPage, required this.username})
      : super(key: key);
  final GlobalKey<State<StatefulWidget>> keyPage;
  final String username;

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  TextEditingController otpCodeChangePassword = TextEditingController();
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  final _codePasswordServices = ChangePasswordCodeServices();

  void validateCodePassword(
      {required Map<String, String> body,
      required GlobalKey<State<StatefulWidget>> keyPage}) async {
    final validateCodePassword = GlobalHelper.genKey();
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final response =
        await _codePasswordServices.validateCodePassword(context, body);
    if (!response.error) {
      fp.dismissAlert(key: keyPage);
      fp.showAlert(
        key: validateCodePassword,
        content: AlertGeneric(
          content: SuccessInformation(
            keyToClose: validateCodePassword,
            message: response.message,
            onPressed: () {
              fp.dismissAlert(key: validateCodePassword);
              inspect('Token que llega : ${response.data!.token.toString()}');
              final pageTokenChangePassword = GlobalHelper.genKey();
              fp.addPage(
                key: pageTokenChangePassword,
                content: FinallyChangePassword(
                  keyPage: pageTokenChangePassword,
                  key: pageTokenChangePassword,
                  tokenChangePassword: response.data!.token,
                ),
              );
            },
          ),
        ),
      );
    } else {
      fp.dismissAlert(key: keyPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    int endTime =
        DateTime.now().millisecondsSinceEpoch + 1000 * 300; // 1 minuto
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    return LayoutWidget(
      requiredStack: false,
      child: Column(
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
            child: title(
                fontName: 'Archivo Black',
                title: 'Ingresa tu código',
                fontSize: width * 0.07,
                color: AppTheme.secondaryColor,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 25),
          title(
              fontName: 'Roboto',
              title:
                  'Ingresa el codigo de verificación que se envio a tu correo',
              fontSize: width * 0.035,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w500),
          const SizedBox(height: 50),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: PinCodeTextField(
                appContext: context,
                pastedTextStyle: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                controller: otpCodeChangePassword,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  debugPrint(value);
                  setState(() {
                    currentText = value;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          title(
              fontName: 'Roboto',
              title: 'El código solo tiene validez de ',
              fontSize: width * 0.035,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w500),
          CountdownTimer(
                endTime: endTime,
                textStyle: GoogleFonts.roboto(
                  color: AppTheme.secondaryColor,
                  fontSize:20,
                  fontWeight: FontWeight.w500),
              ),
          const SizedBox(height: 250),
          FilledButtonWidget(
            text: 'Aceptar',
            onPressed: () {
              final codeValidatorPage = GlobalHelper.genKey();
              final body = {"user_name": widget.username, "code": currentText};
              inspect(body);
              validateCodePassword(keyPage: codeValidatorPage, body: body);
              setState(() {
                currentText = "";
                otpCodeChangePassword.clear();
              });
            },
            color: AppTheme.primaryColor,
            width: 120,
          ),
          const SizedBox(height: 20),
          TextButtonWidget(
            text: 'Cancelar',
            fontWeight: FontWeight.w600,
            onPressed: () {
              fp.dismissAlert(key: widget.keyPage);
            },
            size: 16,
            textColor: AppTheme.secondaryColor,
            decoration: TextDecoration.underline,
            decorationColor: AppTheme.secondaryColor,
          ),
        ],
      ),
    );
  }
}
