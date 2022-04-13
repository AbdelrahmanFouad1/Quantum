import 'package:flutter/material.dart';
import 'package:moa/core/util/widgets/back_scaffold.dart';
import 'package:moa/core/util/widgets/hide_keyboard_page.dart';
import 'package:moa/core/util/widgets/main_scaffold.dart';
import 'package:moa/features/register_user/presentation/widgets/register_user_widget.dart';

class RegisterUserPage extends StatelessWidget {
  const RegisterUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BackScaffold(
        body: Scaffold(
          body: SafeArea(
            child: HideKeyboardPage(
              child: RegisterUserWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
