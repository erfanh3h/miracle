import 'dart:async';
import 'package:refreshed/refreshed.dart';
import 'package:hive/hive.dart';
import 'package:miracle/Core/Global/Models/user_model.dart';

class UserStoreController extends GetxController {
  UserStoreController();

  late Box _storage;
  // static UserStoreController get to => Get.find();

  Future<void> saveUserData(final UserModel userData) async {
    _storage = await Hive.openBox<UserModel>('user');
    try {
      await _storage.clear();
    } catch (_) {}
    _storage = await Hive.openBox<UserModel>('user');
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
    _storage = await Hive.openBox<UserModel>('user');
    await _storage.clear();
    await _storage.close();
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
