import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moa/core/util/widgets/home_scaffold.dart';
import 'package:moa/features/profile/presentation/widgets/profile_widget.dart';



class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeScaffold(widget: ProfileWidget(),);
  }
}
