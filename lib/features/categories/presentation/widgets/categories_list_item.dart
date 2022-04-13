import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/models/categories_model.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/features/category_details/presentation/pages/category_details_page.dart';

class CategoriesListItem extends StatelessWidget {
  final CategoriesModel categories;

  const CategoriesListItem({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            navigateTo(
              context,
              CategoryDetailsPage(
                slug: categories.cId,
              ),
            );
          },
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            height: 240.0,
            decoration: BoxDecoration(
              color: AppCubit.get(context).isDark
                  ? HexColor(secondBackground)
                  : whiteColor,
              border: Border.all(
                color: HexColor(regularGrey),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(
                          8.0,
                        ),
                        topEnd: Radius.circular(
                          8.0,
                        ),
                      ),
                    ),
                    child: const Image(
                      image: NetworkImage(
                        'https://img.freepik.com/free-vector/black-background-with-podium-golden-circle_1017-31891.jpg?t=st=1649273630~exp=1649274230~hmac=997c8cf9b8dcadf2bd5ab7d2f4a1b156750571842f26f5bce383545098bdc85d&w=900',
                      ),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categories.title,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
