import 'package:sociality/core/class/crud.dart';

class LikesData {
  Crud crud;
  LikesData(this.crud);
  likes(postId, token) async {
    var responce = await crud.patchRequestHeaders(
        'https://social-medai-mern-b696.vercel.app/posts/$postId/like',
        {},
        token);
    return responce.fold((left) => left, (right) => right);
  }
}
