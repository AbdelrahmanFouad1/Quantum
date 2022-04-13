import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/models/cart_model.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/widgets/two_options_dialog.dart';

class SingleCartItem extends StatefulWidget {
  final CartModel cartItem;

  const SingleCartItem({Key? key, required this.cartItem}) : super(key: key);

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        responsiveValue(
          context,
          16.0,
        ),
      ),
      child: SizedBox(
        child: InkWell(
          onTap: () {
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0.0,
              vertical: 0.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 140.0,
                      width: 140.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://img.freepik.com/free-vector/black-background-with-podium-golden-circle_1017-31891.jpg?t=st=1649273630~exp=1649274230~hmac=997c8cf9b8dcadf2bd5ab7d2f4a1b156750571842f26f5bce383545098bdc85d&w=900',
                          ),
                          fit: BoxFit.fill,
                        ),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
                space10Horizontal(context),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cartItem.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!,
                      ),
                      space5Vertical(context),
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            widget.cartItem.price.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                              color: HexColor(mainColor),
                            ),
                          ),
                          space3Horizontal(context),
                          Text(
                            appTranslation(context).egp,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                              color: HexColor(mainColor),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${appTranslation(context).total}: ${(widget.cartItem.price * widget.cartItem.quantity)} ${appTranslation(context).egp}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                color: HexColor(mainColor),
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),
                      space10Vertical(context),
                      SizedBox(
                        height: 40.0,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppCubit.get(context).isDark
                                    ? HexColor(secondBackground)
                                    : Colors.grey[300],
                                borderRadius:
                                    BorderRadiusDirectional.circular(8.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).cartSubtraction(
                                        id: widget.cartItem.pId,
                                      );
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.minus,
                                      size: 16.0,
                                      color: HexColor(mainColor),
                                    ),
                                  ),
                                  Text(
                                    widget.cartItem.quantity.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                          color: HexColor(mainColor),
                                        ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).cartAddition(
                                        id: widget.cartItem.pId,
                                      );
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.plus,
                                      size: 16.0,
                                      color: HexColor(mainColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 40.0,
                              width: 40.0,
                              child: IconButton(
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: AppCubit.get(context).isDark
                                      ? HexColor(secondBackground)
                                      : Colors.grey[300],
                                  child: Icon(
                                    FontAwesomeIcons.trashAlt,
                                    size: 16.0,
                                    color: HexColor(mainColor),
                                  ),
                                ),
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return TwoOptionsDialog(
                                          pushButtonVoidCallback: () {
                                            removeFromCart(
                                              context: context,
                                              id: widget.cartItem.pId,
                                            );
                                            Navigator.pop(context);
                                          },
                                          popButtonVoidCallback: () {
                                            Navigator.pop(context);
                                          },
                                          message: appTranslation(context).areYouSureToRemove,
                                          pushButtonText: appTranslation(context).remove,
                                          popButtonText: appTranslation(context).cancel,
                                        );
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
