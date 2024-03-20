import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/super_admin/models/pending_requests.dart';
import 'package:viapp/shared/widgets/text_button_text.dart';

class PendingRequestsWidget extends StatelessWidget {
  final Request request;
  final void Function() onPressedAccept;
  final void Function() onPressedDenied;
  const PendingRequestsWidget({super.key, required this.request, required this.onPressedAccept, required this.onPressedDenied});

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
                    color: AppTheme.secondaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppTheme.secondaryColor,
                    fontSize: 14,
                    height: 1)),
            const SizedBox(height: 5),
          ],
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButtonWidget(
                text: 'Aprobar',
                onPressed: onPressedAccept,
                size: 12,
                textColor: AppTheme.secondaryColor,
                fontWeight: FontWeight.bold),
            const SizedBox(height: 22),
            TextButtonWidget(
                text: 'Rechazar',
                onPressed: onPressedDenied,
                size: 12,
                textColor: AppTheme.secondaryColor,
                fontWeight: FontWeight.bold),
          ],
        ),
      ),
    );
  }
}
