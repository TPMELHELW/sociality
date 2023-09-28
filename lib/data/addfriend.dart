import 'package:sociality/core/class/crud.dart';

class AddFriendData {
  Crud crud;
  AddFriendData(this.crud);

  addFriend(currentId, friendId, token) async {
    var responce = await crud.patchRequestHeaders(
        'https://social-medai-mern-b696.vercel.app/users/$currentId/$friendId',
        {},
        token);
    return responce.fold((left) => left, (right) => right);
  }
}
