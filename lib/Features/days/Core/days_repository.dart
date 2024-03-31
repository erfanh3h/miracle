import 'package:appwrite/appwrite.dart';
import 'package:hive/hive.dart';
import 'package:miracle/Core/Global/Models/api_result.dart';
import 'package:miracle/Features/days/Models/days.dart';
import 'package:refreshed/refreshed.dart';

import '../../../Core/Global/Controllers/global_controller.dart';

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
    required final String dataId,
  });
}

class DaysRepositoryImp extends DaysRepository {
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
    final globalController = Get.find<GlobalController>();
    if (globalController.user != null) {
      List<DaysModel> data = [];
      final databases = Databases(globalController.client);
      final documents = await databases.listDocuments(
          databaseId: '6605581e48c5cfa0587e',
          collectionId: '66055938c5a78f03cb7d',
          queries: [
            // Query.equal('title', 'Avatar')
          ]);
      for (var dayData in documents.documents.toList()) {
        data.add(DaysModel.fromJson(dayData.data));
        print('object');
      }
      return ApiResult(resultData: data);
    } else {
      return ApiResult(resultData: []);
    }

    // var response =
    //     await _restClient.getData(ServerRoutes.getDays(dayNumber.toString()));
    // List<DaysModel>? data;
    // NetworkExceptions? errorData;
    // if (response.resultData != null) {
    //   data = [];
    //   for (var dayData in response.resultData) {
    //     data.add(DaysModel.fromJson(dayData));
    //   }
    // } else {
    //   errorData = response.errorData;
    // }
    // var result = ApiResult<List<DaysModel>>(
    //   resultData: data,
    //   errorData: errorData,
    // );
    // return result;
  }

  @override
  Future<ApiResult<DaysModel>> writeDayDataServer(
      {required DaysModel dayData}) async {
    return ApiResult(resultData: DaysModel(dayNumber: 1));
    // var response = await _restClient.sendData(ServerRoutes.saveDays,
    //     data: dayData.toForm());
    // DaysModel? data;
    // NetworkExceptions? errorData;
    // if (response.resultData != null) {
    //   data = DaysModel.fromJson(response.resultData['data']);
    // } else {
    //   errorData = response.errorData;
    // }
    // var result = ApiResult<DaysModel>(resultData: data, errorData: errorData);
    // return result;
  }

  @override
  Future<ApiResult<bool>> deleteDayDataServer({required String dataId}) async {
    return ApiResult(resultData: true);
    // var response =
    //     await _restClient.deleteData(ServerRoutes.editDays(dataId.toString()));
    // bool? data;
    // NetworkExceptions? errorData;
    // if (response.resultData != null) {
    //   data = response.resultData['status'];
    // } else {
    //   errorData = response.errorData;
    // }
    // var result = ApiResult<bool>(resultData: data, errorData: errorData);
    // return result;
  }
}
