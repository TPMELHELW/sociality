import 'package:sociality/utils/class/crud.dart';
import 'package:sociality/utils/constant/linkapi.dart';

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

  Future forgetPasswordData(email) async {
    var responce = await crud.getRequest(
        "https://social-medai-mern-b696.vercel.app/auth/createResetPassword?email=$email");
    return responce.fold((left) => left, (right) => right);
  }

  Future resetPasswordData(password) async {
    var responce =
        await crud.patchRequest(resetpasswordlink, {'password': password});
    return responce.fold((left) => left, (right) => right);
  }

  Future verifyData(code) async {
    var responce = await crud.getRequest(
        "https://social-medai-mern-b696.vercel.app/auth/verifyOtp?code=$code");

    return responce.fold((left) => left, (right) => right);
  }
}
