import 'package:appwrite/appwrite.dart';
import 'package:miracle/Components/appwrite_component.dart';
import 'package:miracle/Models/api_result.dart';
import 'package:miracle/Models/delneveshteh_model.dart';
import 'package:miracle/Routes/server_routes.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:getxify/getxify.dart';

class DelneveshtehRepository {
  Future<ApiResult<List<DelneveshtehModel>>> getDataServer({
    required int dayNumber,
  }) async {
    final globalController = Get.find<AuthController>();
    if (globalController.userData.value != null) {
      List<DelneveshtehModel> data = [];
      final tablesDB = TablesDB(AppwriteComponent.instance.client);

      final rows = await tablesDB.listRows(
        databaseId: ServerRoutes.databaseId,
        tableId: ServerRoutes.delneveshtehCollectionId,
        // queries: [
        //   Query.equal(
        //     'user_id',
        //     globalController.userData.value!.$id.toString(),
        //   ),
        //   Query.equal('day_number', dayNumber),
        // ],
      );

      for (var delData in rows.rows) {
        DelneveshtehModel rawData = DelneveshtehModel.fromJson(delData.data);
        data.add(rawData);
      }
      return ApiResult(resultData: data);
    } else {
      return ApiResult(resultData: []);
    }

    // var response =
    //     await _restClient.getData(ServerRoutes.getDays(dayNumber.toString()));
    // List<DelneveshtehModel>? data;
    // NetworkExceptions? errorData;
    // if (response.resultData != null) {
    //   data = [];
    //   for (var delData in response.resultData) {
    //     data.add(DelneveshtehModel.fromJson(delData));
    //   }
    // } else {
    //   errorData = response.errorData;
    // }
    // var result = ApiResult<List<DelneveshtehModel>>(
    //   resultData: data,
    //   errorData: errorData,
    // );
    // return result;
  }

  Future<ApiResult<DelneveshtehModel?>> writeDataServer({
    required DelneveshtehModel delData,
  }) async {
    final globalController = Get.find<AuthController>();

    if (globalController.userData.value != null) {
      final tablesDB = TablesDB(AppwriteComponent.instance.client);

      final row = await tablesDB.createRow(
        databaseId: ServerRoutes.databaseId,
        tableId: ServerRoutes.delneveshtehCollectionId,
        rowId: ID.unique(),
        data: delData.toJson(),
      );

      final data = DelneveshtehModel.fromJson(row.data);

      return ApiResult(resultData: data);
    } else {
      return ApiResult(resultData: null);
    }
  }

  Future<ApiResult<bool>> deletedelDataServer({
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
        tableId: ServerRoutes.delneveshtehCollectionId,
        rowId: dataId,
      );
      return ApiResult(resultData: true);
    } else {
      return ApiResult(resultData: null);
    }
  }
  // Future<List<DelneveshtehModel>> getdelDataStorage({required int dayNumber}) async {
  //   final Box<DelneveshtehModel> storage = await Hive.openBox<DelneveshtehModel>(
  //     'days$dayNumber',
  //   );
  //   List<DelneveshtehModel> results = [];
  //   storage.values
  //       .where((item) => item.dayNumber == dayNumber)
  //       .forEach((data) => results.add(data));
  //   await storage.close();
  //   return results;
  // }

  // Future<bool> writedelDataStorage({required DelneveshtehModel data}) async {
  //   final Box<DelneveshtehModel> storage = await Hive.openBox<DelneveshtehModel>(
  //     'days${data.dayNumber}',
  //   );
  //   await storage.add(data);
  //   return true;
  // }

  // Future<bool> deletedelDataStorage({
  //   required int index,
  //   required int dayNumber,
  // }) async {
  //   final Box<DelneveshtehModel> storage = await Hive.openBox<DelneveshtehModel>(
  //     'days$dayNumber',
  //   );
  //   await storage.deleteAt(index);
  //   await storage.close();
  //   return true;
  // }
}
