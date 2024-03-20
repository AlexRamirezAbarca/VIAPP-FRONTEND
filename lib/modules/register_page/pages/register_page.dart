import 'package:flutter/material.dart';
import 'package:viapp/modules/register_page/widgets/register_page_body.dart';

class RegisterPage extends StatefulWidget {
 
  const RegisterPage({super.key, required this.keyPage});
  final GlobalKey<State<StatefulWidget>> keyPage;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: RegisterPageBody(keyPage: widget.keyPage));
  }
}