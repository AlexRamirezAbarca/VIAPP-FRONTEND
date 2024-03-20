import 'package:flutter/material.dart';
import 'package:viapp/modules/login_page/widgets/login_page_body.dart';
import 'package:viapp/shared/widgets/alert_modal.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          LoginPageBody(),
          AlertModal(),
        ],
      ),
    );
  }
}
