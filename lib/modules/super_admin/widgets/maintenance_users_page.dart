// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/super_admin/models/users_reponse.dart';
import 'package:viapp/modules/super_admin/services/super_admin_services.dart';
import 'package:viapp/modules/super_admin/widgets/view_users_widget.dart';
import 'package:viapp/shared/helpers/global_helper.dart';
import 'package:viapp/shared/providers/functional_provider.dart';
import 'package:viapp/shared/widgets/alerts_template.dart';
import 'package:viapp/shared/widgets/layout_widget.dart';
import 'package:viapp/shared/widgets/text_button_text.dart';
import 'package:viapp/shared/widgets/title.dart';

class MaintenanceUsers extends StatefulWidget {
  const MaintenanceUsers({super.key, required this.keyPage});
  final GlobalKey<State<StatefulWidget>> keyPage;

  @override
  State<MaintenanceUsers> createState() => _MaintenanceUsersState();
}

class _MaintenanceUsersState extends State<MaintenanceUsers> {
  final _superAdminServices = SuperAdminServices();
  UserResponse? userResponse;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllUsers();
    });
    super.initState();
  }

  void getAllUsers() async {
    final response = await _superAdminServices.getAllUsers(context);
    if (!response.error) {
      setState(() {
        userResponse = response.data!;
      });
    }
  }

  List<Widget> getAllUsersWidget() {
    return userResponse!.users
        .map<Widget>((e) => ViewUsersWidget(
              onPressedDisable: () {
                final updateDisableStatusUserKey = GlobalHelper.genKey();
                final fp =
                    Provider.of<FunctionalProvider>(context, listen: false);
                fp.showAlert(
                    key: updateDisableStatusUserKey,
                    content: AlertGeneric(
                        content: ConfirmContent(
                            message:
                                'Está seguro que desea deshabilitar el usuario',
                            confirm: () {
                              final userId = e.id;
                              final body = {
                                "user_id": userId,
                                "status": 0,
                              };
                              updateStatusUsers(body: body);
                              fp.dismissAlert(key: updateDisableStatusUserKey);
                            },
                            cancel: () {
                              fp.dismissAlert(key: updateDisableStatusUserKey);
                            })));
              },
              onPressedEnable: () {
                final updateEnableStatusUserKey = GlobalHelper.genKey();
                final fp =
                    Provider.of<FunctionalProvider>(context, listen: false);
                fp.showAlert(
                    key: updateEnableStatusUserKey,
                    content: AlertGeneric(
                        content: ConfirmContent(
                      message: 'Está seguro que desea habilitar el usuario',
                      cancel: () {
                        fp.dismissAlert(key: updateEnableStatusUserKey);
                      },
                      confirm: () {
                        final userId = e.id;
                        final body = {
                          "user_id": userId,
                          "status": 1,
                        };
                        updateStatusUsers(body: body);
                        fp.dismissAlert(key: updateEnableStatusUserKey);
                      },
                    )));
              },
              users: e,
            ))
        .toList();
  }

  void updateStatusUsers({required Map<String, int> body}) async {
    final response = await _superAdminServices.updateStatusUsers(context, body);
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
                getAllUsers();
              },
            ),
          ));
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
                  title: 'Mantenimiento de Usuarios',
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
                      'Con VIAPP, habilita y deshabilita los usuarios de tu empresa.',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: AppTheme.secondaryColor),
            ),
            const SizedBox(height: 25),
            if (userResponse != null)
              Column(
                children: getAllUsersWidget(),
              ),
            const SizedBox(height: 50),
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
          ],
        ),
      ),
    );
  }
}
