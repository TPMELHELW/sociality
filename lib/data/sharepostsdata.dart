import 'package:sociality/core/class/crud.dart';
import 'package:sociality/core/constant/linkapi.dart';

class SharePostsData {
  Crud crud;

  SharePostsData(this.crud);

  postData(description,header) async {
    var responce = await crud.postRequestHeaders(posts, {'description': description},header);
    return responce.fold(
      (left) => left,
      (right) => right,
    );
  }
}
