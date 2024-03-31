import 'dart:async';
import 'package:miracle/Features/days/Models/days.dart';
import 'package:refreshed/refreshed.dart';
import 'package:hive/hive.dart';
import 'package:miracle/Core/Global/Models/user_model.dart';

class UserStoreController extends GetxController {
  UserStoreController();

  late Box _storage;
  // static UserStoreController get to => Get.find();

  Future<void> saveUserEmail(final String userEmail) async {
    _storage = await Hive.openBox<String>('userEmail');
    try {
      await _storage.clear();
    } catch (_) {}
    _storage = await Hive.openBox<String>('userEmail');
    await _storage.add(userEmail);
    await _storage.close();
  }

  Future<String?> getUserEmail() async {
    _storage = await Hive.openBox<String>('userEmail');
    try {
      return _storage.values.first;
    } catch (e) {
      return null;
    }
    // final tokenJson = _storage.values.first;
    // if (tokenJson == null) return null;
    // return UserModel.fromJson(tokenJson);
  }

  void logoutRemoveData() async {
    _storage = await Hive.openBox<UserModel>('userEmail');
    await _storage.clear();
    await _storage.close();
    final List<int> daysList = [1, 3, 7, 12, 13, 15, 26];
    for (var day in daysList) {
      final storage = await Hive.openBox<DaysModel>('days$day');
      await storage.clear();
      await storage.close();
    }
  }

  // @override
  // void onInit() async {
  // _storage = await Hive.openBox('userEmail');
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
