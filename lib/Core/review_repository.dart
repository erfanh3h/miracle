import 'package:appwrite/appwrite.dart';
import 'package:miracle/Components/appwrite_component.dart';
import 'package:miracle/Models/api_result.dart';
import 'package:miracle/Routes/server_routes.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:miracle/Models/review.dart';
import 'package:getxify/getxify.dart';

abstract class ReviewRepository {
  Future<ApiResult<bool>> sendReview({required ReviewModel reviewData});
}

class ReviewRepositoryImp extends ReviewRepository {
  @override
  Future<ApiResult<bool>> sendReview({required ReviewModel reviewData}) async {
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
}
