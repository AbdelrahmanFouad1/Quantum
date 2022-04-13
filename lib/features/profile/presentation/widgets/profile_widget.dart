import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/di/injection.dart';
import 'package:moa/core/network/local/cache_helper.dart';
import 'package:moa/core/network/remote/api_endpoints.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/logo.dart';
import 'package:moa/core/util/widgets/two_options_dialog.dart';
import 'package:moa/features/login/presentation/pages/login_page.dart';
import 'package:moa/features/profile/presentation/widgets/profile_item.dart';
import 'package:moa/features/profile/presentation/widgets/selected_language_item.dart';
import 'selected_theme_item.dart';


class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).userInfo();



  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is UserLogoutSuccess) {
          sl<CacheHelper>().clear('token').then((value) {
            if (value) {
              token = null;
              Fluttertoast.showToast(
                msg: state.message.toString(),
              );
              navigateAndFinish(context, const LoginPage());
            }
          });
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 27.0,
                      backgroundColor: HexColor(regularGrey),
                      child: CircleAvatar(
                        radius: 25.0,
                        backgroundColor:
                        Theme
                            .of(context)
                            .scaffoldBackgroundColor,
                        child: const AppLogo(),
                      ),
                    ),
                    space15Horizontal(context),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // AppCubit
                            //     .get(context)
                            //     .userModel != null ? AppCubit
                            //     .get(context)
                            //     .userModel!
                            //     .name : '',
                             userName ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          space3Vertical(context),
                          Text(
                            // AppCubit
                            //     .get(context)
                            //     .userModel != null ? AppCubit
                            //     .get(context)
                            //     .userModel!
                            //     .email : '',
                              userEmail ?? '',
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bigDivider(context),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        appTranslation(context).setting,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline6,
                      ),
                    ),
                    space3Vertical(context),

                    SettingsItem(
                      title: appTranslation(context).darkMode,
                      icon: FontAwesomeIcons.adjust,
                      function: () {
                        myBottomSheet(
                          context: context,
                          widget: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                child: SelectedThemeItem(
                                  icon: FontAwesomeIcons.sun,
                                  title: appTranslation(context)
                                      .lightMode,
                                ),
                                onTap: () {
                                  AppCubit.get(context)
                                      .changeMode(value: false);
                                  Navigator.pop(context);
                                },
                              ),
                              const MyDivider(),
                              InkWell(
                                child: SelectedThemeItem(
                                  icon: FontAwesomeIcons.moon,
                                  title: appTranslation(context)
                                      .darkMode,
                                ),
                                onTap: () {
                                  AppCubit.get(context)
                                      .changeMode(value: true);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      paddingHorizontal: 20.0,
                      showIcon: true,
                    ),


                    SettingsItem(
                      title: appTranslation(context).changeLanguage,
                      icon: Icons.logout,
                      function: () {
                        myBottomSheet(
                          context: context,
                          widget: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                child: SelectedLanguageItem(
                                  icon: 'En',
                                  title: appTranslation(context)
                                      .english,
                                ),
                                onTap: () {
                                  AppCubit.get(context)
                                      .changeLanguage(value: false);
                                  Navigator.pop(context);
                                },
                              ),
                              const MyDivider(),
                              InkWell(
                                child: SelectedLanguageItem(
                                  icon: 'Ar',
                                  title: appTranslation(context)
                                      .arabic,
                                ),
                                onTap: () {
                                  AppCubit.get(context)
                                      .changeLanguage(value: true);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      paddingHorizontal: 20.0,
                      showIcon: false,
                      showAssetsIcon: true,
                      imagePath: 'language',
                    ),


                    SettingsItem(
                      title: appTranslation(context).aboutUs,
                      icon: Icons.logout,
                      function: () {},
                      paddingHorizontal: 20.0,
                      showIcon: false,
                      showAssetsIcon: true,
                      imagePath: 'info',
                    ),

                    SettingsItem(
                      title: appTranslation(context).contactUs,
                      icon: Icons.logout,
                      function: () {

                      },
                      paddingHorizontal: 20.0,
                      showIcon: false,
                      showAssetsIcon: true,
                      imagePath: 'contact_us',
                    ),

                    SettingsItem(
                      title: appTranslation(context).faq,
                      function: () {

                      },
                      icon: FontAwesomeIcons.solidQuestionCircle,
                      showIcon: false,
                      paddingHorizontal: 20.0,
                      showAssetsIcon: true,
                      imagePath: 'faq',
                    ),

                    SettingsItem(
                      title: appTranslation(context).logout,
                      function: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return  TwoOptionsDialog(
                                message: appTranslation(context).logoutConfirmation,
                                popButtonText: appTranslation(context).cancel,
                                pushButtonText:  appTranslation(context).yes,
                                pushButtonVoidCallback: (){
                                  // AppCubit.get(context).userLogout();
                                  AppCubit.get(context).signOut(context);
                                },
                                popButtonVoidCallback: (){
                                  Navigator.pop(context);
                                },
                              );
                            });
                      },
                      showIcon: false,
                      showAssetsIcon: true,
                      paddingHorizontal: 20.0,
                      imagePath: 'sign_out',
                      icon: FontAwesomeIcons.solidQuestionCircle,
                    ),

                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
