import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/logo.dart';
import 'package:moa/core/util/widgets/my_button.dart';
import 'package:moa/core/util/widgets/my_form.dart';
import 'package:moa/features/login/presentation/pages/login_page.dart';
import '../../../../core/models/select_government_model.dart';
import '../../../main/presentation/pages/main_page.dart';

class RegisterUserWidget extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  RegisterUserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is UserRegisterError) {
          Fluttertoast.showToast(msg: state.message);
        }

        if (state is UserRegisterSuccess) {
          navigateAndFinish(context, const LoginPage());
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsiveValue(
              context,
              16.0,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Column(
                        children: [
                          const AppLogo(),
                          Text(
                            appTranslation(context).registerUserHead,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                    space40Vertical(context),
                    MyForm(
                      isPassword: false,
                      type: TextInputType.name,
                      error: appTranslation(context).fullNameError,
                      controller:
                          AppCubit.get(context).registerUserFullNameController,
                      label: appTranslation(context).fullName,
                    ),
                    space8Vertical(context),
                    MyForm(
                      isPassword: false,
                      type: TextInputType.phone,
                      error: appTranslation(context).mobileNumberError,
                      controller:
                          AppCubit.get(context).registerUserMobileController,
                      label: appTranslation(context).mobileNumber,
                    ),
                    space8Vertical(context),
                    MyForm(
                      isPassword: false,
                      type: TextInputType.text,
                      error: appTranslation(context).addressError,
                      controller:
                          AppCubit.get(context).registerUserAddressController,
                      label: appTranslation(context).address,
                    ),
                    space8Vertical(context),
                    MyForm(
                      isPassword: false,
                      type: TextInputType.emailAddress,
                      error: appTranslation(context).emailAddressError,
                      controller: AppCubit.get(context)
                          .registerUserEmailAddressController,
                      label: appTranslation(context).emailAddress,
                    ),
                    space8Vertical(context),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appTranslation(context).government,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        space8Vertical(context),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ),
                            border: Border.all(
                              color: HexColor(darkGreyColor),
                              width: 1.0,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: responsiveValue(
                              context,
                              16.0,
                            ),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: AppCubit.get(context).isDark
                                  ? HexColor(scaffoldBackgroundDark)
                                  : HexColor(regularGrey),
                            ),
                            child: DropdownButton<SelectGovernmentModel>(
                              value: AppCubit.get(context).selectedGovernment,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    color: AppCubit.get(context).isDark
                                        ? HexColor(regularGrey)
                                        : HexColor(mainColor),
                                  ),
                              onChanged: (SelectGovernmentModel? newValue) {
                                AppCubit.get(context).changeSelectedGovernment(
                                  value: newValue!,
                                );
                              },
                              isExpanded: true,
                              underline: Container(),
                              items: cities
                                  .map<DropdownMenuItem<SelectGovernmentModel>>(
                                (SelectGovernmentModel value) {
                                  return DropdownMenuItem<
                                      SelectGovernmentModel>(
                                    value: value,
                                    child: Text(
                                      displayTranslatedText(
                                        context: context,
                                        ar: value.titleAr,
                                        en: value.titleEn,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    space8Vertical(context),
                    MyForm(
                      isPassword: true,
                      type: TextInputType.visiblePassword,
                      error: appTranslation(context).passwordError,
                      controller:
                          AppCubit.get(context).registerUserPasswordController,
                      label: appTranslation(context).password,
                    ),
                    space8Vertical(context),
                    MyForm(
                      isPassword: true,
                      type: TextInputType.visiblePassword,
                      error: appTranslation(context).confirmPasswordError,
                      controller: AppCubit.get(context)
                          .registerUserConfirmPasswordController,
                      label: appTranslation(context).confirmPassword,
                    ),
                    space40Vertical(context),
                    MyButton(
                      isLoading: state is UserRegisterLoading,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          navigateAndFinish(context, const MainPage());
                        }
                      },
                      text: appTranslation(context).registerNow,
                    ),

                    space40Vertical(context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
