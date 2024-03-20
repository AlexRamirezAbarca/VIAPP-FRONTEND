// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/super_admin/widgets/maintenance_requests.dart';
import 'package:viapp/modules/super_admin/widgets/maintenance_users_page.dart';
import 'package:viapp/shared/helpers/global_helper.dart';
import 'package:viapp/shared/providers/functional_provider.dart';
import 'package:viapp/shared/widgets/title.dart';

class SuperAdminViewsUser extends StatefulWidget {
  const SuperAdminViewsUser({super.key});

  @override
  State<SuperAdminViewsUser> createState() => _SuperAdminViewsUserState();
}

class _SuperAdminViewsUserState extends State<SuperAdminViewsUser> {
  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: title(
              title: 'Mantenimiento de Usuarios y Solicitades',
              fontName: 'Roboto',
              color: AppTheme.primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: title(
              fontName: 'Roboto',
              title:
                  'Con VIAPP visualiza y controla todos los usuarios, solicitudes de manera ágil y eficiente.',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppTheme.secondaryColor),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            debugPrint('PENDIENTES');
            final keyMaintenanceUserPage = GlobalHelper.genKey();
            fp.addPage(
              key: keyMaintenanceUserPage,
              content: MaintenanceUsers(
                keyPage: keyMaintenanceUserPage,
                key: keyMaintenanceUserPage,
              ),
            );
          },
          child: Card(
            elevation: 1,
            color: AppTheme.whiteFigma,
            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            child: ListTile(
                title: Text(
                  'Mantenimiento de usuarios',
                  style: GoogleFonts.roboto(
                      color: AppTheme.grey,
                      fontSize: 16,
                      height: 1,
                      fontWeight: FontWeight.w500),
                ),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                      height: 50,
                      width: 30,
                      child: SvgPicture.asset(
                        'assets/solicitud_pendiente.svg',
                        fit: BoxFit.contain,
                      )),
                ])),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            debugPrint('PENDIENTES');
            final keyMaintenanceRequestPage = GlobalHelper.genKey();
            fp.addPage(
              key: keyMaintenanceRequestPage,
              content: MaintenanceRequests(
                keyPage: keyMaintenanceRequestPage,
                key: keyMaintenanceRequestPage,
              ),
            );
          },
          child: Card(
            elevation: 1,
            color: AppTheme.whiteFigma,
            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            child: ListTile(
                title: Text(
                  'Mantenimiento de solicitudes',
                  style: GoogleFonts.roboto(
                      color: AppTheme.grey,
                      fontSize: 16,
                      height: 1,
                      fontWeight: FontWeight.w500),
                ),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                      height: 50,
                      width: 30,
                      child: SvgPicture.asset(
                        'assets/rechazado.svg',
                        fit: BoxFit.contain,
                      )),
                ])),
          ),
        ),
      ],
    );
  }
}
