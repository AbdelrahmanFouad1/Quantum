import 'package:meta/meta.dart';

@immutable
abstract class AppState {}

class Empty extends AppState {}

class Loading extends AppState {}

class Loaded extends AppState {}

class Error extends AppState {}

class ThemeLoaded extends AppState {}

class ChangeModeState extends AppState {}

class ChangeLanguageState extends AppState {}

class LanguageLoaded extends AppState {}

class ChangeSelectedGovernment extends AppState {}

class UserLoginLoading extends AppState {}

class UserLoginSuccess extends AppState {
  final String token;

  UserLoginSuccess({
    required this.token,
  });
}

class UserInfoLoading extends AppState {}

class UserInfoSuccess extends AppState {}

class UserLoginError extends AppState {
  final String message;

  UserLoginError({
    required this.message,
  });
}

class UserLogoutLoading extends AppState {}

class UserLogoutSuccess extends AppState {
  final String message;

  UserLogoutSuccess({
    required this.message,
  });
}

class UserLogoutError extends AppState {
  final String message;

  UserLogoutError({
    required this.message,
  });
}

class GetAllGovernmentsLoading extends AppState {}

class GetAllGovernmentsSuccess extends AppState {}

class GetAllGovernmentsError extends AppState {
  final String message;

  GetAllGovernmentsError({
    required this.message,
  });
}

class UserRegisterLoading extends AppState {}

class UserRegisterSuccess extends AppState {}

class UserRegisterError extends AppState {
  final String message;

  UserRegisterError({
    required this.message,
  });
}

class AllProductsLoading extends AppState {}

class AllProductsSuccess extends AppState {}

class AllProductsError extends AppState {
  final String message;

  AllProductsError({
    required this.message,
  });
}

class AllCategoriesLoading extends AppState {}

class AllCategoriesSuccess extends AppState {}

class AllCategoriesError extends AppState {
  final String message;

  AllCategoriesError({
    required this.message,
  });
}

class OneProductLoading extends AppState {}

class SignOutSuccess extends AppState {}

class OneProductSuccess extends AppState {}

class OneProductError extends AppState {
  final String message;

  OneProductError({
    required this.message,
  });
}

class OneCategoryLoading extends AppState {}

class OneCategorySuccess extends AppState {}

class OneCategoryError extends AppState {
  final String message;

  OneCategoryError({
    required this.message,
  });
}

class ChangeLoaded extends AppState {}

class BottomChanged extends AppState {}

class SelectDay extends AppState {}

class SelectTime extends AppState {}

class Addition extends AppState {}

class AddToCartMapState extends AppState {}

class CartSubTotal extends AppState {}

class Subtraction extends AppState {}
class CartAddition extends AppState {}
class CartSubtraction extends AppState {}
class RemoveFromCartMapState extends AppState {}
class FillCartMapState extends AppState {}