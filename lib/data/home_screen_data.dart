import 'package:sociality/core/class/crud.dart';
import 'package:sociality/core/constant/linkapi.dart';

class HomeScreenData {
  Crud crud;

  HomeScreenData(this.crud);

  Future getData(page, token) async {
    String getPosts =
        "https://social-medai-mern-b696.vercel.app/posts?page=$page";
    var responce = await crud.getRequestHeaders(getPosts, token);

    return responce.fold((left) => left, (right) => right);
  }

  Future postData(description, header) async {
    var responce = await crud.postRequestHeaders(
        posts, {'description': description}, header);
    return responce.fold(
      (left) => left,
      (right) => right,
    );
  }

  Future logout(Map<String, String> token) async {
    var responce = await crud.getRequestHeaders(
        'https://social-medai-mern-b696.vercel.app/auth/logout', token);
    return responce.fold((left) => left, (right) => right);
  }
}
