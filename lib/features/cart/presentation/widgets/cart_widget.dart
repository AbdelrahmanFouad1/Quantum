import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/empty_widget.dart';
import 'package:moa/core/util/widgets/my_button.dart';
import 'package:moa/features/cart/presentation/widgets/single_cart_item.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Conditional.single(
            context: context,
            conditionBuilder: (context) => AppCubit.get(context).cartMap.isNotEmpty,
            widgetBuilder: (context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ...AppCubit.get(context)
                      .cartMap
                      .map(
                        (key, value) => MapEntry(
                      key,
                      Column(
                        children: [
                          SingleCartItem(
                            cartItem: value,
                          ),
                          myDivider(context),
                        ],
                      ),
                    ),
                  )
                      .values
                      .toList(),



                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              appTranslation(context).total,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${appTranslation(context).egp} ${AppCubit.get(context).subtotalCart}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                fontWeight: FontWeight.w700,
                                color: HexColor(secondaryVariantDark),
                              ),
                            ),
                          ],
                        ),

                        space20Vertical(context),
                        MyButton(
                          onPressed: () {

                          },
                          text: appTranslation(context).checkout,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            fallbackBuilder: (context) => EmptyWidget(text: appTranslation(context).addSomeProductsToCart),
        );
      },
    );
  }
}
