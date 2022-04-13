import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/util/constants.dart';

class SelectedThemeItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const SelectedThemeItem({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
           Icon(
              icon,
             size: pxToDp(16.0),
             color: HexColor(secondaryVariant),
          ),
          space10Horizontal(context),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
