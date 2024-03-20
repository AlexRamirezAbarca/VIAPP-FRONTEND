import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/super_admin/services/super_admin_services.dart';
import 'package:viapp/shared/helpers/global_helper.dart';
import 'package:viapp/shared/providers/functional_provider.dart';
import 'package:viapp/shared/widgets/alerts_template.dart';
import 'package:viapp/shared/widgets/filled_button.dart';
import 'package:viapp/shared/widgets/layout_widget.dart';
import 'package:viapp/shared/widgets/text_button_text.dart';
import 'package:viapp/shared/widgets/title.dart';

class ReportAdmin extends StatefulWidget {
  const ReportAdmin({super.key, required this.keyPage});
  final GlobalKey<State<StatefulWidget>> keyPage;

  @override
  State<ReportAdmin> createState() => _ReportAdminState();
}

class _ReportAdminState extends State<ReportAdmin> {

  final _superAdminServices =  SuperAdminServices();
  
  void getReportsRequests () async{ 
    final successReportsRequests = GlobalHelper.genKey();
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final response = await _superAdminServices.getReportsRequests(context);
    if (!response.error) {
      fp.showAlert(
        key: successReportsRequests,
        content: AlertGeneric(
          content: SuccessInformation(
            keyToClose: successReportsRequests,
            message: response.message,
            onPressed: () {
              fp.dismissAlert(key: successReportsRequests);
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: title(
                title: 'Reporte de Solicitudes',
                fontName: 'Roboto',
                color: AppTheme.primaryColor,
                fontSize: 30,
                fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: title(
                fontName: 'Roboto',
                title:
                    'Con VIAPP, genera facilmente el reporte de todas las solicitudes recibidas.',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppTheme.secondaryColor),
          ),
          const SizedBox(height: 130),
          Center(child: SvgPicture.asset('assets/pdf.svg', height: 200,)),
          const SizedBox(height: 70),
          Center(
            child: FilledButtonWidget(
              color: AppTheme.primaryColor,
              text: 'Generar reporte',
              width: 120,
              onPressed: (){
                getReportsRequests();
              },
            ),
          ),
          const SizedBox(height: 25),
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
    );
  }
}
