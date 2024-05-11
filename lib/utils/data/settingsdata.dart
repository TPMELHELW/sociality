import 'package:sociality/utils/class/crud.dart';

class SettingsData {
  Crud crud;

  SettingsData(this.crud);

  patchData(
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
    );
    return responce.fold((left) => left, (right) => right);
  }
}
