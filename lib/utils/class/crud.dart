import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:sociality/core/services/user_services.dart';
import 'package:sociality/utils/class/enum.dart';
import 'package:sociality/utils/function/checkinterner.dart';

class Crud {
  final UserService _userServices = Get.find<UserService>();
  late final Dio dio;

  Crud() {
    dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = _userServices.currentUser.value?.accessToken;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (DioException e, handler) {
          // log(e.toString());
          // if (e.response?.statusCode == 401) {
          _forceLogout();
          // }
          handler.next(e);
        },
      ),
    );
  }

  void _forceLogout() {
    _userServices.clearUser();
    Get.offAllNamed('/login');
    Get.snackbar('Session Expired', 'Please log in again.');
  }

  Future<Either<StatusRequest, Map>> postRequest(String uri, Map body) async {
    try {
      if (await checkInternet()) {
        final response = await dio.post(uri, data: body);
        return Right(response.data as Map);
      } else {
        return const Left(StatusRequest.offline);
      }
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> postRequestHeaders(
      String uri, Map body) async {
    // Same as postRequest, headers handled by interceptor
    return postRequest(uri, body);
  }

  Future<Either<StatusRequest, Map>> getRequestHeaders(String uri) async {
    try {
      if (await checkInternet()) {
        final response = await dio.get(uri);
        // print(response.data);
        return Right(response.data as Map);
      } else {
        return const Left(StatusRequest.offline);
      }
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      log(e.toString());
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> getRequest(String uri) async {
    // Same as getRequestHeaders, headers handled by interceptor
    return getRequestHeaders(uri);
  }

  Future<Either<StatusRequest, Map>> patchRequest(String uri, Map body) async {
    try {
      if (await checkInternet()) {
        final response = await dio.patch(uri, data: body);
        return Right(response.data as Map);
      } else {
        return const Left(StatusRequest.offline);
      }
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> patchRequestHeaders(
      String uri, Map body) async {
    // Same as patchRequest, headers handled by interceptor
    return patchRequest(uri, body);
  }

  Future<Either<StatusRequest, Map>> deleteRequest(String uri) async {
    try {
      if (await checkInternet()) {
        final response = await dio.delete(uri);
        return Right(response.data as Map);
      } else {
        return const Left(StatusRequest.offline);
      }
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return const Left(StatusRequest.serverFailure);
    }
  }

  Either<StatusRequest, Map> _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const Left(StatusRequest.offline);
    }
    if (e.response?.statusCode == 401) {
      return const Left(StatusRequest.unauthorized);
    }
    return const Left(StatusRequest.serverFailure);
  }
}
