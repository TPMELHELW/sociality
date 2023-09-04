import 'dart:convert';


import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sociality/controller/logincontroller.dart';
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/checkinterner.dart';

class Crud {
  // LogInController controller = Get.put(LogInController());

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
        print('2');
        return Left(StatusRequest.offline);
      }
    } catch (e) {
      // print('3');
      print('22');
      print(e);
      return Left(StatusRequest.serverFailure);
    }
  }
  Future<Either<StatusRequest, Map>> postRequestHeaders(uri, body,header) async {
    try {
      if (await checkInternet()) {
        var responce = await http.post(Uri.parse(uri), body: body,headers: header);
        if (responce.statusCode == 201 || responce.statusCode == 200) {
          var responcebody = await jsonDecode(responce.body);
          return Right(responcebody);
        } else {
          var responcebodyerror = await jsonDecode(responce.body);
          return Right(responcebodyerror);
        }
      } else {
        print('2');
        return Left(StatusRequest.offline);
      }
    } catch (e) {
      // print('3');
      print('22');
      print(e);
      return Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> getRequest(uri,token) async {
    try {
      if (await checkInternet()) {
        var responce = await http.get(Uri.parse(uri), headers: {
          'Authorization': 'Bearer ${token}',
        });
        if (responce.statusCode == 200 || responce.statusCode == 201) {
          var responcebody = await jsonDecode(responce.body);
          return Right(responcebody);
        } else {
          print('1');
          print(responce);
          return Left(StatusRequest.failure);
        }
      } else {
        print('2');
        return Left(StatusRequest.offline);
      }
    } catch (e) {
      print('3');
      print(e);
      return Left(StatusRequest.serverFailure);
    }
  }
}
