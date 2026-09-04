import 'package:appwrite/appwrite.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';
import 'package:miracle/Components/appwrite_component.dart';
import 'package:miracle/Models/api_result.dart';
import 'package:miracle/Routes/server_routes.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:miracle/Models/days.dart';
import 'package:getxify/getxify.dart';

class GlobalRepository {
  Future<ApiResult<String?>> uploadFile({
    required PlatformFile fileData,
  }) async {
    final globalController = Get.find<AuthController>();
    final bytes = await fileData.xFile.readAsBytes();
    if (globalController.userData.value != null) {
      final storage = Storage(AppwriteComponent.instance.client);
      final file = await storage.createFile(
        bucketId: ServerRoutes.imagesCollectionId,
        fileId: ID.unique(),
        file: InputFile.fromBytes(
          bytes: bytes.toList(),
          filename: fileData.name,
        ),
      );
      return ApiResult(resultData: file.$id);
    } else {
      return ApiResult(resultData: null);
    }
  }

  Future<bool?> getIsLightMode() async {
    try {
      final Box<bool> storage = await Hive.openBox<bool>('isLightMode');
      final result = storage.values.first;
      return result;
    } catch (_) {
      return null;
    }
  }

  Future<bool> writeIsLightMode({required bool data}) async {
    final Box<bool> storage = await Hive.openBox<bool>('isLightMode');
    try {
      await storage.clear();
    } catch (_) {}
    await storage.add(data);
    return true;
  }

  Future<String?> getUserEmail() async {
    try {
      final Box<String> storage = await Hive.openBox<String>('userEmail');
      final result = storage.values.first;
      return result;
    } catch (_) {
      return null;
    }
  }

  Future<bool> writeUserEmail({required String data}) async {
    final Box<String> storage = await Hive.openBox<String>('userEmail');
    try {
      await storage.clear();
    } catch (_) {}
    await storage.add(data);
    return true;
  }

  Future<bool> logoutRemoveData() async {
    final storage = await Hive.openBox<String>('userEmail');
    await storage.clear();
    await storage.close();
    final List<int> daysList = [1, 3, 7, 12, 13, 15, 26];
    for (var day in daysList) {
      final storage = await Hive.openBox<DaysModel>('days$day');
      await storage.clear();
      await storage.close();
    }
    return true;
  }
}
