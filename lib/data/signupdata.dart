import 'package:sociality/core/class/crud.dart';
import 'package:sociality/core/constant/linkapi.dart';

class SignUpData {
  Crud crud;
  SignUpData(this.crud);

  getData(firstName, lastName, email, password, location, occupation) async {
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
