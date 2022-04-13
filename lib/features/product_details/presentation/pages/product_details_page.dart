import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/my_indicator.dart';
import 'package:moa/features/product_details/presentation/widgets/product_details_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  final int slug;

  const ProductDetailsPage({
    Key? key,
    required this.slug,
  }) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).oneProduct(productId: widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              AppCubit.get(context).oneProductModel != null,
          widgetBuilder: (context) => ProductDetailsWidget(),
          fallbackBuilder: (context) => const Scaffold(body: MyIndicator()),
        );
      },
    );
  }
}
