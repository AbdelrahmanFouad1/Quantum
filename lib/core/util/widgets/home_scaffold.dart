import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/widgets/logo.dart';

import 'main_scaffold.dart';
import 'my_theme_icon.dart';

class HomeScaffold extends StatelessWidget {
  final Widget widget;
  const HomeScaffold({Key? key
  ,required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return MainScaffold(
      scaffold: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                // scaffoldKey.currentState!.openDrawer();
              },
              icon:AppCubit.get(context).isRtl?  Transform.rotate(
                angle: 180 * pi / 180,
                child: const MyThemeIcon(
                  path: 'menu',
                ),
              ) :  const MyThemeIcon(
                path: 'menu',
              ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                },
                icon: const MyThemeIcon(
                  path: 'search',
                ),),
          ],
          centerTitle: false,
          titleSpacing: 20.0,
        ),
        body: widget,
        drawer: const Drawer(),
      ),
    );
  }
}
