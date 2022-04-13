import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moa/core/util/widgets/home_scaffold.dart';
import 'package:moa/features/categories/presentation/widgets/categories_widget.dart';



class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeScaffold(widget: CategoriesWidget(),);
  }
}
