import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/request_page/services/send_requests_services.dart';
import 'package:viapp/shared/helpers/global_helper.dart';
import 'package:viapp/shared/models/login_response.dart';
import 'package:viapp/shared/providers/functional_provider.dart';
import 'package:viapp/shared/secure/user_data_storage.dart';
import 'package:viapp/shared/widgets/alerts_template.dart';
import 'package:viapp/shared/widgets/filled_button.dart';
import 'package:viapp/shared/widgets/layout_widget.dart';
import 'package:viapp/shared/widgets/placeholder.dart';
import 'package:viapp/shared/widgets/text_button_text.dart';
import 'package:viapp/shared/widgets/text_form_field.dart';
import 'package:viapp/shared/widgets/title.dart';

class LayoutRequestWidget extends StatefulWidget {
  const LayoutRequestWidget(
      {super.key,
      required this.requestCode,
      required this.keyPage,
      required this.nameRequest,
      required this.descriptionRequest});
  final int requestCode;
  final String nameRequest;
  final String descriptionRequest;
  final GlobalKey<State<StatefulWidget>> keyPage;

  @override
  State<LayoutRequestWidget> createState() => _LayoutRequestWidgetState();
}

class _LayoutRequestWidgetState extends State<LayoutRequestWidget> {
  String nameUser = '......';
  String lastNameUser = '......';
  String identification = '.......';
  final TextEditingController _reasonDescription = TextEditingController();
  final _sendRequests = SendRequestServices();

  @override
  void initState() {
    userInformation();
    super.initState();
  }

  void userInformation() async {
    LoginResponse? userData = await UserDataStorage().getUserData();
    nameUser = userData!.user.firstName;
    lastNameUser = userData.user.lastName;
    identification = userData.user.identification;
    setState(() {});
  }

  void sendRequests({required Map<String, String> body}) async {
    final sendRequests = GlobalHelper.genKey();
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final response = await _sendRequests.sendRequest(context, body);
    if (!response.error) {
      fp.showAlert(
        key: sendRequests,
        content: AlertGeneric(
          content: SuccessInformation(
            keyToClose: sendRequests,
            message: response.message,
            onPressed: () {
              fp.dismissAlert(key: sendRequests);
              fp.dismissAlert(key: widget.keyPage);
            },
          ),
        ),
      );  
    }
  }

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return LayoutWidget(
      requiredStack: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 30),
            child: title(
                fontName: 'Roboto',
                title: widget.nameRequest,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: AppTheme.secondaryColor),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: title(
                fontName: 'Roboto',
                title: widget.descriptionRequest,
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: AppTheme.primaryColor),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: placeHolderWidget(
                placeholder: 'Nombres Completos',
                color: AppTheme.textColorRequest),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: placeHolderWidget(
                placeholder: '$nameUser $lastNameUser',
                color: AppTheme.textColorRequest,
                fontWeight: FontWeight.normal),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: _dividerHorizontal(),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: placeHolderWidget(
                placeholder: 'Cédula', color: AppTheme.textColorRequest),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: placeHolderWidget(
                placeholder: identification,
                color: AppTheme.textColorRequest,
                fontWeight: FontWeight.normal),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: _dividerHorizontal(),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: placeHolderWidget(
                placeholder: 'Área', color: AppTheme.textColorRequest),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: placeHolderWidget(
                placeholder: 'Desarrollo',
                color: AppTheme.textColorRequest,
                fontWeight: FontWeight.normal),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: _dividerHorizontal(),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: placeHolderWidget(
                placeholder: 'Cargo', color: AppTheme.textColorRequest),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: placeHolderWidget(
                placeholder: 'Aplicaciones Móviles',
                color: AppTheme.textColorRequest,
                fontWeight: FontWeight.normal),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: _dividerHorizontal(),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: placeHolderWidget(
                placeholder: 'Motivo de la solicitud',
                color: AppTheme.textColorRequest),
          ),
          const SizedBox(height: 5),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CustomTextField(
                controller: _reasonDescription,
                maxLines: 5,
              )),
          const SizedBox(height: 20),
          Center(
              child: FilledButtonWidget(
            color: AppTheme.primaryColor,
            width: 169,
            height: 46,
            text: 'Enviar solicitud',
            onPressed: () {
              final keyAlertReasonError = GlobalHelper.genKey();
              if (_reasonDescription.text.trim() == '') {
                fp.showAlert(
                  key: keyAlertReasonError,
                  content: AlertGeneric(
                    keyToClose: keyAlertReasonError,
                    content: ErrorGeneric(
                      keyToClose: keyAlertReasonError,
                      message:
                          'Por favor, llena el campo de motivo de la solicitud para poder enviar tu solicitud',
                    ),
                  ),
                );
              } else {
                final body = {
                  "reason": _reasonDescription.text.trim(),
                  "type_request_id": widget.requestCode.toString()
                };
                debugPrint(body.toString());
                sendRequests(body: body);
              }
            },
          )),
          const SizedBox(height: 20),
          Center(
            child: TextButtonWidget(
              onPressed: () {
                fp.dismissAlert(key: widget.keyPage);
              },
              text: 'Cancelar',
              size: 15,
              textColor: AppTheme.secondaryColor,
              decoration: TextDecoration.underline,
              decorationColor: AppTheme.secondaryColor,
            ),
          )
        ],
      ),
    );
  }
}

Divider _dividerHorizontal() {
  return const Divider(
      color: AppTheme.dividerHorizontalColorLine, thickness: 0.2);
}
