import 'package:sociality/core/class/crud.dart';
import 'package:sociality/core/constant/linkapi.dart';

class HomeScreenData {
  Crud crud;

  HomeScreenData(this.crud);

  Future getPostsData(page, token) async {
    String getPosts =
        "https://social-medai-mern-b696.vercel.app/posts?page=$page";
    var responce = await crud.getRequestHeaders(getPosts, token);

    return responce.fold((left) => left, (right) => right);
  }

  Future sharePostsData(description, header) async {
    var responce = await crud.postRequestHeaders(
        posts, {'description': description}, header);
    return responce.fold(
      (left) => left,
      (right) => right,
    );
  }

  Future logOut(Map<String, String> token) async {
    var responce = await crud.getRequestHeaders(
        'https://social-medai-mern-b696.vercel.app/auth/logout', token);
    return responce.fold((left) => left, (right) => right);
  }

  Future likesData(postId, token) async {
    var responce = await crud.patchRequestHeaders(
        'https://social-medai-mern-b696.vercel.app/posts/$postId/like',
        {},
        token);
    return responce.fold((left) => left, (right) => right);
  }

  Future profileData(userId, token, page) async {
    var responce = await crud.getRequestHeaders(
        'https://social-medai-mern-b696.vercel.app/posts/$userId?page=$page',
        token);
    return responce.fold((left) => left, (right) => right);
  }

  Future deleteData(postId, token) async {
    var responce = await crud.deleteRequest(
        'https://social-medai-mern-b696.vercel.app/posts/$postId', token);
    return responce.fold((left) => left, (right) => right);
  }

  Future addFriend(currentId, friendId, token) async {
    var responce = await crud.patchRequestHeaders(
        'https://social-medai-mern-b696.vercel.app/users/$currentId/$friendId',
        {},
        token);
    return responce.fold((left) => left, (right) => right);
  }
}
