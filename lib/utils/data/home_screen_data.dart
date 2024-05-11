import 'package:sociality/utils/class/crud.dart';
import 'package:sociality/utils/constant/linkapi.dart';

class HomeScreenData {
  Crud crud;

  HomeScreenData(this.crud);

  Future getPostsData(page) async {
    var responce = await crud.getRequestHeaders('$posts/?page=$page');
    return responce.fold((left) => left, (right) => right);
  }

  Future sharePostsData(description) async {
    var responce =
        await crud.postRequestHeaders(posts, {'description': description});
    return responce.fold(
      (left) => left,
      (right) => right,
    );
  }

  Future logOutData() async {
    var responce = await crud.getRequestHeaders(logOut);
    return responce.fold((left) => left, (right) => right);
  }

  Future likesData(postId) async {
    var responce = await crud.patchRequestHeaders(
      'https://social-medai-mern-b696.vercel.app/posts/$postId/like',
      {},
    );
    return responce.fold((left) => left, (right) => right);
  }

  Future profileData(userId, page) async {
    var responce = await crud.getRequestHeaders('$posts/$userId?page=$page');
    return responce.fold((left) => left, (right) => right);
  }

  Future deleteData(postId) async {
    var responce = await crud.deleteRequest('$posts/$postId');
    return responce.fold((left) => left, (right) => right);
  }

  Future addFriend(currentId, friendId) async {
    var responce = await crud.patchRequestHeaders(
      '$users/$currentId/$friendId',
      {},
    );
    return responce.fold((left) => left, (right) => right);
  }

  Future editPostData(postId, desc) async {
    var responce = await crud.patchRequestHeaders(
      '$posts/$postId',
      {'desc': desc},
    );

    return responce.fold((left) => left, (right) => right);
  }
}
