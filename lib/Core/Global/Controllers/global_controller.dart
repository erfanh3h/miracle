import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Global/Models/user_model.dart';
import 'package:miracle/Core/Storage/user_storage_controller.dart';

class GlobalController extends GetxController {
  var selectedPage = 0.obs;
  changePage(int page) => selectedPage.value = page;
  PageController pgCtrl = PageController();
  final Rx<UserModel?> _user = Rx(null);
  UserModel? get user => _user.value;
  set user(UserModel? userData) {
    _user.value = userData;
  }

  String get token => _user.value != null ? (_user.value!.token ?? '') : '';

  bool get syncData =>
      _user.value != null ? (_user.value!.saveDayDatas ?? false) : false;

  Future<bool> fetchUserData() async {
    final storageController = Get.find<UserStoreController>();
    _user.value = await storageController.getUserData();
    if (_user.value != null && _user.value!.token != null) {
      // if user haven any username he most go profile page
      if ((_user.value!.username ?? '') == '') {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
