import 'package:get/get.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Global/Models/api_result.dart';
import 'package:miracle/Core/Global/Models/user_model.dart';
import 'package:miracle/Core/Network/network_exceptions.dart';
import 'package:miracle/Core/Network/rest_client.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Core/Storage/user_storage_controller.dart';

abstract class AuthRepository {
  Future<ApiResult<bool>> enterPhone({
    required final String phone,
  });
  Future<ApiResult<UserModel>> sendCode({
    required final String phone,
    required final String code,
  });

  Future<bool> logout();
}

class AuthRepositoryImp extends AuthRepository {
  final RestClient _restClient = RestClient();
  @override
  Future<ApiResult<bool>> enterPhone({required String phone}) async {
    var response = await _restClient.sendData(
      ServerRoutes.enterPhone,
      formData: FormData({'phone': phone}),
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
  Future<ApiResult<UserModel>> sendCode(
      {required String code, required String phone}) async {
    var response = await _restClient.sendData(
      ServerRoutes.sendCode,
      formData: FormData({'phone': phone, 'code': code}),
    );
    UserModel? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      final storageController = Get.find<UserStoreController>();
      data = UserModel.fromJson(
        response.resultData['data'],
        response.resultData['token'],
      );
      Get.find<GlobalController>().user = data;
      storageController.saveUserData(data);
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<UserModel>(resultData: data, errorData: errorData);
    return result;
  }

  @override
  Future<bool> logout() async {
    Get.find<GlobalController>().user = null;
    final storageController = Get.find<UserStoreController>();
    storageController.removeData();
    return true;
  }
}
