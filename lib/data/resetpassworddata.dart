import 'package:sociality/core/class/crud.dart';
import 'package:sociality/core/constant/linkapi.dart';

class ResetPasswordData {
  Crud crud;
  ResetPasswordData(this.crud);

  patchData(password) async {
    var responce =
        await crud.patchRequest(resetpasswordlink, {'password': password});
    return responce.fold((left) => left, (right) => right);
  }
}
