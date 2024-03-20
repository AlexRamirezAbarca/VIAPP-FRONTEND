import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:viapp/env/theme/app_theme.dart';
// import 'package:viapp/shared/providers/functional_provider.dart';
import 'package:viapp/shared/widgets/layout_widget.dart';
import 'package:viapp/shared/widgets/title.dart';

class MaintenanceRequests extends StatefulWidget {
  const MaintenanceRequests({super.key, required this.keyPage});
   final GlobalKey<State<StatefulWidget>> keyPage;

  @override
  State<MaintenanceRequests> createState() => _MaintenanceRequestsState();
}

class _MaintenanceRequestsState extends State<MaintenanceRequests> {
  @override
  Widget build(BuildContext context) {
    // final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return LayoutWidget(
      requiredStack: false,
      child: SingleChildScrollView(
        child: Column (
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: title(
                  title: 'Mantenimiento de solicitudes',
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
                      'Con VIAPP, habilita y deshabilita las solicitudes de tu empresa.',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: AppTheme.secondaryColor),
            ),
          ],
          )
      ),
    );
  }
}