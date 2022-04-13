import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/models/cart_model.dart';
import 'package:moa/core/models/categories_model.dart';
import 'package:moa/core/models/login_model.dart';
import 'package:moa/core/models/logout_model.dart';
import 'package:moa/core/models/product_model.dart';
import 'package:moa/core/models/select_government_model.dart';
import 'package:moa/core/network/remote/api_endpoints.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/translation.dart';
import 'package:moa/features/login/presentation/pages/login_page.dart';
import '../../di/injection.dart';
import '../../network/local/cache_helper.dart';
import '../../network/repository.dart';

class AppCubit extends Cubit<AppState> {
  final Repository _repository;

  AppCubit({
    required Repository repository,
  })  : _repository = repository,
        super(Empty());

  static AppCubit get(context) => BlocProvider.of(context);

  late TranslationModel translationModel;

  bool isRtl = false;
  bool isRtlChange = false;
  bool isDark = false;

  late ThemeData lightTheme;
  late ThemeData darkTheme;

  late String family;

  void setThemes({
    required bool dark,
    required bool rtl,
  }) {
    isRtl = rtl;
    isRtlChange = rtl;

    isDark = dark;

    debugPrint('dark mode ------------- $isDark');

    changeTheme();

    emit(ThemeLoaded());
  }

  void changeLanguage({required bool value}) async {
    isRtl = value;

    sl<CacheHelper>().put('isRtl', isRtl);
    String translation = await rootBundle
        .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

    setTranslation(
      translation: translation,
    );

    emit(ChangeLanguageState());
  }

  void changeMode({required bool value}) {
    isDark = value;

    sl<CacheHelper>().put('isDark', isDark);

    emit(ChangeModeState());
  }

  void changeTheme() {
    family = isRtl ? 'Cairo' : 'Poppins';

    lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: Platform.isIOS
            ? null
            : const SystemUiOverlayStyle(
                statusBarColor: whiteColor,
                statusBarIconBrightness: Brightness.dark,
              ),
        backgroundColor: whiteColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(
          size: 20.0,
          color: Colors.black,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: family,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: whiteColor,
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: MaterialColor(int.parse('0xff$mainColor'), color),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: pxToDp(20.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondary),
        ),
        bodyText1: TextStyle(
          fontSize: pxToDp(16.0),
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryVariant),
        ),
        bodyText2: TextStyle(
          fontSize: pxToDp(14.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryVariant),
        ),
        subtitle1: TextStyle(
          fontSize: pxToDp(12.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryVariant),
        ),
        subtitle2: TextStyle(
          fontSize: pxToDp(12.0),
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryVariant),
        ),
        caption: TextStyle(
          fontSize: pxToDp(11.0),
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondary),
        ),
        button: TextStyle(
          fontSize: pxToDp(16.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: whiteColor,
        ),
      ),
    );

    darkTheme = ThemeData(
      scaffoldBackgroundColor: HexColor(scaffoldBackgroundDark),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: Platform.isIOS
            ? null
            : SystemUiOverlayStyle(
                statusBarColor: HexColor(scaffoldBackgroundDark),
                statusBarIconBrightness: Brightness.light,
              ),
        backgroundColor: HexColor(scaffoldBackgroundDark),
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: IconThemeData(
          size: 20.0,
          color: HexColor(regularGrey),
        ),
        titleTextStyle: TextStyle(
          color: HexColor(regularGrey),
          fontFamily: family,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor(scaffoldBackgroundDark),
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: HexColor(regularGrey),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: MaterialColor(int.parse('0xff$mainColor'), color),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: pxToDp(20.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryDark),
        ),
        bodyText1: TextStyle(
          fontSize: pxToDp(16.0),
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryVariantDark),
        ),
        bodyText2: TextStyle(
          fontSize: pxToDp(14.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryVariantDark),
        ),
        subtitle1: TextStyle(
          fontSize: pxToDp(12.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryVariantDark),
        ),
        subtitle2: TextStyle(
          fontSize: pxToDp(12.0),
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryVariantDark),
        ),
        caption: TextStyle(
          fontSize: pxToDp(11.0),
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryDark),
        ),
        button: TextStyle(
          fontSize: pxToDp(16.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: whiteColor,
        ),
      ),
    );
  }

  void setTranslation({
    required String translation,
  }) {
    translationModel = TranslationModel.fromJson(json.decode(
      translation,
    ));

    emit(LanguageLoaded());
  }

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final registerUserFullNameController = TextEditingController();
  final registerUserIdController = TextEditingController();
  final registerUserMobileController = TextEditingController();
  final registerUserAddressController = TextEditingController();
  final registerUserEmailAddressController = TextEditingController();
  final registerUserPasswordController = TextEditingController();
  final registerUserConfirmPasswordController = TextEditingController();


  PageController pageController = PageController();

  int currentIndex = 0;

  void bottomChanged(int index, context, ) {
    currentIndex = index;

      pageController.jumpToPage(
        index,
      );


    emit(BottomChanged());
  }

  ///loginPage ------------------ start
  LoginModel? loginModel;

  void userLogin() async {
    emit(UserLoginLoading());

    final result = await _repository.login(
      email: loginEmailController.text,
      password: loginPasswordController.text,
    );

    result.fold(
      (failure) {
        emit(
          UserLoginError(
            message: failure,
          ),
        );
      },
      (data) {
        loginModel = data;

        currentIndex = 0;
        emit(UserLoginSuccess(
          token: loginModel!.token,
        ));
      },
    );
  }

  String? userName;
  String? phone;
  String? email;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn =  GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {


    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;


    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    sl<CacheHelper>().put('googleToken', googleAuth?.accessToken);


    // Once signed in, return the UserCredential
    var result = (await _auth.signInWithCredential(credential));

    userName = result.user!.displayName;
    phone = result.user!.phoneNumber;
    email = result.user!.email;

    sl<CacheHelper>().put('userName', userName);
    sl<CacheHelper>().put('email', email);

    // debugPrint('userName $userName');
    // debugPrint('phone $phone');
    // debugPrint('email $email');

    return result;
  }





  ///loginPage ------------------ end



  //registerPage ------------------ start

  SelectGovernmentModel selectedGovernment = cities[0];

  void changeSelectedGovernment({
    required SelectGovernmentModel value,
  }) {
    selectedGovernment = value;
    emit(ChangeSelectedGovernment());
  }

  //registerPage ------------------ end



  //ProfilePage ------------------ start



  LogoutModel? logoutModel;

  void userLogout() async {
    emit(UserLogoutLoading());

    final result = await _repository.logout();

    result.fold(
      (failure) {
        emit(
          UserLogoutError(
            message: failure,
          ),
        );
      },
      (data) {
        logoutModel = data;

        emit(UserLogoutSuccess(
          message: logoutModel!.message,
        ));
      },
    );
  }

  LoginModel? userModel;

  void userInfo() async {
    if(token != null && token!.isNotEmpty){
      emit(UserInfoLoading());
      final result = await _repository.user();
      result.fold(
            (failure) {
          emit(Error());
        },
            (data) {
          userModel = data;
          emit(UserInfoSuccess());
        },
      );
    }

  }



  Future<void> signOut(context) async {
    await _auth.signOut();
    await _googleSignIn.signOut().then((value) {

      sl<CacheHelper>().clear('googleToken').then((value) {
        googleToken = null;

        navigateAndFinish(context, const LoginPage());

        sl<CacheHelper>().clear('userName');
        sl<CacheHelper>().clear('email');
      });

    });

    emit(SignOutSuccess());

  }

  //ProfilePage ------------------ end

  
  //HomePage ------------------ start
  List<ProductModel> productsModel = [];
  void allProducts() async {

    emit(AllProductsLoading());

    final result = await _repository.products();

    result.fold(
          (failure) {
        debugPrint(failure.toString());
        emit(
          AllProductsError(
            message: failure,
          ),
        );
      },
          (data) {
            productsModel = data;

        emit(AllProductsSuccess());
      },
    );

  }

  ProductModel? oneProductModel;
  void oneProduct({
  required int productId,
  }) async {
    oneProductModel = null;
    emit(OneProductLoading());

    final result = await _repository.product(productId: productId);

    result.fold(
          (failure) {
        debugPrint(failure.toString());
        emit(
          OneProductError(
            message: failure,
          ),
        );
      },
          (data) {
            oneProductModel = data;

        emit(OneProductSuccess());
      },
    );

  }

  //HomePage ------------------ end

  //categoriesPage ------------------ start

  List<CategoriesModel> categoriesModel = [];
  void allCategories() async {
    emit(AllCategoriesLoading());

    final result = await _repository.categories();

    result.fold(
          (failure) {
        debugPrint(failure.toString());
        emit(
          AllCategoriesError(
            message: failure,
          ),
        );
      },
          (data) {
            categoriesModel = data;

        emit(AllCategoriesSuccess());
      },
    );

  }

  CategoriesModel? oneCategoryModel;
  void oneCategory({
    required int categoryId,
  }) async {
    oneCategoryModel = null;
    emit(OneCategoryLoading());

    final result = await _repository.category(categoryId: categoryId);

    result.fold(
          (failure) {
        debugPrint(failure.toString());
        emit(
          OneCategoryError(
            message: failure,
          ),
        );
      },
          (data) {
        oneCategoryModel = data;

        emit(OneCategorySuccess());
      },
    );

  }

  //categoriesPage ------------------ end

  //ProductDetailsPage ------------------ start

  int itemCount = 1;

  void addition() {
    if (oneProductModel!.stock == itemCount) {
      itemCount = oneProductModel!.stock;
    } else {
      itemCount++;
      emit(Addition());
    }
  }

  void subtraction() {
    if (itemCount <= 1) {
      itemCount = 1;
    } else {
      itemCount--;
    }
    emit(Subtraction());
  }

  //categoriesPage ------------------ end

  //CartPage ------------------ start

  Map<int, CartModel> cartMap = {};

  void addToCartMap(CartModel model) {
    cartMap.addAll({
      model.pId: model,
    });

    sumSubTotalCart();

    emit(AddToCartMapState());
  }

  num subtotalCart = 0;
  num firstTotalCart = 0;

  void sumSubTotalCart() {
    subtotalCart = 0;

    cartMap.forEach((key, value) {
      subtotalCart = subtotalCart + (value.quantity * value.price);
    });

    firstTotalCart = subtotalCart;


    emit(CartSubTotal());
  }

  void cartAddition({
    required int id,
  }) {
    if (cartMap[id]!.quantity < cartMap[id]!.stock) {

      cartMap[id]!.quantity = cartMap[id]!.quantity + 1;

      for (int i = 0; i < cartListData!.length; i++) {
        if (cartListData![i].pId == id) {
          cartListData![i] = cartMap[id]!;
        }
      }

      MainCartModel model = MainCartModel(
        data: cartListData!,
      );

      sl<CacheHelper>()
          .put(
        'cart',
        model.toJson(),
      )
          .then((value) {
        debugPrint('cart inserted !!!');
      });
    }

    sumSubTotalCart();

    emit(CartAddition());
  }

  void cartSubtraction({
    required int id,
  }) {
    if (cartMap[id]!.quantity > 1) {
      cartMap[id]!.quantity = cartMap[id]!.quantity - 1;

      for (int i = 0; i < cartListData!.length; i++) {
        if (cartListData![i].pId == id) {
          cartListData![i] = cartMap[id]!;
        }
      }

      MainCartModel model = MainCartModel(
        data: cartListData!,
      );

      sl<CacheHelper>()
          .put(
        'cart',
        model.toJson(),
      )
          .then((value) {
        debugPrint('cart inserted !!!');
      });
    }

    sumSubTotalCart();

    emit(CartSubtraction());
  }

  void removeFromCartMap(int id) {
    cartMap.removeWhere((key, value) => key == id);
    sumSubTotalCart();
    emit(RemoveFromCartMapState());
  }

  void fillCartMap() {
    if (cartListData != null && cartListData!.isNotEmpty) {
      for (var element in cartListData!) {
        cartMap.addAll({
          element.pId: element,
        });
      }

      sumSubTotalCart();

      emit(FillCartMapState());
    }
  }

  //CartPage ------------------ end

  int currentDay = 0;

  void selectDay(int index) {
    currentDay = index;
    emit(SelectDay());
  }

  int currentTime = 0;

  void selectTime(int index) {
    currentTime = index;
    emit(SelectTime());
  }
}
