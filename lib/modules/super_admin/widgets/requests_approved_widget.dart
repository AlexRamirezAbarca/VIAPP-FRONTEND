import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/super_admin/models/pending_requests.dart';

class ApprovedRequestsWidget extends StatelessWidget {
  const ApprovedRequestsWidget({super.key, required this.request});
  final Request request;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.whiteFigma,
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      child: ListTile(
        title: Text(
          request.nameRequest,
          style: GoogleFonts.roboto(
              color: AppTheme.primaryColor,
              fontSize: 16,
              height: 1,
              fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(request.fullName,
                style: GoogleFonts.roboto(
                    color: AppTheme.textColorAbout, fontSize: 14, height: 1)),
            const SizedBox(height: 5),
            Text(request.code,
                style: GoogleFonts.roboto(
                    color: AppTheme.textColorAbout, fontSize: 14, height: 1)),
            const SizedBox(height: 5),
            Text(request.nameStatus,
                style: GoogleFonts.roboto(
                    color: Colors.green,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.green,
                    fontSize: 14,
                    height: 1)),
            const SizedBox(height: 5),
          ],
          
        ),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                      height: 50,
                      width: 30,
                      child: SvgPicture.asset(
                        'assets/solicitud_aprobada.svg',
                        fit: BoxFit.contain,
                      )),
                ])
      ),
    );
  }
}