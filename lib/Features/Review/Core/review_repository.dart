import 'package:appwrite/appwrite.dart';
import 'package:miracle/Core/Global/Models/api_result.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Features/Review/Models/review.dart';
import 'package:getxify/getxify.dart';

import '../../../Core/Global/Controllers/global_controller.dart';

abstract class ReviewRepository {
  Future<ApiResult<bool>> sendReview({required ReviewModel reviewData});
}

class ReviewRepositoryImp extends ReviewRepository {
  @override
  Future<ApiResult<bool>> sendReview({required ReviewModel reviewData}) async {
    final globalController = Get.find<GlobalController>();

    if (globalController.userId != null) {
      final tablesDB = TablesDB(globalController.client);

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
}
