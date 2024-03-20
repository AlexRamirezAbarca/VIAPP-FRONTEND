import 'package:flutter/material.dart';
import 'package:viapp/modules/profile_page/widgets/profile_page_body.dart';
import 'package:viapp/shared/widgets/layout_widget.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  // final GlobalKey<State<StatefulWidget>> keyPage;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const LayoutWidget(
      child: ProfilePageBody(),
    );
  }
}