import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:viapp/modules/about_page/widgets/about_page_body.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return const AboutPageBody();
  }
}