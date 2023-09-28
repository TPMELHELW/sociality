import 'package:sociality/core/class/crud.dart';

class RefreshData {
  Crud crud ;

  RefreshData(this.crud);

  refresh (token)async {
    var responce = await crud.getRequestHeaders('https://social-medai-mern-b696.vercel.app/refresh',token);
    return responce.fold((left) => left, (right) => right);
  }
}