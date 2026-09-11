import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:miracle/Components/appwrite_component.dart';
import 'package:miracle/Models/api_result.dart';
import 'package:miracle/Resources/app_consts.dart';
import 'package:miracle/Routes/server_routes.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:miracle/Models/review.dart';
import 'package:getxify/getxify.dart';

class ReviewRepository {
  Future<ApiResult<bool>> sendReview({required ReviewModel reviewData}) async {
    final globalController = Get.find<AuthController>();

    if (globalController.userData.value == null) {
      return ApiResult(resultData: null);
    }

    // try {
    final functions = Functions(AppwriteComponent.instance.client);

    final execution = await functions.createExecution(
      functionId: ServerRoutes.appwriteFunctionsId,
      body: jsonEncode({'action': 'review', 'data': reviewData.toForm()}),
    );

    final response = jsonDecode(execution.responseBody);

    if (response['success'] == true) {
      return ApiResult(resultData: true);
    }

    return ApiResult(resultData: null);
    // } catch (e) {
    //   print('Send review error: $e');

    //   return ApiResult(resultData: null);
    // }
  }

  Future<ApiResult<bool>> sendAppReview({
    required ReviewModel reviewData,
  }) async {
    final globalController = Get.find<AuthController>();

    if (globalController.userData.value != null) {
      final tablesDB = TablesDB(AppwriteComponent.instance.client);

      await tablesDB.createRow(
        databaseId: ServerRoutes.databaseId,
        tableId: ServerRoutes.reviewCollectionId,
        rowId: ID.unique(),
        data: reviewData.toForm(),
      );

      return ApiResult(resultData: true);
    } else {
      return ApiResult(resultData: null);
    }
  }

  Future<ApiResult<List<ReviewModel>>> readReviews({
    required String targetId,
    String targetType = ReviewTypes.delneveshteh,
  }) async {
    final globalController = Get.find<AuthController>();
    if (globalController.userData.value != null) {
      List<ReviewModel> data = [];
      final tablesDB = TablesDB(AppwriteComponent.instance.client);

      final rows = await tablesDB.listRows(
        databaseId: ServerRoutes.databaseId,
        tableId: ServerRoutes.reviewCollectionId,
        queries: [
          Query.equal('target_type', targetType),
          Query.equal('target_id', targetId),
        ],
      );

      for (var delData in rows.rows) {
        ReviewModel rawData = ReviewModel.fromJson(delData.data);
        data.add(rawData);
      }
      return ApiResult(resultData: data);
    } else {
      return ApiResult(resultData: []);
    }

    // var response =
    //     await _restClient.getData(ServerRoutes.getDays(dayNumber.toString()));
    // List<ReviewModel>? data;
    // NetworkExceptions? errorData;
    // if (response.resultData != null) {
    //   data = [];
    //   for (var delData in response.resultData) {
    //     data.add(ReviewModel.fromJson(delData));
    //   }
    // } else {
    //   errorData = response.errorData;
    // }
    // var result = ApiResult<List<ReviewModel>>(
    //   resultData: data,
    //   errorData: errorData,
    // );
    // return result;
  }
}
