import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/super_admin/models/pending_requests.dart';
import 'package:viapp/modules/super_admin/services/super_admin_services.dart';
import 'package:viapp/modules/super_admin/widgets/requests_approved_widget.dart';
import 'package:viapp/shared/providers/functional_provider.dart';
import 'package:viapp/shared/widgets/layout_widget.dart';
import 'package:viapp/shared/widgets/text_button_text.dart';
import 'package:viapp/shared/widgets/title.dart';

class ReuqestsApproved extends StatefulWidget {
  const ReuqestsApproved({super.key, required this.keyPage});
  final GlobalKey<State<StatefulWidget>> keyPage;

  @override
  State<ReuqestsApproved> createState() => _ReuqestsApprovedState();
}

class _ReuqestsApprovedState extends State<ReuqestsApproved> {
  List<Request> requests = [];
  final _superAdminServices = SuperAdminServices();
  String statusRequests = '3';
  PendingRequests? pendingRequests;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getApprovedRequests(statusRequests);
    });
    super.initState();
  }

  void getApprovedRequests(String statusRequests) async {
    final response =
        await _superAdminServices.getPendingRequests(context, statusRequests);
    if (!response.error) {
      setState(() {
        pendingRequests = response.data!;
      });
    }
  }

  List<Widget> getApprovedRequestsWidget() {
    return pendingRequests!.requests
        .map<Widget>((e) => ApprovedRequestsWidget(
              request: e,
            ))
        .toList();
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
                    title: 'Solicitudes Aprobadas',
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
                        'Con VIAPP, visualiza todas las solicitudes aprobadas',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: AppTheme.secondaryColor),
              ),
              const SizedBox(
              height: 20,
            ),
              if (pendingRequests != null)
              Column(
                children: getApprovedRequestsWidget(),
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
              )
            ],
          ),
        ));
  }
}
