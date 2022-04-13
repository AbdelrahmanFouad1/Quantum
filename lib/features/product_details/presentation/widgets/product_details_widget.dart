import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/asset_svg.dart';
import 'package:moa/core/util/widgets/main_scaffold.dart';
import 'package:moa/core/util/widgets/my_button.dart';
import 'package:moa/core/util/widgets/two_options_dialog.dart';

class ProductDetailsWidget extends StatefulWidget {

  const ProductDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return MainScaffold(
          scaffold: Scaffold(
            body: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    systemOverlayStyle: const SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent
                        ),
                    leading: Padding(
                      padding: const EdgeInsetsDirectional.all(12.0),
                      child: CircleAvatar(
                        radius: 25.0,
                        backgroundColor: AppCubit.get(context).isDark
                            ? Theme.of(context).scaffoldBackgroundColor
                            : whiteColor,
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 16.0,
                              color: AppCubit.get(context).isDark
                                  ? HexColor(regularGrey)
                                  : HexColor(darkGreyColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    pinned: true,
                    floating: true,
                    titleSpacing: 2.0,
                    actions: [
                      Padding(
                        padding: const EdgeInsetsDirectional.all(12.0),
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundColor: AppCubit.get(context).isDark
                              ? Theme.of(context).scaffoldBackgroundColor
                              : whiteColor,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  AppCubit.get(context)
                                      .bottomChanged(2, context);


                                },
                                icon: AssetSvg(
                                  color: AppCubit.get(context).isDark
                                      ? HexColor(regularGrey)
                                      : HexColor(darkGreyColor),
                                  imagePath: 'cart',
                                  size: 16.0,
                                ),
                              ),
                              CircleAvatar(
                                radius: pxToDp(8.0),
                                backgroundColor: Colors.red,
                                child: Center(
                                  child: Text(
                                    AppCubit.get(context).cartMap.length > 9
                                        ? '+9'
                                        : AppCubit.get(context)
                                        .cartMap
                                        .length
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                      color: whiteColor,
                                      fontSize:  pxToDp(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    backgroundColor: AppCubit.get(context).isDark
                        ? Theme.of(context).scaffoldBackgroundColor
                        : whiteColor,
                    expandedHeight: pxToDp(360.0),
                    flexibleSpace: const FlexibleSpaceBar(
                      background: Image(
                        image: NetworkImage(
                          'https://img.freepik.com/free-vector/black-background-with-podium-golden-circle_1017-31891.jpg?t=st=1649273630~exp=1649274230~hmac=997c8cf9b8dcadf2bd5ab7d2f4a1b156750571842f26f5bce383545098bdc85d&w=900',
                        ),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(
                        responsiveValue(
                          context,
                          16.0,
                        ),
                      ),
                      child: Scrollbar(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              AppCubit.get(context).oneProductModel!.title,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            space30Vertical(context),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${appTranslation(context).egp} ${AppCubit.get(context).oneProductModel!.price}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                                Builder(builder: (context) {
                                  if (AppCubit.get(context)
                                          .oneProductModel!
                                          .stock ==
                                      0) {
                                    return Text(
                                      appTranslation(context).outStock,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            color: Colors.red,
                                          ),
                                    );
                                  }
                                  return Text(
                                    '${AppCubit.get(context).oneProductModel!.stock} ${appTranslation(context).inStock}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          color: HexColor(green),
                                        ),
                                  );
                                }),
                              ],
                            ),
                            space30Vertical(context),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppCubit.get(context).isDark
                                        ? HexColor(secondBackground)
                                        : HexColor(liteGreyColor),
                                    borderRadius:
                                        BorderRadiusDirectional.circular(8.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          AppCubit.get(context).subtraction();
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.minus,
                                          size: 16.0,
                                          color: HexColor(mainColor),
                                        ),
                                      ),
                                      Text(
                                        AppCubit.get(context)
                                                    .oneProductModel!
                                                    .stock ==
                                                0
                                            ? '0'
                                            : '${AppCubit.get(context).itemCount}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                              color: HexColor(mainColor),
                                            ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          AppCubit.get(context).addition();
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
                                space10Horizontal(context),

                                if (AppCubit.get(context).cartMap[AppCubit.get(context).oneProductModel!.pId] != null)
                                  Expanded(
                                    child: SizedBox(
                                      height: 46.0,
                                      child: MyButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder:
                                                  (BuildContext context) {
                                                return TwoOptionsDialog(
                                                  pushButtonVoidCallback:
                                                      () {
                                                    removeFromCart(
                                                      context: context,
                                                      id: AppCubit.get(
                                                          context)
                                                          .oneProductModel!
                                                          .pId,
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                  popButtonVoidCallback:
                                                      () {
                                                    Navigator.pop(context);
                                                  },
                                                  message:
                                                  appTranslation(context).areYouSureToRemove,
                                                  // title: 'title',
                                                  pushButtonText: appTranslation(context).remove,
                                                  popButtonText: appTranslation(context).cancel,
                                                );
                                              });
                                        },
                                        text: appTranslation(context)
                                            .removeFromCart,
                                        colorButton: HexColor(red),
                                      ),
                                    ),
                                  ),

                                if (AppCubit.get(context).cartMap[AppCubit.get(context).oneProductModel!.pId] == null)
                                Expanded(
                                  child: SizedBox(
                                    height: 46.0,
                                    child: MyButton(
                                      onPressed: () {

                                        addToCart(
                                          context: context,
                                          productModel:
                                          AppCubit.get(context)
                                              .oneProductModel!,
                                        );

                                      },
                                      text: appTranslation(context).addToCart,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            space30Vertical(context),
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: HexColor(regularGrey),
                                ),
                              ),
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: Material(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: ExpansionTile(
                                    collapsedBackgroundColor:
                                        AppCubit.get(context).isDark
                                            ? HexColor(secondBackground)
                                            : HexColor(liteGreyColor),
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    collapsedIconColor:
                                        AppCubit.get(context).isDark
                                            ? HexColor(regularGrey)
                                            : HexColor(darkGreyColor),
                                    title: Text(
                                      appTranslation(context).relatedCategories,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    children: <Align>[
                                      ...AppCubit.get(context)
                                          .oneProductModel!
                                          .categories!
                                          .map((e) => Align(
                                        alignment: AlignmentDirectional.topStart,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: responsiveValue(
                                                  context,
                                                  16.0,
                                                ),
                                              ),
                                              child: Text(
                                                    e.title,
                                                     style: Theme.of(context).textTheme.caption,
                                                  ),
                                            ),
                                          ))
                                          .toList(),
                                      // ...catList,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            space60Vertical(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        );
      },
    );
  }
}
