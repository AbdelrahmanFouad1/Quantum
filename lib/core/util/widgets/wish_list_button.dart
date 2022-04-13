import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';

import '../constants.dart';
import 'asset_svg.dart';

class WishListButton extends StatefulWidget {

  const WishListButton({Key? key}) : super(key: key);

  @override
  State<WishListButton> createState() => _WishListButtonState();
}

class _WishListButtonState extends State<WishListButton> {
  bool isWishList = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return SizedBox(
          child: IconButton(
            icon: CircleAvatar(
              radius: 20.0,
              backgroundColor: AppCubit.get(context).isDark
                  ? HexColor(secondBackground)
                  : Colors.grey[300],
              child: AssetSvg(
                color: HexColor(mainColor),
                imagePath: isWishList? 'heart_solid' : 'heart',
                size: pxToDp(14.0),
              ),
            ),
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                isWishList = !isWishList;
              });
            },
          ),
        );
      },
    );
  }
}
