import 'package:get/get.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Global/Models/api_result.dart';
import 'package:miracle/Core/Global/Models/user_model.dart';
import 'package:miracle/Core/Network/network_exceptions.dart';
import 'package:miracle/Core/Network/rest_client.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Core/Storage/user_storage_controller.dart';

abstract class UserRepository {
  Future<ApiResult<UserModel>> changeUsername({
    required final String username,
  });
  Future<ApiResult<UserModel>> changeDayStatus({
    required final bool status,
  });
  Future<ApiResult<UserModel>> setUserImage({
    required final String imageId,
  });
  Future<ApiResult<UserModel>> deleteUserImage();
  Future<ApiResult<UserModel>> getUserData();
}

class UserRepositoryImp extends UserRepository {
  final RestClient _restClient = RestClient();
  @override
  Future<ApiResult<UserModel>> changeUsername(
      {required String username}) async {
    var response = await _restClient.sendData(
      ServerRoutes.changeUsername,
      formData: FormData({'username': username}),
    );
    UserModel? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      final storageController = Get.find<UserStoreController>();
      data = UserModel.fromJson(
        response.resultData['data'],
        Get.find<GlobalController>().user!.token!,
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
  Future<ApiResult<UserModel>> changeDayStatus({required bool status}) async {
    var response = await _restClient.sendData(
      ServerRoutes.changeDayStatus,
      formData: FormData({'status': status}),
    );
    UserModel? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      final storageController = Get.find<UserStoreController>();
      data = UserModel.fromJson(
        response.resultData['data'],
        Get.find<GlobalController>().user!.token!,
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
  Future<ApiResult<UserModel>> setUserImage({required String imageId}) async {
    var response = await _restClient.sendData(
      ServerRoutes.changeUserImage,
      formData: FormData({'image_id': imageId}),
    );
    UserModel? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      final storageController = Get.find<UserStoreController>();
      data = UserModel.fromJson(
        response.resultData['data'],
        Get.find<GlobalController>().user!.token!,
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
  Future<ApiResult<UserModel>> deleteUserImage() async {
    var response = await _restClient.deleteData(
      ServerRoutes.deleteUserImage,
    );
    UserModel? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      final storageController = Get.find<UserStoreController>();
      data = UserModel.fromJson(
        response.resultData['data'],
        Get.find<GlobalController>().user!.token!,
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
  Future<ApiResult<UserModel>> getUserData() async {
    var response = await _restClient.getData(ServerRoutes.selfUser);
    UserModel? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      final storageController = Get.find<UserStoreController>();
      data = UserModel.fromJson(
        response.resultData['data'],
        Get.find<GlobalController>().user!.token!,
      );
      Get.find<GlobalController>().user = data;
      storageController.saveUserData(data);
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<UserModel>(resultData: data, errorData: errorData);
    return result;
  }
}
