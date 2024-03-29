import 'package:file_picker/file_picker.dart';
import 'package:miracle/Core/Global/Models/api_result.dart';

abstract class GlobalRepository {
  Future<ApiResult<String>> uploadFile({
    required final PlatformFile fileData,
  });
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
}
