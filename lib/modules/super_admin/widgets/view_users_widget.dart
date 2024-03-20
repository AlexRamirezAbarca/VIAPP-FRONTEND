import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/super_admin/models/users_reponse.dart';
import 'package:viapp/shared/widgets/text_button_text.dart';

class ViewUsersWidget extends StatelessWidget {
  final void Function() onPressedEnable;
  final void Function() onPressedDisable;
  const ViewUsersWidget({super.key, required this.users,  required this.onPressedEnable, required this.onPressedDisable});
  final User users;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.whiteFigma,
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      child: ListTile(
          leading: const Icon(Icons.person_3_outlined),
          title: Text(
            '${users.firstName} ${users.lastName}',
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
              Text(users.userName,
                  style: GoogleFonts.roboto(
                      color: AppTheme.textColorAbout, fontSize: 14, height: 1)),
              const SizedBox(height: 5),
              Text(users.email,
                  style: GoogleFonts.roboto(
                      color: AppTheme.textColorAbout, fontSize: 14, height: 1)),
              const SizedBox(height: 5),
            ],
          ),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            if (users.status == 1)
              TextButtonWidget(
                  text: 'Deshabillitar',
                  onPressed: onPressedDisable,
                  size: 12,
                  textColor: AppTheme.secondaryColor,
                  fontWeight: FontWeight.bold),
            if (users.status == 0)
              TextButtonWidget(
                  text: 'Habilitar',
                  onPressed: onPressedEnable,
                  size: 12,
                  textColor: AppTheme.secondaryColor,
                  fontWeight: FontWeight.bold),
          ])),
    );
  }
}
