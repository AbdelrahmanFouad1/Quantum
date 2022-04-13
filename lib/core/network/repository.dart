
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moa/core/models/categories_model.dart';
import 'package:moa/core/models/login_model.dart';
import 'package:moa/core/models/logout_model.dart';
import 'package:moa/core/models/product_model.dart';
import 'package:moa/core/network/remote/api_endpoints.dart';
import 'package:moa/core/network/remote/dio_helper.dart';

import '../error/exceptions.dart';
import 'local/cache_helper.dart';

abstract class Repository {

  Future<Either<String, LoginModel>> login({
    required String email,
    required String password,
  });

  Future<Either<String, LoginModel>> user();

  Future<Either<String, LogoutModel>> logout();

  Future<Either<String,  List<ProductModel>>> products();

  Future<Either<String,  ProductModel>> product({
    required int productId,
  });

  Future<Either<String,  List<CategoriesModel>>> categories();

  Future<Either<String,  CategoriesModel>> category({
    required int categoryId,
  });


}

class RepoImplementation extends Repository {
  final DioHelper dioHelper;
  final CacheHelper cacheHelper;

  RepoImplementation({
    required this.dioHelper,
    required this.cacheHelper,
  });


  @override
  Future<Either<String, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    return _basicErrorHandling<LoginModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          url: loginUrl,
          data: {
            'email': email,
            'password': password,
          },
        );

        return LoginModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, LoginModel>> user() async {
    return _basicErrorHandling<LoginModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          url: userUrl,
          token: token,
        );

        return LoginModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        return exception.message;
      },
    );
  }


  @override
  Future<Either<String, LogoutModel>> logout() async {
    return _basicErrorHandling<LogoutModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          url: logoutUrl,
            token: token,
        );

        return LogoutModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String,  List<ProductModel>>> products() async {
    return _basicErrorHandling< List<ProductModel>>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          url: productsUrl,
        );

        List<ProductModel> products = [];
        f.data.forEach((e){
          products.add(ProductModel.fromJson(e));
        });


        return products;
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String,  ProductModel>> product({
  required int productId,
}) async {
    return _basicErrorHandling< ProductModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          url: '$productsUrl/$productId',

        );

        return ProductModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String,  List<CategoriesModel>>> categories() async {
    return _basicErrorHandling< List<CategoriesModel>>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          url: categoriesUrl,
        );

        List<CategoriesModel> categories = [];
        f.data.forEach((e){
          categories.add(CategoriesModel.fromJson(e));
        });


        return categories;
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String,  CategoriesModel>> category({
    required int categoryId,
  }) async {
    return _basicErrorHandling< CategoriesModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          url: '$categoriesUrl/$categoryId',

        );

        return CategoriesModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        return exception.message;
      },
    );
  }


}

extension on Repository {

  Future<Either<String, T>> _basicErrorHandling<T>({
    required Future<T> Function() onSuccess,
    Future<String> Function(ServerException exception)? onServerError,
    Future<String> Function(CacheException exception)? onCacheError,
    Future<String> Function(dynamic exception)? onOtherError,
  }) async {
    try {
      final f = await onSuccess();
      return Right(f);
    } on ServerException catch (e, s) {
      // recordError(e, s);
      debugPrint(s.toString());
      if (onServerError != null) {
        final f = await onServerError(e);
        return Left(f);
      }
      return const Left('Server Error');
    } on CacheException catch (e) {
      // recordError(e, s);
      debugPrint(e.toString());
      if (onCacheError != null) {
        final f = await onCacheError(e);
        return Left(f);
      }
      return const Left('Cache Error');
    } catch (e, s) {
      // recordError(e, s);
      debugPrint(s.toString());
      if (onOtherError != null) {
        final f = await onOtherError(e);
        return Left(f);
      }
      return Left(e.toString());
    }
  }
}
