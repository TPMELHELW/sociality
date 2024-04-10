import 'package:sociality/core/class/crud.dart';

class EditPostData {
  Crud crud;

  EditPostData(this.crud);

  patchData(postId, desc, token) async {
    var responce = await crud.patchRequestHeaders(
        'https://social-medai-mern-b696.vercel.app/posts/$postId',
        {'desc': desc},
        token);

    return responce.fold((left) => left, (right) => right);
  }
}
