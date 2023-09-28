import 'package:sociality/core/class/crud.dart';
import 'package:sociality/core/constant/linkapi.dart';

class SharePostsData {
  Crud crud;

  SharePostsData(this.crud);

  postData(description, header) async {
    var responce = await crud.postRequestHeaders(
        posts, {'description': description}, header);
    return responce.fold(
      (left) => left,
      (right) => right,
    );
  }

  logout() async {
    var responce = await crud
        .getRequest('https://social-medai-mern-b696.vercel.app/auth/logout');
    return responce.fold((left) => left, (right) => right);
  }
}
