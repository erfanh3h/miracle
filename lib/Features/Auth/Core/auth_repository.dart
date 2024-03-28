import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Global/Models/api_result.dart';
import 'package:miracle/Core/Network/network_exceptions.dart';
import 'package:miracle/Core/Network/rest_client.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Core/Storage/user_storage_controller.dart';

abstract class AuthRepository {
  Future<ApiResult<bool>> enterPhone({
    required final String phone,
  });

  Future<ApiResult<bool>> register({
    required final String name,
    required final String email,
    required final String password,
  });

  Future<ApiResult<User>> login({
    required final String email,
    required final String password,
  });

  Future<ApiResult<User?>> getActiveUser();

  Future<bool> logout();
}

class AuthRepositoryImp extends AuthRepository {
  final RestClient _restClient = RestClient();
  @override
  Future<ApiResult<bool>> enterPhone({required String phone}) async {
    var response = await _restClient.sendData(
      ServerRoutes.enterPhone,
      data: {'phone': phone},
    );
    bool? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = response.resultData['status'];
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<bool>(resultData: data, errorData: errorData);
    return result;
  }

  @override
  Future<ApiResult<bool>> register({
    required final String name,
    required final String email,
    required final String password,
  }) async {
    Account account = Account(Get.find<GlobalController>().client);
    await account.create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: name,
    );
    return ApiResult(resultData: true);
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
  Future<ApiResult<User>> login({
    required final String email,
    required final String password,
  }) async {
    Account account = Account(Get.find<GlobalController>().client);
    await account.createEmailPasswordSession(email: email, password: password);
    final user = await account.get();
    return ApiResult(resultData: user);
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
  Future<ApiResult<User?>> getActiveUser() async {
    Account account = Account(Get.find<GlobalController>().client);
    try {
      final user = await account.get();
      return ApiResult(resultData: user);
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
    Get.offAllNamed(AppRoutes.main);
    Get.find<GlobalController>().changePage(0);
    return true;
  }
}
