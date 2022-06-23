import 'dart:async';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:miracle/Core/Models/user_model.dart';

class UserStoreController extends GetxController {
  UserStoreController();

  late Box _storage;
  // static UserStoreController get to => Get.find();

  Future<void> saveToken(final UserModel userData) async {
    await _storage.clear();
    await _storage.add(userData);
  }

  UserModel? getUserData() {
    final tokenJson = _storage.values.first;
    if (tokenJson == null) return null;
    return UserModel.fromJson(tokenJson);
  }

  void removeData() async {
    await _storage.clear();
  }

  @override
  void onInit() async {
    _storage = await Hive.openBox('user');
    super.onInit();
  }

  @override
  void dispose() {
    try {
      _storage.close();
    } catch (_) {}
    super.dispose();
  }
}
