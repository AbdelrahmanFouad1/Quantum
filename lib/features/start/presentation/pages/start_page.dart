import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/asset_svg.dart';
import 'package:moa/core/util/widgets/main_scaffold.dart';
import 'package:moa/features/cart/presentation/pages/cart_page.dart';
import 'package:moa/features/categories/presentation/pages/categories_page.dart';
import 'package:moa/features/main/presentation/pages/main_page.dart';
import 'package:moa/features/profile/presentation/pages/profile_page.dart';


class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: Scaffold(
        body: PageView(
          controller: AppCubit.get(context).pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            MainPage(),
            CategoriesPage(),
            CartPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              onTap: (int index) {
                AppCubit.get(context).bottomChanged(index, context);
              },
              elevation: 20.0,
              unselectedLabelStyle: TextStyle(
                color: HexColor(regularGrey),
                height: 1.7,
              ),
              selectedLabelStyle: const TextStyle(
                height: 1.7,
              ),
              currentIndex: AppCubit.get(context).currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon:  Padding(
                    padding: const EdgeInsets.only(
                      top: 6.0,
                    ),
                    child: AssetSvg(
                      color: AppCubit.get(context).currentIndex == 0
                          ? HexColor(mainColor)
                          : HexColor(darkGreyColor),
                      imagePath: 'home',
                    ),
                  ),
                  label: appTranslation(context).home,
                ),
                BottomNavigationBarItem(
                  icon:  Padding(
                    padding: const EdgeInsets.only(
                      top: 6.0,
                    ),
                    child: AssetSvg(
                      color: AppCubit.get(context).currentIndex == 1
                          ? HexColor(mainColor)
                          : HexColor(darkGreyColor),
                      imagePath: 'categories',
                    ),
                  ),
                  label: appTranslation(context).categories,
                ),
                BottomNavigationBarItem(
                  icon:  Padding(
                    padding: const EdgeInsets.only(
                      top: 6.0,
                    ),
                    child: AssetSvg(
                      color: AppCubit.get(context).currentIndex == 2
                          ? HexColor(mainColor)
                          : HexColor(darkGreyColor),
                      imagePath: 'cart',
                    ),
                  ),
                  label: appTranslation(context).cart,
                ),
                BottomNavigationBarItem(
                  icon:  Padding(
                    padding: const EdgeInsets.only(
                      top: 6.0,
                    ),
                    child: AssetSvg(
                      color: AppCubit.get(context).currentIndex == 3
                          ? HexColor(mainColor)
                          : HexColor(darkGreyColor),
                      imagePath: 'user_nav',
                    ),
                  ),
                  label: appTranslation(context).profile,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
