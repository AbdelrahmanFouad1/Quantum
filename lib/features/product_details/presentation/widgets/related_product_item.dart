import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/util/constants.dart';

class RelatedProductItem extends StatelessWidget {
  final String title;
  final IconData icon;
  Function? function;
  Widget? trailing;
  late bool showPhone;
  late bool sign;
  late bool showIcon;
  late bool showAssetsIcon;
  late double paddingHorizontal;
  String? imagePath;

  RelatedProductItem({
    Key? key,
    required this.title,
    required this.icon,
    this.function,
    this.trailing,
    this.showPhone = false,
    this.sign = true,
    this.showIcon = true,
    this.showAssetsIcon = false,
    this.paddingHorizontal = 14.0,
    this.imagePath ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            function!();
          },
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(showIcon)
                  Icon(icon, size: 16.0, color: secondaryVariant1,),
                if(showIcon)
                  space10Horizontal(context),
                if(showAssetsIcon)
                  SvgPicture.asset(
                    'assets/images/$imagePath.svg',
                    color: HexColor(regularGrey),
                    width: 18.0,
                  ),
                if(showAssetsIcon)
                  space10Horizontal(context),

                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                space20Horizontal(context),
                if(sign)
                  RotatedBox(
                    quarterTurns: Directionality.of(context) == TextDirection.rtl ? 2 : 0,
                    child: trailing ??
                        Icon(
                          Icons.keyboard_arrow_right,
                          size: 16.0,
                          color: HexColor(regularGrey),
                        ),
                  ),
              ],
            ),
          ),
        ),
        myDivider(context),
      ],
    );
  }
}