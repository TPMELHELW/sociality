import 'package:sociality/core/class/crud.dart';
import 'package:sociality/core/constant/linkapi.dart';

class LogInData {
  Crud crud;
  LogInData(this.crud);

  getData(email, password) async {
    var responce = await crud.postRequest(login, {
      'email': email,
      'password': password,
    });
    return responce.fold((left) => left, (right) => right);
  }
}
