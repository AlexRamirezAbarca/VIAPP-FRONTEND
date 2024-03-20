// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/super_admin/widgets/admin_reports.dart';
import 'package:viapp/modules/super_admin/widgets/denied_requests.dart';
import 'package:viapp/modules/super_admin/widgets/pending_request.dart';
import 'package:viapp/modules/super_admin/widgets/request_approved.dart';
import 'package:viapp/shared/helpers/global_helper.dart';
import 'package:viapp/shared/providers/functional_provider.dart';

import 'package:viapp/shared/widgets/title.dart';
import 'package:flutter_svg/svg.dart';

class SuperAdminHome extends StatefulWidget {
  const SuperAdminHome({super.key});

  @override
  State<SuperAdminHome> createState() => _SuperAdminHomeState();
}

class _SuperAdminHomeState extends State<SuperAdminHome> {
  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return ListView(
      children: [
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: title(
            title: 'Menu Principal de Solicitudes',
            fontName: 'Roboto',
            color: AppTheme.primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: title(
            fontName: 'Roboto',
            title:
                'Visualiza las solicitudes pendientes, aprobadas, rechazadas y genera un reporte general de tus solicitudes. ',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: AppTheme.secondaryColor,
          ),
        ),
        const SizedBox(height: 55),
        // Padding(
        //   padding: const EdgeInsets.only(left: 30, right: 30),
        //   child: title(
        //       fontName: 'Roboto',
        //       title:
        //           'Solicitudes Pendientes',
        //       fontWeight: FontWeight.w500,
        //       fontSize: 14,
        //       color: AppTheme.grey,
        //     ),
        // ),
        GestureDetector(
          onTap: () {
            debugPrint('PENDIENTES');
            final keyPendingRequests = GlobalHelper.genKey();
            fp.addPage(
              key: keyPendingRequests,
              content: PendingRequestsPage(
                keyPage: keyPendingRequests,
                key: keyPendingRequests,
              ),
            );
          },
          child: Card(
            elevation: 1,
            color: AppTheme.whiteFigma,
            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            child: ListTile(
                title: Text(
                  'Solicitudes Pendientes',
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
        const SizedBox(height: 25),
        // Padding(
        //   padding: const EdgeInsets.only(left: 30, right: 30),
        //   child: title(
        //       fontName: 'Roboto',
        //       title:
        //           'Solicitudes Aprobadas',
        //       fontWeight: FontWeight.w500,
        //       fontSize: 14,
        //       color:  AppTheme.grey,
        //     ),
        // ),
        GestureDetector(
          onTap: () {
            debugPrint('APROBADOS');
            final keyApprovedRequests = GlobalHelper.genKey();
            fp.addPage(
              key: keyApprovedRequests,
              content: ReuqestsApproved(
                keyPage: keyApprovedRequests,
                key: keyApprovedRequests,
              ),
            );
          },
          child: Card(
            elevation: 1,
            color: AppTheme.whiteFigma,
            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            child: ListTile(
                title: Text(
                  'Solicitudes Aprobadas',
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
                        'assets/solicitud_aprobada.svg',
                        fit: BoxFit.contain,
                      )),
                ])),
          ),
        ),
        const SizedBox(height: 25),
        // Padding(
        //   padding: const EdgeInsets.only(left: 30, right: 30),
        //   child: title(
        //       fontName: 'Roboto',
        //       title:
        //           'Solicitudes Rechazadas',
        //       fontWeight: FontWeight.w500,
        //       fontSize: 14,
        //       color:  AppTheme.grey,
        //     ),
        // ),
        GestureDetector(
          onTap: () {
            debugPrint('RECHAZADOS');
            final keyDeniedRequests = GlobalHelper.genKey();
            fp.addPage(
              key: keyDeniedRequests,
              content: DeniedRequests(
                keyPage: keyDeniedRequests,
                key: keyDeniedRequests,
              ),
            );
          },
          child: Card(
            elevation: 1,
            color: AppTheme.whiteFigma,
            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            child: ListTile(
                title: Text(
                  'Solicitudes Rechazadas',
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
        const SizedBox(height: 25),
        GestureDetector(
          onTap: () {
            debugPrint('PDF SOLICITUDES');
            final keyReportsRequests = GlobalHelper.genKey();
            fp.addPage(
              key: keyReportsRequests,
              content: ReportAdmin(
                keyPage: keyReportsRequests,
                key: keyReportsRequests,
              ),
            );
          },
          child: Card(
            elevation: 1,
            color: AppTheme.whiteFigma,
            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            child: ListTile(
                title: Text(
                  'Generar reporte de solicitudes',
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
                        'assets/generar_reporte.svg',
                        fit: BoxFit.contain,
                      )),
                ])),
          ),
        ),
      ],
    );
  }
}
