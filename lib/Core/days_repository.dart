import 'package:appwrite/appwrite.dart';
import 'package:hive/hive.dart';
import 'package:miracle/Components/appwrite_component.dart';
import 'package:miracle/Models/api_result.dart';
import 'package:miracle/Routes/server_routes.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:miracle/Models/days.dart';
import 'package:getxify/getxify.dart';

class DaysRepository {
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

  Future<bool> writeDayDataStorage({required DaysModel data}) async {
    final Box<DaysModel> storage = await Hive.openBox<DaysModel>(
      'days${data.dayNumber}',
    );
    await storage.add(data);
    return true;
  }

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

  Future<ApiResult<List<DaysModel>>> getDayDataServer({
    required int dayNumber,
  }) async {
    final globalController = Get.find<AuthController>();
    if (globalController.userData.value != null) {
      List<DaysModel> data = [];
      final tablesDB = TablesDB(AppwriteComponent.instance.client);

      final rows = await tablesDB.listRows(
        databaseId: ServerRoutes.databaseId,
        tableId: ServerRoutes.daysCollectionId,
        queries: [
          Query.equal(
            'user_id',
            globalController.userData.value!.$id.toString(),
          ),
          Query.equal('day_number', dayNumber),
        ],
      );

      for (var dayData in rows.rows) {
        DaysModel rawData = DaysModel.fromJson(dayData.data);

        // If image exists, download it from Storage
        if (rawData.imageId != null) {
          final storage = Storage(AppwriteComponent.instance.client);

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

  Future<ApiResult<DaysModel?>> writeDayDataServer({
    required DaysModel dayData,
  }) async {
    final globalController = Get.find<AuthController>();

    if (globalController.userData.value != null) {
      final tablesDB = TablesDB(AppwriteComponent.instance.client);

      final row = await tablesDB.createRow(
        databaseId: ServerRoutes.databaseId,
        tableId: ServerRoutes.daysCollectionId,
        rowId: ID.unique(),
        data: dayData.toForm(globalController.userData.value!.$id),
      );

      final data = DaysModel.fromJson(row.data);

      return ApiResult(resultData: data);
    } else {
      return ApiResult(resultData: null);
    }
  }

  Future<ApiResult<bool>> deleteDayDataServer({
    required String dataId,
    String? imageId,
  }) async {
    final globalController = Get.find<AuthController>();
    if (globalController.userData.value != null) {
      if (imageId != null) {
        final storage = Storage(AppwriteComponent.instance.client);
        await storage.deleteFile(
          bucketId: ServerRoutes.imagesCollectionId,
          fileId: imageId,
        );
      }
      final tablesDB = TablesDB(AppwriteComponent.instance.client);

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
