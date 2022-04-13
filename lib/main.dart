import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moa/core/di/injection.dart' as di;
import 'package:moa/core/di/injection.dart';
import 'package:moa/core/models/cart_model.dart';
import 'package:moa/core/util/bloc_observer.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/features/login/presentation/pages/login_page.dart';

import 'core/network/local/cache_helper.dart';
import 'core/network/remote/api_endpoints.dart';
import 'core/util/constants.dart';
import 'features/start/presentation/pages/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp();

  await di.init();


  bool isRtl = true;

  await sl<CacheHelper>().get('isRtl').then((value) {
    debugPrint('trl ------------- $value');
    if (value != null) {
      isRtl = value;
    }
  });

  bool isDark = false;


  await sl<CacheHelper>().get('isDark').then((value) {
    debugPrint('dark mode ------------- $value');
    if (value != null) {
      isDark = value;
    }
  });

  sl<CacheHelper>().get('cart').then((value) {
    debugPrint('cart ---------------------------- $value');

    if(value != null) {
      cartListData = MainCartModel.fromJson(value).data;

    }
  });

  sl<CacheHelper>().get('userName').then((value) {
    debugPrint('userName ---------------------------- $value');
    if(value != null) {
      userName = value;

    }
  });

  sl<CacheHelper>().get('email').then((value) {
    debugPrint('email ---------------------------- $value');
    if(value != null) {
      userEmail = value;

    }
  });


  String translation = await rootBundle
      .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

  token = await sl<CacheHelper>().get('token');

  googleToken = await sl<CacheHelper>().get('googleToken');

  debugPrintFullText('My Current Token => $token');

  runApp(MyApp(
    token: token,
    googleToken: googleToken,
    isRtl: isRtl,
    isDark: isDark,
    translation: translation,
  ));
}

class MyApp extends StatelessWidget {
  String? token;
  String? googleToken;
  final bool isRtl;
  final bool isDark;
  final String translation;

  MyApp({
    Key? key,
    required this.token,
    required this.googleToken,
    required this.isRtl,
    required this.isDark,
    required this.translation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => sl<AppCubit>()
            ..setThemes(
              dark: isDark,
              rtl: isRtl,
            )
            ..setTranslation(
              translation: translation,
            )..allProducts()..fillCartMap()..allCategories(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Montgat',
            debugShowCheckedModeBanner: false,
            themeMode: AppCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: AppCubit.get(context).lightTheme,
            darkTheme: AppCubit.get(context).darkTheme,
            home: (token != null || googleToken != null) ? const StartPage() : const LoginPage(),
          );
        },
      ),
    );
  }
}
