import 'package:appwrite/appwrite.dart';
import 'package:miracle/Core/Global/Models/api_result.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Features/Review/Models/review.dart';
import 'package:refreshed/refreshed.dart';

import '../../../Core/Global/Controllers/global_controller.dart';

abstract class ReviewRepository {
  Future<ApiResult<bool>> sendReview({
    required final ReviewModel reviewData,
  });
}

class ReviewRepositoryImp extends ReviewRepository {
  @override
  Future<ApiResult<bool>> sendReview({required ReviewModel reviewData}) async {
    final globalController = Get.find<GlobalController>();
    if (globalController.userId != null) {
      final databases = Databases(globalController.client);
      await databases.createDocument(
        databaseId: ServerRoutes.databaseId,
        collectionId: ServerRoutes.reviewCollectionId,
        documentId: ID.unique(),
        data: reviewData.toForm(),
      );
      return ApiResult(resultData: true);
    } else {
      return ApiResult(resultData: null);
    }
  }
}
