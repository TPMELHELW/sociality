import 'package:sociality/core/class/crud.dart';
import 'package:sociality/core/constant/linkapi.dart';

class AuthData {
  Crud crud;
  AuthData(this.crud);

  Future logInData(email, password) async {
    var responce = await crud.postRequest(login, {
      'email': email,
      'password': password,
    });
    return responce.fold((left) => left, (right) => right);
  }

  Future signUpData(
      firstName, lastName, email, password, location, occupation) async {
    var responce = await crud.postRequest(register, {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "location": location,
      "occupation": occupation
    });

    return responce.fold((left) => left, (right) => right);
  }
}
