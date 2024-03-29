import 'package:miracle/Core/Global/Models/api_result.dart';
import 'package:miracle/Features/Review/Models/review.dart';

abstract class ReviewRepository {
  Future<ApiResult<bool>> sendReview({
    required final ReviewModel reviewData,
  });
}

class ReviewRepositoryImp extends ReviewRepository {
  @override
  Future<ApiResult<bool>> sendReview({required ReviewModel reviewData}) async {
    return ApiResult(resultData: true);
    // var response = await _restClient.sendData(ServerRoutes.sendReview,
    //     data: reviewData.toForm());
    // bool? data;
    // NetworkExceptions? errorData;
    // if (response.resultData != null) {
    //   data = true;
    // } else {
    //   errorData = response.errorData;
    // }
    // var result = ApiResult<bool>(resultData: data, errorData: errorData);
    // return result;
  }
}
