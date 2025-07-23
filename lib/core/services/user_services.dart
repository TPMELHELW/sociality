import 'dart:convert';
import 'package:get/get.dart';
import 'package:sociality/core/services/shared_preferences_services.dart';
import 'package:sociality/features/auth/model/user_model.dart';

class UserService extends GetxService {
  late SharedPreferencesService _prefs;
  final Rxn<UserModel> currentUser = Rxn<UserModel>();

  Future<UserService> init() async {
    _prefs = Get.find<SharedPreferencesService>();
    await _loadUserFromCache();
    return this;
  }

  Future<void> saveUser(Map<dynamic, dynamic> user) async {
    final json = jsonEncode(user);
    await _prefs.setString('user_data', json);
    currentUser.value = UserModel.fromJson(user);
  }

  Future<void> _loadUserFromCache() async {
    final json = await _prefs.getString('user_data');
    if (json != null) {
      final map = jsonDecode(json);
      currentUser.value = UserModel.fromJson(map);
    }
  }

  // Future<void> updateUserField({
  //   required String field,
  //   required dynamic value,
  // }) async {
  //   final current = currentUser.value;
  //   if (current == null) return;

  //   await FirebaseFirestore.instance.collection('users').doc(current.id).update(
  //     {field: value},
  //   );

  //   final updatedUser = current.copyWith(
  //     name: field == 'Name' ? value : null,
  //     email: field == 'Email' ? value : null,
  //     userName: field == 'UserName' ? value : null,
  //   );

  //   await saveUser(updatedUser);
  // }

  Future<void> clearUser() async {
    await _prefs.remove('user_data');
    currentUser.value = null;
  }
}
