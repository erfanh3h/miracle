import 'dart:developer';
import 'dart:typed_data';

import 'package:appwrite/models.dart' as models;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:miracle/Core/Components/dialog_component.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Global/Models/api_result.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Core/Routes/server_routes.dart';

// Keep your existing imports for these — unchanged from the old file:
// GlobalController, ApiResult, DialogCompanent, AppRoutes

abstract class AuthRepository {
  Future<ApiResult<bool>> loginWithGoogle();

  Future<ApiResult<models.User?>> getActiveUser();
  Future<bool> logout();

  Future<ApiResult<bool>> updateName({required String name});

  Future<ApiResult<bool>> updateAvatar({
    required String filePath,
    required String filename,
  });

  Future<ApiResult<Uint8List?>> getAvatarBytes();
}

class AuthRepositoryImp extends AuthRepository {
  @override
  Future<ApiResult<bool>> loginWithGoogle() async {
    try {
      final globalController = Get.find<GlobalController>();
      Account account = Account(globalController.client);
      await account.createOAuth2Session(provider: OAuthProvider.google);
      return ApiResult(resultData: true);
    } catch (e) {
      DialogCompanent.showToast(label: "ورود با گوگل ناموفق بود!");
      return ApiResult(resultData: false);
    }
  }

  @override
  Future<ApiResult<models.User?>> getActiveUser() async {
    Account account = Account(Get.find<GlobalController>().client);
    try {
      final user = await account.get();

      log(user.toMap().toString());
      return ApiResult(resultData: user);
    } catch (_) {
      return ApiResult(resultData: null);
    }
  }

  @override
  Future<bool> logout() async {
    Get.find<GlobalController>().userData.value = null;
    Account account = Account(Get.find<GlobalController>().client);
    await account.deleteSession(sessionId: 'current');
    Get.offAllNamed(AppRoutes.main);
    return true;
  }

  @override
  Future<ApiResult<bool>> updateName({required String name}) async {
    try {
      final globalController = Get.find<GlobalController>();
      Account account = Account(globalController.client);
      await account.updateName(name: name);
      return ApiResult(resultData: true);
    } catch (e) {
      DialogCompanent.showToast(label: "تغییر نام ناموفق بود!");
      return ApiResult(resultData: false);
    }
  }

  @override
  Future<ApiResult<bool>> updateAvatar({
    required String filePath,
    required String filename,
  }) async {
    try {
      final globalController = Get.find<GlobalController>();
      Account account = Account(globalController.client);
      Storage storage = Storage(globalController.client);

      final file = await storage.createFile(
        bucketId: ServerRoutes.appwriteImageBucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: filePath, filename: filename),
      );

      // Remember which file is the current avatar via prefs.
      final user = await account.get();
      final prefs = Map<String, dynamic>.from(user.prefs.data)
        ..['avatarFileId'] = file.$id;
      await account.updatePrefs(prefs: prefs);

      return ApiResult(resultData: true);
    } catch (e) {
      DialogCompanent.showToast(label: "تغییر عکس پروفایل ناموفق بود!");
      return ApiResult(resultData: false);
    }
  }

  @override
  Future<ApiResult<Uint8List?>> getAvatarBytes() async {
    try {
      final globalController = Get.find<GlobalController>();
      Account account = Account(globalController.client);
      Storage storage = Storage(globalController.client);
      Avatars avatars = Avatars(globalController.client);

      final user = await account.get();
      final fileId = user.prefs.data['avatarFileId'] as String?;

      final bytes = fileId != null
          ? await storage.getFilePreview(
              bucketId: ServerRoutes.appwriteImageBucketId,
              fileId: fileId,
              width: 200,
              height: 200,
            )
          : await avatars.getInitials(name: user.name, width: 200, height: 200);

      return ApiResult(resultData: bytes);
    } catch (_) {
      return ApiResult(resultData: null);
    }
  }
}
