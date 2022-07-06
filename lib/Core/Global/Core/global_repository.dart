import 'package:file_picker/file_picker.dart';
import 'package:miracle/Core/Global/Models/api_result.dart';
import 'package:miracle/Core/Network/network_exceptions.dart';
import 'package:miracle/Core/Network/rest_client.dart';
import 'package:miracle/Core/Routes/server_routes.dart';

abstract class GlobalRepository {
  Future<ApiResult<String>> uploadFile({
    required final PlatformFile fileData,
  });
}

class GlobalRepositoryImp extends GlobalRepository {
  final RestClient _restClient = RestClient();

  @override
  Future<ApiResult<String>> uploadFile({required PlatformFile fileData}) async {
    var response = await _restClient.sendFile(
      fileData.bytes!.toList(),
      ServerRoutes.uploadFile,
      fileData.name,
    );
    String? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = response.resultData['id'];
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<String>(resultData: data, errorData: errorData);
    return result;
  }
}
