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
  Future<ApiResult<bool>> sendReview({
    required final ReviewModel reviewData,
  });
  Future<ApiResult<bool>> deleteReview({
    required final int dataId,
  });
  Future<ApiResult<bool>> sendReaction({
    required final String reactionType,
    required final int reactionTypeId,
  });
  Future<ApiResult<bool>> deleteReaction({
    required final String reactionType,
    required final int reactionTypeId,
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
  Future<ApiResult<bool>> sendReview({required ReviewModel reviewData}) async {
    var response = await _restClient.sendData(ServerRoutes.sendReview,
        data: reviewData.toForm());
    bool? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = true;
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<bool>(resultData: data, errorData: errorData);
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
  Future<ApiResult<bool>> sendReaction({
    required final String reactionType,
    required final int reactionTypeId,
  }) async {
    var response = await _restClient.sendData(
      ServerRoutes.sendReaction,
      data: {
        'reaction_type_id': reactionTypeId,
        'reaction_type': reactionType,
      },
    );
    bool? data;
    NetworkExceptions? errorData;
    if (response.resultData != null) {
      data = true;
    } else {
      errorData = response.errorData;
    }
    var result = ApiResult<bool>(resultData: data, errorData: errorData);
    return result;
  }

  @override
  Future<ApiResult<bool>> deleteReaction({
    required final String reactionType,
    required final int reactionTypeId,
  }) async {
    var response = await _restClient.sendData(
      ServerRoutes.deleteReaction,
      data: {
        'reaction_type_id': reactionTypeId,
        'reaction_type': reactionType,
      },
    );
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
