import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/back_scaffold.dart';
import 'package:moa/core/util/widgets/custom_delegate.dart';
import 'package:moa/core/util/widgets/empty_widget.dart';
import 'package:moa/core/util/widgets/main_scaffold.dart';
import 'package:moa/features/main/presentation/widgets/products_list_item.dart';

class CategoryDetailsWidget extends StatefulWidget {
  const CategoryDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryDetailsWidget> createState() => _CategoryDetailsWidgetState();
}

class _CategoryDetailsWidgetState extends State<CategoryDetailsWidget> {
  bool isGrade = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return MainScaffold(
          scaffold: BackScaffold(
              body: Scaffold(
            body: Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  AppCubit.get(context).oneCategoryModel!.products!.isNotEmpty,
              widgetBuilder: (context) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsiveValue(
                    context,
                    16.0,
                  ),
                ),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => ProductListItem(
                    products: AppCubit.get(context)
                        .oneCategoryModel!
                        .products![index],
                  ),
                  itemCount:
                      AppCubit.get(context).oneCategoryModel!.products!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                    crossAxisCount: isGrade? 2 : 1,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 8.0,
                    height: 280.0,
                  ),
                ),
              ),
              fallbackBuilder: (context) => EmptyWidget(
                text: appTranslation(context).thereNoProducts,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  isGrade = !isGrade;
                });
              },
              backgroundColor: HexColor(mainColor),
              child: Icon(
                isGrade? Icons.list : Icons.grid_view,
              ),
            ),
          )),
        );
      },
    );
  }
}
