import 'package:sociality/core/class/crud.dart';

class HomeScreenData {
  Crud crud;

  HomeScreenData(this.crud);

  getData(page,token) async {
    String getPosts =  "https://social-medai-mern-b696.vercel.app/posts?page=$page";
    var responce = await crud.getRequestHeaders(getPosts,token);

    return responce.fold((left) => left, (right) => right);
  }
}
