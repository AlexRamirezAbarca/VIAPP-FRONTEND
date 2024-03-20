import 'package:flutter/material.dart';
import 'package:viapp/modules/change_password_page/widgets/change_password_body.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key, required this.keyPage, required this.username});
  final GlobalKey<State<StatefulWidget>> keyPage;
  final String username;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangePasswordBody(keyPage: widget.keyPage, username: widget.username),
    );
  }
}