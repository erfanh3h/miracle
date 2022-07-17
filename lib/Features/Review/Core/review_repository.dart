import 'package:get/get.dart';
import 'package:miracle/Core/Global/Models/api_result.dart';
import 'package:miracle/Core/Network/network_exceptions.dart';
import 'package:miracle/Core/Network/rest_client.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Features/Review/Models/review.dart';

abstract class ReviewRepository {
  Future<ApiResult<List<ReviewModel>>> getReviewsList({
    required final String reviewType,
    required final int reviewTypeId,
    required final int page,
  });
  Future<ApiResult<ReviewModel>> sendReview({
    required final ReviewModel reviewData,
  });
  Future<ApiResult<bool>> deleteReview({
    required final int dataId,
  });
  Future<ApiResult<ReviewModel>> sendReaction({
    required final String reactionType,
    required final int reactionTypeId,
  });
  Future<ApiResult<bool>> deleteReaction({
    required final int dataId,
  });
}

class ReviewRepositoryImp extends ReviewRepository {
  final RestClient _restClient = RestClient();

  @override
  Future<ApiResult<List<ReviewModel>>> getReviewsList({
    required String reviewType,
    required int reviewTypeId,
    required int page,
  }) async {
    var response = await _restClient.getData(
        ServerRoutes.getReviews(page, reviewType, reviewTypeId.toString()));
    List<ReviewModel>? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = [];
      for (var reviewData in response.resultData) {
        data.add(ReviewModel.fromJson(reviewData));
      }
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<List<ReviewModel>>(
      resultData: data,
      errorData: errorData,
    );
    return result;
  }

  @override
  Future<ApiResult<ReviewModel>> sendReview(
      {required ReviewModel reviewData}) async {
    var response = await _restClient.sendData(ServerRoutes.sendReview,
        formData: reviewData.toForm());
    ReviewModel? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = ReviewModel.fromJson(response.resultData['data']);
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<ReviewModel>(resultData: data, errorData: errorData);
    return result;
  }

  @override
  Future<ApiResult<bool>> deleteReview({required int dataId}) async {
    var response = await _restClient
        .deleteData(ServerRoutes.deleteReview(dataId.toString()));
    bool? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = response.resultData['status'];
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<bool>(resultData: data, errorData: errorData);
    return result;
  }

  @override
  Future<ApiResult<ReviewModel>> sendReaction({
    required final String reactionType,
    required final int reactionTypeId,
  }) async {
    var response = await _restClient.sendData(
      ServerRoutes.sendReview,
      formData: FormData(
        {
          'reaction_type_id': reactionTypeId,
          'reaction_type': reactionType,
        },
      ),
    );
    ReviewModel? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = ReviewModel.fromJson(response.resultData['data']);
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<ReviewModel>(resultData: data, errorData: errorData);
    return result;
  }

  @override
  Future<ApiResult<bool>> deleteReaction({required int dataId}) async {
    var response = await _restClient
        .deleteData(ServerRoutes.deleteReaction(dataId.toString()));
    bool? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = response.resultData['status'];
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<bool>(resultData: data, errorData: errorData);
    return result;
  }
}
