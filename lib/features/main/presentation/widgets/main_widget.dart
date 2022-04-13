import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/custom_delegate.dart';
import 'package:moa/core/util/widgets/my_indicator.dart';
import 'package:moa/features/main/presentation/widgets/products_list_item.dart';
import 'package:moa/features/main/presentation/widgets/slider.dart';
import '../../../../core/util/constants.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsiveValue(
              context,
              6.0,
            ),
          ),
          child: Conditional.single(
              context: context,
              conditionBuilder: (context) => AppCubit.get(context).productsModel.isNotEmpty,
              widgetBuilder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SliderWidget(),
                    space20Vertical(context),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsiveValue(
                          context,
                          10.0,
                        ),
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => ProductListItem(
                            products: AppCubit.get(context).productsModel[index],
                          ),

                          itemCount: AppCubit.get(context).productsModel.length,
                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 8.0,
                          height: 280.0,
                        ),
                      ),
                    ),
                    space80Vertical(context),
                  ],
                ),
              ),
              fallbackBuilder: (context) => const MyIndicator(),
          ),
        );
      },
    );
  }
}

