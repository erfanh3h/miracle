import 'package:appwrite/appwrite.dart';
import 'package:miracle/Core/Components/show_message.dart';
import 'package:miracle/Core/Global/Models/user_model.dart';
import 'package:miracle/Core/Resources/app_error_texts.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Global/Models/api_result.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Core/Storage/user_storage_controller.dart';

abstract class AuthRepository {
  Future<ApiResult<bool>> register({
    required final String name,
    required final String email,
    required final String password,
  });

  Future<ApiResult<bool>> login({
    required final String email,
    required final String password,
  });

  Future<ApiResult<UserModel?>> getActiveUser();

  Future<bool> logout();
}

class AuthRepositoryImp extends AuthRepository {

  @override
  Future<ApiResult<bool>> register({
    required final String name,
    required final String email,
    required final String password,
  }) async {
    Account account = Account(Get.find<GlobalController>().client);
    try {
      await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      return ApiResult(resultData: true);
    } catch (e) {
      if (e.toString().contains(AppErrorTexts.userExists)) {
        ShowMessageCompanent(message: "نام کاربری قبلا ثبت شده است!").show();
      }
      return ApiResult(resultData: false);
    }

    // bool? data;
    // NetworkExceptions? errorData;
    // if (response.resultData != null) {
    //   data = response.resultData['status'];
    // } else {
    //   errorData = response.errorData;
    // }
    // var result = ApiResult<bool>(resultData: data, errorData: errorData);
    // return result;
  }

  @override
  Future<ApiResult<bool>> login({
    required final String email,
    required final String password,
  }) async {
    try {
      Account account = Account(Get.find<GlobalController>().client);
      await account.createEmailPasswordSession(
          email: email, password: password);
      return ApiResult(resultData: true);
    } catch (e) {
      if (e.toString().contains(AppErrorTexts.invalidLogin)) {
        ShowMessageCompanent(message: "نام کاربری یا رمز عبور نادرست است!")
            .show();
      }
      return ApiResult(resultData: null);
    }

    // bool? data;
    // NetworkExceptions? errorData;
    // if (response.resultData != null) {
    //   data = response.resultData['status'];
    // } else {
    //   errorData = response.errorData;
    // }
    // var result = ApiResult<bool>(resultData: data, errorData: errorData);
    // return result;
  }

  @override
  Future<ApiResult<UserModel?>> getActiveUser() async {
    Account account = Account(Get.find<GlobalController>().client);
    try {
      final user = await account.getSession(sessionId: 'current');
      print(user.userId);
      final UserModel userData = UserModel(id: user.$id, name: user.userId);
      return ApiResult(resultData: userData);
    } catch (_) {
      return ApiResult(resultData: null);
    }
    // bool? data;
    // NetworkExceptions? errorData;
    // if (response.resultData != null) {
    //   data = response.resultData['status'];
    // } else {
    //   errorData = response.errorData;
    // }
    // var result = ApiResult<bool>(resultData: data, errorData: errorData);
    // return result;
  }

  @override
  Future<bool> logout() async {
    Get.find<GlobalController>().user = null;
    final storageController = Get.find<UserStoreController>();
    storageController.removeData();
    Account account = Account(Get.find<GlobalController>().client);
    await account.deleteSessions();
    Get.offAllNamed(AppRoutes.main);
    return true;
  }
}
