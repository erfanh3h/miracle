import 'package:hive/hive.dart';
import 'package:miracle/Core/Global/Models/api_result.dart';
import 'package:miracle/Core/Network/network_exceptions.dart';
import 'package:miracle/Core/Network/rest_client.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Features/days/Models/days.dart';

abstract class DaysRepository {
  Future<List<DaysModel>> getDayDataStorage({
    required final int dayNumber,
  });
  Future<bool> writeDayDataStorage({
    required final DaysModel data,
  });
  Future<bool> deleteDayDataStorage({
    required final int index,
    required final int dayNumber,
  });
  Future<ApiResult<List<DaysModel>>> getDayDataServer({
    required final int dayNumber,
  });
  Future<ApiResult<DaysModel>> writeDayDataServer({
    required final DaysModel dayData,
  });
  Future<ApiResult<bool>> deleteDayDataServer({
    required final int dataId,
  });
}

class DaysRepositoryImp extends DaysRepository {
  final RestClient _restClient = RestClient();
  @override
  Future<List<DaysModel>> getDayDataStorage({required int dayNumber}) async {
    final Box<DaysModel> storage =
        await Hive.openBox<DaysModel>('days$dayNumber');
    List<DaysModel> results = [];
    storage.values
        .where((item) => item.dayNumber == dayNumber)
        .forEach((data) => results.add(data));
    await storage.close();
    return results;
  }

  @override
  Future<bool> writeDayDataStorage({required DaysModel data}) async {
    final Box<DaysModel> storage =
        await Hive.openBox<DaysModel>('days${data.dayNumber}');
    await storage.add(data);
    await storage.close();
    return true;
  }

  @override
  Future<bool> deleteDayDataStorage({
    required int index,
    required int dayNumber,
  }) async {
    final Box<DaysModel> storage =
        await Hive.openBox<DaysModel>('days$dayNumber');
    await storage.deleteAt(index);
    await storage.close();
    return true;
  }

  @override
  Future<ApiResult<List<DaysModel>>> getDayDataServer(
      {required int dayNumber}) async {
    var response =
        await _restClient.getData(ServerRoutes.getDays(dayNumber.toString()));
    List<DaysModel>? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = [];
      for (var dayData in response.resultData) {
        data.add(DaysModel.fromJson(dayData));
      }
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<List<DaysModel>>(
      resultData: data,
      errorData: errorData,
    );
    return result;
  }

  @override
  Future<ApiResult<DaysModel>> writeDayDataServer(
      {required DaysModel dayData}) async {
    var response = await _restClient.sendData(ServerRoutes.saveDays,
        formData: dayData.toForm());
    DaysModel? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = DaysModel.fromJson(response.resultData['data']);
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<DaysModel>(resultData: data, errorData: errorData);
    return result;
  }

  @override
  Future<ApiResult<bool>> deleteDayDataServer({required int dataId}) async {
    var response =
        await _restClient.deleteData(ServerRoutes.editDays(dataId.toString()));
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
