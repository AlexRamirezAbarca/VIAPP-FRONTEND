import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/home_page/models/requests_response.dart';
import 'package:viapp/shared/providers/functional_provider.dart';
import 'package:viapp/modules/request_page/widgets/layaout_request_widget.dart';

import '../../../shared/helpers/global_helper.dart';

class RequestsWideget extends StatelessWidget {
  final Request request;
  const RequestsWideget({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(2),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 175,
              width: 400,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: AppTheme
                    .designLine, // Cambia el color según tus necesidades
              ),
            ),
            Container(
              height: 200,
              width: 400,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                color: AppTheme
                    .primaryColor, // Cambia el color según tus necesidades
              ),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 11.0, left: 15),
                    child: Text(
                      request.nameRequest,
                      style: const TextStyle(
                        color: AppTheme.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      //textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 11.0, left: 15),
                    child: Text(
                      request.descriptionRequest,
                      style: const TextStyle(
                        color: AppTheme.white,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top : 20),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          final keyPageRequest = GlobalHelper.genKey();
                          fp.addPage(
                                    key: keyPageRequest,
                                    content: LayoutRequestWidget(
                                      keyPage: keyPageRequest,
                                      key: keyPageRequest,
                                      requestCode: request.id,
                                      descriptionRequest: request.descriptionRequest,
                                      nameRequest: request.nameRequest,
                                    ),
                                  );
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors
                                .white, // Cambia el color según tus necesidades
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            minimumSize: const Size(110, 25)),
                        child: const Text(
                          'Ver más',
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 50, 55, 56), // Cambia el color según tus necesidades
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}