import '../core/class/crud.dart';

class ProfileScreenData {
  Crud crud;
  ProfileScreenData(this.crud);

  getData(userId,token,page) async {
    var responce = await crud
        .getRequestHeaders('https://social-medai-mern-b696.vercel.app/posts/$userId?page=$page',token);
    return responce.fold((left) => left, (right) => right);
  }
}
