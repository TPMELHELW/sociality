import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:sociality/core/class/enum.dart';
import 'package:sociality/core/function/checkinterner.dart';

class Crud {
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
        return Left(StatusRequest.offline);
      }
    } catch (e) {
      // print('3');
      return Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> postRequestHeaders(
      uri, body, header) async {
    try {
      if (await checkInternet()) {
        var responce =
            await http.post(Uri.parse(uri), body: body, headers: header);
        if (responce.statusCode == 201 || responce.statusCode == 200) {
          var responcebody = await jsonDecode(responce.body);
          return Right(responcebody);
        } else {
          var responcebodyerror = await jsonDecode(responce.body);
          return Right(responcebodyerror);
        }
      } else {
        return Left(StatusRequest.offline);
      }
    } catch (e) {
      return Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> getRequestHeaders(uri, token) async {
    try {
      if (await checkInternet()) {
        var responce = await http.get(Uri.parse(uri), headers: token);
        if (responce.statusCode == 200 || responce.statusCode == 201) {
          var responcebody = await jsonDecode(responce.body);
          print('elhelw');
          return Right(responcebody);
        } else {
          print('8');
          return Left(StatusRequest.failure);
        }
      } else {
        print('19');
        return Left(StatusRequest.offline);
      }
    } catch (e) {
      print(e);
      return Left(StatusRequest.serverFailure);
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
        print('2');
        return Left(StatusRequest.offline);
      }
    } catch (e) {
      print('3');
      return Left(StatusRequest.serverFailure);
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
          print('gfds');
          var responcebodyerror = await jsonDecode(responce.body);
          return Right(responcebodyerror);
        }
      } else {
        return Left(StatusRequest.offline);
      }
    } catch (e) {
      print({e});
      print('mahmouf');
      return Left(StatusRequest.serverFailure);
    }
  }
  Future<Either<StatusRequest, Map>> patchRequestHeaders(url, body,token) async {
    try {
      if (await checkInternet()) {
        var responce = await http.patch(Uri.parse(url), body: body,headers: token);
        if (responce.statusCode == 200 || responce.statusCode == 201) {
          var responcebody = await jsonDecode(responce.body);
          return Right(responcebody);
        } else {
          print('gfds');
          var responcebodyerror = await jsonDecode(responce.body);
          return Right(responcebodyerror);
        }
      } else {
        return Left(StatusRequest.offline);
      }
    } catch (e) {
      print({e});
      print('mahmouf');
      return Left(StatusRequest.serverFailure);
    }
  }
}
