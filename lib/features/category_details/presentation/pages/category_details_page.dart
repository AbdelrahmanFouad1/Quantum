import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/my_indicator.dart';
import 'package:moa/features/category_details/presentation/widgets/categories_details_widget.dart';

class CategoryDetailsPage extends StatefulWidget {
  final int slug;

  const CategoryDetailsPage({
    Key? key,
    required this.slug,
  }) : super(key: key);

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCubit.get(context).oneCategory(categoryId:  widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
          AppCubit.get(context).oneCategoryModel != null,
          widgetBuilder: (context) => const CategoryDetailsWidget(),
          fallbackBuilder: (context) => const Scaffold(body: MyIndicator()),
        );
      },
    );
  }
}
