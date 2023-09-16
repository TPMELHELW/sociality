import 'package:sociality/core/class/crud.dart';

class VerifyCodeData {
  Crud crud;
  VerifyCodeData(this.crud);

  getData(code) async {
    var responce = await crud.getRequest(
        "https://social-medai-mern-b696.vercel.app/auth/verifyOtp?code=$code");

    return responce.fold((left) => left, (right) => right);
  }
}
