import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';
import 'package:miracle/Core/Global/Models/api_result.dart';
import 'package:miracle/Features/days/Models/days.dart';

abstract class GlobalRepository {
  Future<ApiResult<String>> uploadFile({
    required final PlatformFile fileData,
  });

  Future<bool?> getIsLightMode();

  Future<String?> getUserEmail();

  Future<bool> writeIsLightMode({required final bool data});

  Future<bool> writeUserEmail({required final String data});

  Future<bool> logoutRemoveData();
}

class GlobalRepositoryImp extends GlobalRepository {
  @override
  Future<ApiResult<String>> uploadFile({required PlatformFile fileData}) async {
    return ApiResult(resultData: "");
    //   var response = await _restClient.sendFile(
    //     fileData.bytes!.toList(),
    //     ServerRoutes.uploadFile,
    //     fileData.name,
    //   );
    //   String? data;
    //   NetworkExceptions? errorData;
    //   if (response.resultData != null) {
    //     data = response.resultData['id'];
    //   } else {
    //     errorData = response.errorData;
    //   }
    //   var result = ApiResult<String>(resultData: data, errorData: errorData);
    //   return result;
  }

  @override
  Future<bool?> getIsLightMode() async {
    try {
      final Box<bool> storage = await Hive.openBox<bool>('isLightMode');
      final result = storage.values.first;
      return result;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> writeIsLightMode({required bool data}) async {
    final Box<bool> storage = await Hive.openBox<bool>('isLightMode');
    try {
      await storage.clear();
    } catch (_) {}
    await storage.add(data);
    return true;
  }

  @override
  Future<String?> getUserEmail() async {
    try {
      final Box<String> storage = await Hive.openBox<String>('userEmail');
      final result = storage.values.first;
      return result;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> writeUserEmail({required String data}) async {
    final Box<String> storage = await Hive.openBox<String>('userEmail');
    try {
      await storage.clear();
    } catch (_) {}
    await storage.add(data);
    return true;
  }

  @override
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
