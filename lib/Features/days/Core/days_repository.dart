import 'package:appwrite/appwrite.dart';
import 'package:hive/hive.dart';
import 'package:miracle/Core/Global/Models/api_result.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Features/days/Models/days.dart';
import 'package:getxify/getxify.dart';

import '../../../Core/Global/Controllers/global_controller.dart';

abstract class DaysRepository {
  Future<List<DaysModel>> getDayDataStorage({required int dayNumber});
  Future<bool> writeDayDataStorage({required DaysModel data});
  Future<bool> deleteDayDataStorage({
    required int index,
    required int dayNumber,
  });
  Future<ApiResult<List<DaysModel>>> getDayDataServer({required int dayNumber});
  Future<ApiResult<DaysModel?>> writeDayDataServer({
    required DaysModel dayData,
  });
  Future<ApiResult<bool>> deleteDayDataServer({
    required String dataId,
    String? imageId,
  });
}

class DaysRepositoryImp extends DaysRepository {
  @override
  Future<List<DaysModel>> getDayDataStorage({required int dayNumber}) async {
    final Box<DaysModel> storage = await Hive.openBox<DaysModel>(
      'days$dayNumber',
    );
    List<DaysModel> results = [];
    storage.values
        .where((item) => item.dayNumber == dayNumber)
        .forEach((data) => results.add(data));
    await storage.close();
    return results;
  }

  @override
  Future<bool> writeDayDataStorage({required DaysModel data}) async {
    final Box<DaysModel> storage = await Hive.openBox<DaysModel>(
      'days${data.dayNumber}',
    );
    await storage.add(data);
    return true;
  }

  @override
  Future<bool> deleteDayDataStorage({
    required int index,
    required int dayNumber,
  }) async {
    final Box<DaysModel> storage = await Hive.openBox<DaysModel>(
      'days$dayNumber',
    );
    await storage.deleteAt(index);
    await storage.close();
    return true;
  }

  @override
  Future<ApiResult<List<DaysModel>>> getDayDataServer({
    required int dayNumber,
  }) async {
    final globalController = Get.find<GlobalController>();
    if (globalController.userId != null) {
      List<DaysModel> data = [];
      final tablesDB = TablesDB(globalController.client);

      final rows = await tablesDB.listRows(
        databaseId: ServerRoutes.databaseId,
        tableId: ServerRoutes.daysCollectionId,
        queries: [
          Query.equal('user_id', globalController.userId!.toString()),
          Query.equal('day_number', dayNumber),
        ],
      );

      for (var dayData in rows.rows) {
        DaysModel rawData = DaysModel.fromJson(dayData.data);

        // If image exists, download it from Storage
        if (rawData.imageId != null) {
          final storage = Storage(globalController.client);

          final imageData = await storage.getFileDownload(
            bucketId: ServerRoutes.imagesCollectionId,
            fileId: rawData.imageId!,
          );

          rawData = rawData.copyWith(image: imageData);
        }

        data.add(rawData);
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
  Future<ApiResult<DaysModel?>> writeDayDataServer({
    required DaysModel dayData,
  }) async {
    final globalController = Get.find<GlobalController>();

    if (globalController.userId != null) {
      final tablesDB = TablesDB(globalController.client);

      final row = await tablesDB.createRow(
        databaseId: ServerRoutes.databaseId,
        tableId: ServerRoutes.daysCollectionId,
        rowId: ID.unique(),
        data: dayData.toForm(globalController.userId!),
      );

      final data = DaysModel.fromJson(row.data);

      return ApiResult(resultData: data);
    } else {
      return ApiResult(resultData: null);
    }
  }

  @override
  Future<ApiResult<bool>> deleteDayDataServer({
    required String dataId,
    String? imageId,
  }) async {
    final globalController = Get.find<GlobalController>();
    if (globalController.userId != null) {
      if (imageId != null) {
        final storage = Storage(globalController.client);
        await storage.deleteFile(
          bucketId: ServerRoutes.imagesCollectionId,
          fileId: imageId,
        );
      }
      final tablesDB = TablesDB(globalController.client);

      await tablesDB.deleteRow(
        databaseId: ServerRoutes.databaseId,
        tableId: ServerRoutes.daysCollectionId,
        rowId: dataId,
      );
      return ApiResult(resultData: true);
    } else {
      return ApiResult(resultData: null);
    }
  }
}
