import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';
import 'package:miracle/Core/Global/Models/api_result.dart';

abstract class GlobalRepository {
  Future<ApiResult<String>> uploadFile({
    required final PlatformFile fileData,
  });

  Future<bool?> getIsLightMode();

  Future<bool> writeIsLightMode({required final bool data});
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
}
