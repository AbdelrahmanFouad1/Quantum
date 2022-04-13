import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/custom_delegate.dart';
import 'package:moa/features/categories/presentation/widgets/categories_list_item.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsiveValue(
                context,
                16.0,
              ),
            ),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => CategoriesListItem(
                categories: AppCubit.get(context).categoriesModel[index],
              ),
              separatorBuilder: (context, index) => space10Vertical(context),
              itemCount: AppCubit.get(context).categoriesModel.length,
            )

            );
      },
    );
  }
}
