import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
import 'package:moa/features/register_user/presentation/pages/register_user_page.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/network/remote/api_endpoints.dart';
import '../../../start/presentation/pages/start_page.dart';

class LoginWidget extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is UserLoginError) {
          Fluttertoast.showToast(
            msg: state.message.toString(),
          );
        }

        if(state is UserLoginSuccess) {
          sl<CacheHelper>().put('token', state.token);
          token = state.token;
          navigateAndFinish(context, const StartPage());
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: responsiveValue(context, 16.0,),),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     TextButton(
                  //       onPressed: () {
                  //         myBottomSheet(
                  //           context: context,
                  //           widget: Column(
                  //             crossAxisAlignment:
                  //             CrossAxisAlignment.start,
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               InkWell(
                  //                 child: SelectedLanguageItem(
                  //                   icon: 'En',
                  //                   title: appTranslation(context)
                  //                       .english,
                  //                 ),
                  //                 onTap: () {
                  //                   AppCubit.get(context)
                  //                       .changeLanguage(value: false);
                  //                   Navigator.pop(context);
                  //                 },
                  //               ),
                  //               const MyDivider(),
                  //               InkWell(
                  //                 child: SelectedLanguageItem(
                  //                   icon: 'Ar',
                  //                   title: appTranslation(context)
                  //                       .arabic,
                  //                 ),
                  //                 onTap: () {
                  //                   AppCubit.get(context)
                  //                       .changeLanguage(value: true);
                  //                   Navigator.pop(context);
                  //                 },
                  //               ),
                  //             ],
                  //           ),
                  //         );
                  //
                  //       },
                  //       child: Text(
                  //         appTranslation(context).changeLanguage,
                  //         maxLines: 1,
                  //         overflow: TextOverflow.ellipsis,
                  //         style:
                  //         Theme
                  //             .of(context)
                  //             .textTheme
                  //             .bodyText2!
                  //             .copyWith(
                  //           color: HexColor(mainColor),
                  //           fontSize: pxToDp(8.0),
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       height: pxToDp(12.0),
                  //       width: 1.0,
                  //       color: AppCubit
                  //           .get(context)
                  //           .isDark
                  //           ? HexColor(secondaryDark)
                  //           : HexColor(secondary),
                  //     ),
                  //     TextButton(
                  //       onPressed: () {
                  //         myBottomSheet(
                  //             context: context,
                  //             widget: Column(
                  //               crossAxisAlignment:
                  //               CrossAxisAlignment.start,
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: [
                  //                 InkWell(
                  //                   child: SelectedThemeItem(
                  //                     icon: FontAwesomeIcons.sun,
                  //                     title: appTranslation(context)
                  //                         .lightMode,
                  //                   ),
                  //                   onTap: () {
                  //                     AppCubit.get(context)
                  //                         .changeMode(value: false);
                  //                     Navigator.pop(context);
                  //                   },
                  //                 ),
                  //                 const MyDivider(),
                  //                 InkWell(
                  //                   child: SelectedThemeItem(
                  //                     icon: FontAwesomeIcons.moon,
                  //                     title: appTranslation(context)
                  //                         .darkMode,
                  //                   ),
                  //                   onTap: () {
                  //                     AppCubit.get(context)
                  //                         .changeMode(value: true);
                  //                     Navigator.pop(context);
                  //                   },
                  //                 ),
                  //               ],
                  //             ),
                  //         );
                  //
                  //       },
                  //       child: Text(
                  //         appTranslation(context).changeTheme,
                  //         maxLines: 1,
                  //         overflow: TextOverflow.ellipsis,
                  //         style:
                  //         Theme
                  //             .of(context)
                  //             .textTheme
                  //             .bodyText2!
                  //             .copyWith(
                  //           color: HexColor(mainColor),
                  //           fontSize: pxToDp(8.0),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // space40Vertical(context),
                  const Align(
                    alignment: AlignmentDirectional.center,
                    child: AppLogo(),
                  ),
                  space40Vertical(context),
                  Text(
                    appTranslation(context).loginHead,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6,
                  ),
                  space40Vertical(context),
                  MyForm(
                    isPassword: false,
                    type: TextInputType.emailAddress,
                    error: appTranslation(context).emailAddressError,
                    controller: AppCubit
                        .get(context)
                        .loginEmailController,
                    label: appTranslation(context).emailAddress,
                  ),
                  space8Vertical(context),
                  MyForm(
                    isPassword: true,
                    type: TextInputType.visiblePassword,
                    error: appTranslation(context).passwordError,
                    controller: AppCubit
                        .get(context)
                        .loginPasswordController,
                    label: appTranslation(context).password,
                  ),
                  space40Vertical(context),
                  MyButton(
                    isLoading: state is UserLoginLoading,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        AppCubit.get(context).userLogin();
                      }
                    },
                    text: appTranslation(context).loginHead,
                  ),
                  space10Vertical(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        appTranslation(context).donNotHaveAccount,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
                          color: AppCubit
                              .get(context)
                              .isDark
                              ? HexColor(secondaryDark)
                              : HexColor(secondary),
                          fontSize: pxToDp(13.0),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          navigateTo(context, const RegisterUserPage());
                        },
                        child: Text(
                          appTranslation(context).registerNow,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                          Theme
                              .of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                            color: HexColor(mainColor),
                            fontSize: pxToDp(13.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  space10Vertical(context),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {
                  //         AppCubit.get(context).signInWithGoogle().then((value) {
                  //           navigateTo(context, const StartPage());
                  //         });
                  //       },
                  //       icon: const Icon(
                  //           FontAwesomeIcons.google
                  //       ),
                  //     ),
                  //     space10Horizontal(context),
                  //     IconButton(
                  //       onPressed: () {},
                  //       icon: const Icon(
                  //           FontAwesomeIcons.facebook
                  //       ),
                  //     ),
                  //     space10Horizontal(context),
                  //     IconButton(
                  //       onPressed: () {},
                  //       icon: const Icon(
                  //           FontAwesomeIcons.twitter
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
