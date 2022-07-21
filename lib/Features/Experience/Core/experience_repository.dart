import 'package:miracle/Core/Global/Models/api_result.dart';
import 'package:miracle/Core/Network/network_exceptions.dart';
import 'package:miracle/Core/Network/rest_client.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Features/Experience/Models/experience.dart';

abstract class ExperienceRepository {
  Future<ApiResult<List<ExperienceModel>>> getExperiencesList({
    required final int page,
  });
  Future<ApiResult<ExperienceModel>> sendExperience({
    required final ExperienceModel experienceData,
  });
  Future<ApiResult<bool>> deleteExperience({
    required final int dataId,
  });
}

class ExperienceRepositoryImp extends ExperienceRepository {
  final RestClient _restClient = RestClient();

  @override
  Future<ApiResult<List<ExperienceModel>>> getExperiencesList(
      {required int page}) async {
    var response = await _restClient.getData(ServerRoutes.getExperiences(page));
    List<ExperienceModel>? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = [];
      for (var experienceData in response.resultData) {
        data.add(ExperienceModel.fromJson(experienceData));
      }
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<List<ExperienceModel>>(
      resultData: data,
      errorData: errorData,
    );
    return result;
  }

  @override
  Future<ApiResult<ExperienceModel>> sendExperience(
      {required ExperienceModel experienceData}) async {
    var response = await _restClient.sendData(ServerRoutes.sendExperience,
        formData: experienceData.toForm());
    ExperienceModel? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = ExperienceModel.fromJson(response.resultData['data']);
    } else {
      errorData = response.errorData;
    }
    var result =
        ApiResult<ExperienceModel>(resultData: data, errorData: errorData);
    return result;
  }

  @override
  Future<ApiResult<bool>> deleteExperience({required int dataId}) async {
    var response = await _restClient
        .deleteData(ServerRoutes.deleteExperience(dataId.toString()));
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
}