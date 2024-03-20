// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/super_admin/models/pending_requests.dart';
import 'package:viapp/modules/super_admin/services/super_admin_services.dart';
import 'package:viapp/modules/super_admin/widgets/pending_requests_widget.dart';
import 'package:viapp/shared/helpers/global_helper.dart';
import 'package:viapp/shared/providers/functional_provider.dart';
import 'package:viapp/shared/widgets/alerts_template.dart';
import 'package:viapp/shared/widgets/filled_button.dart';
import 'package:viapp/shared/widgets/layout_widget.dart';
import 'package:viapp/shared/widgets/placeholder.dart';
import 'package:viapp/shared/widgets/text_button_text.dart';
import 'package:viapp/shared/widgets/text_form_field.dart';
import 'package:viapp/shared/widgets/title.dart';

class PendingRequestsPage extends StatefulWidget {
  const PendingRequestsPage({super.key, required this.keyPage});
  final GlobalKey<State<StatefulWidget>> keyPage;
  @override
  State<PendingRequestsPage> createState() => _PendingRequestsPageState();
}

class _PendingRequestsPageState extends State<PendingRequestsPage> {
  List<Request> requests = [];
  final _superAdminServices = SuperAdminServices();
  String statusRequests = '1';
  PendingRequests? pendingRequests;
  final TextEditingController reasonDeniedRequest = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPendingRequests(statusRequests);
    });
    super.initState();
  }

  void getPendingRequests(String statusRequests) async {
    final response =
        await _superAdminServices.getPendingRequests(context, statusRequests);
    if (!response.error) {
      setState(() {
        pendingRequests = response.data!;
      });
    } else {
      inspect('NO CARGO NADA');
    }
  }

  List<Widget> getPendingRequestsWidget() {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return pendingRequests!.requests
        .map<Widget>((e) => PendingRequestsWidget(
              request: e,
              onPressedAccept: () {
                final requestId = e.id;
                inspect(requestId);
                final body = {"request_id": requestId, "status_id_request": 3};
                acceptRequest(body: body);
              },
              onPressedDenied: () {
                final requestId = e.id;
                inspect(requestId);
                final keyDeniedRequest = GlobalHelper.genKey();
                fp.showAlert(
                    key: keyDeniedRequest,
                    content: AlertGeneric(
                        content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.015),
                        SizedBox(height: size.height * 0.03),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: title(
                              title:
                                  "Por favor, ingrese el motivo de porque rechaza la solicitud",
                              fontWeight: FontWeight.bold,
                              fontName: 'Roboto',
                              color: AppTheme.secondaryColor),
                        ),
                        SizedBox(height: size.height * 0.04),
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.05),
                          child: placeHolderWidget(
                            placeholder: 'Descripción',
                          ),
                        ),
                        SizedBox(height: size.height * 0.006),
                        CustomTextField(
                          controller: reasonDeniedRequest,
                          maxLines: 2,
                        ),
                        SizedBox(height: size.height * 0.006),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButtonWidget(
                              onPressed: () {
                                fp.dismissAlert(key: keyDeniedRequest);
                              },
                              text: 'Cancelar',
                              decoration: TextDecoration.underline,
                              decorationColor: AppTheme.secondaryColor,
                              size: 15,
                              textColor: AppTheme.secondaryColor,
                            ),
                            FilledButtonWidget(
                              onPressed: () {
                                final body = {
                                  "request_id": requestId,
                                  "status_id_request": 2,
                                  "description": reasonDeniedRequest.text
                                };
                                declineRequest(body: body);
                                reasonDeniedRequest.clear();
                                fp.dismissAlert(key: keyDeniedRequest);
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
            ))
        .toList();
  }

  void acceptRequest({required Map<String, int> body}) async {
    final response = await _superAdminServices.acceptRequest(context, body);
    final successAcceptRequest = GlobalHelper.genKey();
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    if (!response.error) {
      fp.showAlert(
          key: successAcceptRequest,
          content: AlertGeneric(
            content: SuccessInformation(
              keyToClose: successAcceptRequest,
              message: response.message,
              onPressed: () {
                fp.dismissAlert(key: successAcceptRequest);
                getPendingRequests(statusRequests);
              },
            ),
          ));
    }
  }

  void declineRequest({required Map<String, dynamic> body}) async {
    final response = await _superAdminServices.declineRequest(context, body);
    final declineAcceptRequest = GlobalHelper.genKey();
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    if (!response.error) {
      fp.showAlert(
          key: declineAcceptRequest,
          content: AlertGeneric(
              content: SuccessInformation(
            keyToClose: declineAcceptRequest,
            message: response.message,
            onPressed: () {
              fp.dismissAlert(key: declineAcceptRequest);
              getPendingRequests(statusRequests);
            },
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return LayoutWidget(
      requiredStack: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: title(
                  title: 'Solicitudes Pendientes',
                  fontName: 'Roboto',
                  color: AppTheme.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: title(
                  fontName: 'Roboto',
                  title:
                      'Con VIAPP, acepta o deniega las solicitudes pendientes.',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: AppTheme.secondaryColor),
            ),
            if (pendingRequests != null)
              Column(
                children: getPendingRequestsWidget(),
              ),
            const SizedBox(
              height: 40,
            ),
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
            ),
            const SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }
}
