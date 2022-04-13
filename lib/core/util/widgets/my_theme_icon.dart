import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/asset_svg.dart';

import '../constants.dart';

class MyThemeIcon extends StatelessWidget {
  final String path;
  final String lightColor;
  final String darkColor;

  const MyThemeIcon({
    Key? key,
    this.lightColor = mainColor,
    this.darkColor = regularGrey,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return AssetSvg(
          color: AppCubit.get(context).isDark ? HexColor(darkColor) : HexColor(lightColor),
          imagePath: path,
        );
      },
    );
  }
}