import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sociality/core/services/user_services.dart';
import 'package:sociality/utils/class/enum.dart';
import 'package:sociality/utils/function/checkinterner.dart';

class Crud {
  final UserService _userServices = Get.find<UserService>();
  Map<String, String>? get token => {
        'Authorization':
            'Bearer ${_userServices.currentUser.value?.accessToken}'
      };
  Future<Either<StatusRequest, Map>> postRequest(uri, body) async {
    try {
      if (await checkInternet()) {
        var responce = await http.post(Uri.parse(uri), body: body);
        if (responce.statusCode == 201 || responce.statusCode == 200) {
          var responcebody = await jsonDecode(responce.body);
          return Right(responcebody);
        } else {
          var responcebodyerror = await jsonDecode(responce.body);
          return Right(responcebodyerror);
        }
      } else {
        return const Left(StatusRequest.offline);
      }
    } catch (e) {
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> postRequestHeaders(uri, body) async {
    try {
      if (await checkInternet()) {
        var responce =
            await http.post(Uri.parse(uri), body: body, headers: token);
        if (responce.statusCode == 201 || responce.statusCode == 200) {
          var responcebody = await jsonDecode(responce.body);
          return Right(responcebody);
        } else {
          var responcebodyerror = await jsonDecode(responce.body);
          return Right(responcebodyerror);
        }
      } else {
        return const Left(StatusRequest.offline);
      }
    } catch (e) {
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> getRequestHeaders(String uri) async {
    try {
      if (await checkInternet()) {
        var responce = await http.get(Uri.parse(uri), headers: token);
        if (responce.statusCode == 200 || responce.statusCode == 201) {
          var responcebody = await jsonDecode(responce.body);
          return Right(responcebody);
        } else {
          var responcebody = await jsonDecode(responce.body);
          return Right(responcebody);
        }
      } else {
        return const Left(StatusRequest.offline);
      }
    } catch (e) {
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> getRequest(url) async {
    try {
      if (await checkInternet()) {
        var responce = await http.get(Uri.parse(url));
        if (responce.statusCode == 200 || responce.statusCode == 201) {
          var responcebody = await jsonDecode(responce.body);
          return Right(responcebody);
        } else {
          var responcebodyerror = await jsonDecode(responce.body);
          return Right(responcebodyerror);
        }
      } else {
        return const Left(StatusRequest.offline);
      }
    } catch (e) {
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> patchRequest(url, body) async {
    try {
      if (await checkInternet()) {
        var responce = await http.patch(Uri.parse(url), body: body);
        if (responce.statusCode == 200 || responce.statusCode == 201) {
          var responcebody = await jsonDecode(responce.body);
          return Right(responcebody);
        } else {
          var responcebodyerror = await jsonDecode(responce.body);
          return Right(responcebodyerror);
        }
      } else {
        return const Left(StatusRequest.offline);
      }
    } catch (e) {
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> patchRequestHeaders(url, body) async {
    try {
      if (await checkInternet()) {
        var responce =
            await http.patch(Uri.parse(url), body: body, headers: token);
        if (responce.statusCode == 200 || responce.statusCode == 201) {
          var responcebody = await jsonDecode(responce.body);
          return Right(responcebody);
        } else {
          var responcebodyerror = await jsonDecode(responce.body);
          return Right(responcebodyerror);
        }
      } else {
        return const Left(StatusRequest.offline);
      }
    } catch (e) {
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> deleteRequest(url) async {
    try {
      if (await checkInternet()) {
        var responce = await http.delete(Uri.parse(url), headers: token);
        if (responce.statusCode == 200 || responce.statusCode == 201) {
          var responcebody = await jsonDecode(responce.body);
          return Right(responcebody);
        } else {
          var responcebody = await jsonDecode(responce.body);

          return Right(responcebody);
        }
      } else {
        return const Left(StatusRequest.offline);
      }
    } catch (e) {
      return const Left(StatusRequest.serverFailure);
    }
  }
}
