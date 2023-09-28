import 'package:sociality/core/class/crud.dart';

class SettingsData {
  Crud crud;

  SettingsData(this.crud);

  patchData(
    token,
    email,
    location,
    occupation,
    password,
    firstName,
    lastName,
  ) async {
    var responce = await crud.patchRequestHeaders(
        'https://social-medai-mern-b696.vercel.app/users',
        {
          'email': email ?? '',
          'location': location ?? '',
          'occupation': occupation ?? '',
          'password': password ?? '', 
          'firstName': firstName ?? '',
          'lastName': lastName ?? '',
        },
        token);
    return responce.fold((left) => left, (right) => right);
  }
}
