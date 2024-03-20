import 'package:flutter/material.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/modules/home_page/models/my_requests_response.dart';

class MyRequestWideget extends StatelessWidget {
  final MyRequest request;
  const MyRequestWideget({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    Color color = Color(int.parse('0xFF${request.colorStatus}'));

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
                  color: Color.fromARGB(255, 214, 213,
                      213), // Cambia el color según tus necesidades
                ),
              ),
              Container(
                  height: 150,
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 11.0, left: 15),
                          child: Text(
                            request.fullName,
                            style: const TextStyle(
                              color: AppTheme.white,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 11.0, left: 15),
                          child: Text(
                            request.nameStatus,
                            style: TextStyle(
                              color: color,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                      ])),
            ],
          ),
        ));
  }
}
