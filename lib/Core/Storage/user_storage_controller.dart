import 'dart:async';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:miracle/Core/Global/Models/user_model.dart';

class UserStoreController extends GetxController {
  UserStoreController();

  late Box _storage;
  // static UserStoreController get to => Get.find();

  Future<void> saveUserData(final UserModel userData) async {
    _storage = await Hive.openBox<UserModel>('user');
    try {
      removeData();
    } catch (_) {}
    await _storage.add(userData);
    await _storage.close();
  }

  Future<UserModel?> getUserData() async {
    _storage = await Hive.openBox<UserModel>('user');
    try {
      return _storage.values.first;
    } catch (e) {
      return null;
    }
    // final tokenJson = _storage.values.first;
    // if (tokenJson == null) return null;
    // return UserModel.fromJson(tokenJson);
  }

  void removeData() async {
    await _storage.clear();
  }

  // @override
  // void onInit() async {
  // _storage = await Hive.openBox('user');
  // super.onInit();
  // }

  @override
  void dispose() {
    try {
      _storage.close();
    } catch (_) {}
    super.dispose();
  }
}
