import 'dart:developer';
import 'dart:typed_data';

import 'package:appwrite/models.dart' as models;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:miracle/Components/appwrite_component.dart';
import 'package:miracle/Components/dialog_component.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Models/api_result.dart';
import 'package:miracle/Routes/app_routes.dart';
import 'package:miracle/Routes/server_routes.dart';

// Keep your existing imports for these — unchanged from the old file:
// GlobalController, ApiResult, DialogCompanent, AppRoutes

class AuthRepository {
  Future<ApiResult<bool>> loginWithGoogle() async {
    try {
      Account account = Account(AppwriteComponent.instance.client);
      await account.createOAuth2Session(provider: OAuthProvider.google);
      return ApiResult(resultData: true);
    } catch (e) {
      DialogCompanent.showToast(label: "ورود با گوگل ناموفق بود!");
      return ApiResult(resultData: false);
    }
  }

  Future<ApiResult<models.User?>> getActiveUser() async {
    Account account = Account(AppwriteComponent.instance.client);
    try {
      final user = await account.get();
      log(user.toMap().toString());
      return ApiResult(resultData: user);
    } catch (_) {
      return ApiResult(resultData: null);
    }
  }

  Future<bool> logout() async {
    Account account = Account(AppwriteComponent.instance.client);
    await account.deleteSession(sessionId: 'current');
    Get.offAllNamed(AppRoutes.main);
    return true;
  }

  Future<ApiResult<bool>> updateName({required String name}) async {
    try {
      Account account = Account(AppwriteComponent.instance.client);
      await account.updateName(name: name);
      return ApiResult(resultData: true);
    } catch (e) {
      DialogCompanent.showToast(label: "تغییر نام ناموفق بود!");
      return ApiResult(resultData: false);
    }
  }

  Future<ApiResult<String?>> updateAvatar({
    required String filePath,
    required String filename,
  }) async {
    try {
      Account account = Account(AppwriteComponent.instance.client);
      Storage storage = Storage(AppwriteComponent.instance.client);

      final file = await storage.createFile(
        bucketId: ServerRoutes.appwriteImageBucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: filePath, filename: filename),
        permissions: [Permission.read(Role.any())],
      );

      // Remember which file is the current avatar via prefs.
      final user = await account.get();
      final prefs = Map<String, dynamic>.from(user.prefs.data)
        ..['avatarFileId'] = file.$id;
      await account.updatePrefs(prefs: prefs);

      return ApiResult(resultData: file.$id);
    } catch (e) {
      DialogCompanent.showToast(label: "تغییر عکس پروفایل ناموفق بود!");
      return ApiResult(resultData: null);
    }
  }

  Future<ApiResult<bool>> updateCurrentDay({required int day}) async {
    try {
      Account account = Account(AppwriteComponent.instance.client);
      final user = await account.get();
      final prefs = Map<String, dynamic>.from(user.prefs.data)
        ..['currentDay'] = day;
      await account.updatePrefs(prefs: prefs);

      return ApiResult(resultData: true);
    } catch (e) {
      log(e.toString());
      DialogCompanent.showToast(label: "تکمیل روز ناموفق بود!");
      return ApiResult(resultData: false);
    }
  }

  Future<ApiResult<Uint8List?>> getAvatarBytes() async {
    try {
      Account account = Account(AppwriteComponent.instance.client);
      Storage storage = Storage(AppwriteComponent.instance.client);
      Avatars avatars = Avatars(AppwriteComponent.instance.client);

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
