import 'package:either_dart/either.dart';
import 'package:sociality/core/class/crud.dart';

class ResetPasswordData {
  Crud crud;
  ResetPasswordData(this.crud);

  getData(email) async {
    var responce =await crud.getRequest(
        "https://social-medai-mern-b696.vercel.app/auth/createResetPassword?email=$email");
    return responce.fold((left) => left, (right) => right);
  }
}
