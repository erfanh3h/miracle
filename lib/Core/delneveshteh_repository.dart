import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:miracle/Components/appwrite_component.dart';
import 'package:miracle/Models/api_result.dart';
import 'package:miracle/Models/delneveshteh_model.dart';
import 'package:miracle/Routes/server_routes.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:getxify/getxify.dart';

class DelneveshtehRepository {
  Future<ApiResult<List<DelneveshtehModel>>> getDelneveshtehList({
    String? categoryId,
    int limit = 20,
    String? cursorAfter,
  }) async {
    try {
      final tablesDB = TablesDB(AppwriteComponent.instance.client);

      final queries = <String>[
        Query.limit(limit),
        Query.orderDesc('\$createdAt'),
        Query.equal('confirmed', true),
      ];

      if (categoryId != null && categoryId.isNotEmpty) {
        queries.add(Query.equal('category_id', categoryId));
      }

      if (cursorAfter != null && cursorAfter.isNotEmpty) {
        queries.add(Query.cursorAfter(cursorAfter));
      }

      final response = await tablesDB.listRows(
        databaseId: ServerRoutes.databaseId,
        tableId: ServerRoutes.delneveshtehCollectionId,
        queries: queries,
      );

      final result = response.rows
          .map((row) => DelneveshtehModel.fromJson(row.data))
          .toList();

      return ApiResult(resultData: result);
    } catch (e) {
      return ApiResult(resultData: null);
    }
  }

  Future<ApiResult<DelneveshtehModel?>> writeDataServer({
    required DelneveshtehModel delData,
  }) async {
    final globalController = Get.find<AuthController>();

    try {
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
      } else {}
    } catch (_) {}
    return ApiResult(resultData: null);
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

  Future<ApiResult<bool>> toggleDelneveshteLike({required String delId}) async {
    try {
      final functions = Functions(AppwriteComponent.instance.client);

      final execution = await functions.createExecution(
        functionId: ServerRoutes.mainFunctionId,
        body: jsonEncode({
          'action': 'like',
          'data': {'del_id': delId},
        }),
        xasync: false,
      );

      final response = jsonDecode(execution.responseBody);

      if (response['success'] == true) {
        return ApiResult(resultData: response['liked'] == true);
      }

      return ApiResult(resultData: null);
    } catch (e) {
      return ApiResult(resultData: null);
    }
  }

  Future<ApiResult<bool>> isDelneveshteLiked({required String delId}) async {
    try {
      final functions = Functions(AppwriteComponent.instance.client);

      final execution = await functions.createExecution(
        functionId: ServerRoutes.mainFunctionId,
        body: jsonEncode({
          'action': 'check_like',
          'data': {'del_id': delId},
        }),
        xasync: false,
      );

      final response = jsonDecode(execution.responseBody);

      if (response['success'] == true) {
        return ApiResult(resultData: response['liked'] == true);
      }

      return ApiResult(resultData: null);
    } catch (e) {
      return ApiResult(resultData: null);
    }
  }
}
