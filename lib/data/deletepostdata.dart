import 'package:sociality/core/class/crud.dart';

class DeletePostData {
  Crud crud;

  DeletePostData(this.crud);

  deleteData(postId,token) async {
    var responce = await crud.deleteRequest(
        'https://social-medai-mern-b696.vercel.app/posts/$postId',token);
    return responce.fold((left) => left, (right) => right);
  }
}
