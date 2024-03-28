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
  RxBool codeSended = RxBool(false);

  final phoneKey = GlobalKey<FormState>();
  final codeKey = GlobalKey<FormState>();

  createAccount() async {
    if (!phoneKey.currentState!.validate()) return;
    isPageLoading.value = true;
    var response = await _repo.enterPhone(phone: emailCtrl.text);
    if (response.resultData != null) {
      codeSended.value = true;
    } else {}
    isPageLoading.value = false;
  }

  submitCode() async {}
}
