import 'package:flutter/cupertino.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Features/Auth/Core/auth_repository.dart';

class EntryController extends BaseController {
  final AuthRepository _repo;
  EntryController(this._repo);

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  RxBool isLogin = RxBool(true);
  RxBool isRequesting = RxBool(false);

  final registerKey = GlobalKey<FormState>();
  final loginKey = GlobalKey<FormState>();

  register() async {
    if (!registerKey.currentState!.validate()) return;
    isRequesting.value = true;
    var response = await _repo.register(
      name: nameCtrl.text,
      email: emailCtrl.text,
      password: passwordCtrl.text,
    );
    if (response.resultData != null) {
      isLogin.value = true;
    } else {}
    isRequesting.value = false;
  }

  login() async {
    if (!loginKey.currentState!.validate()) return;
    isRequesting.value = true;
    var response = await _repo.login(
      email: emailCtrl.text,
      password: passwordCtrl.text,
    );
    if (response.resultData != null) {
      isLogin.value = true;
    } else {}
    isRequesting.value = false;
  }

  changeIsLogin(bool value) {
    isLogin.value = value;
  }
}
