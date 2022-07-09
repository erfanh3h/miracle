import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:miracle/Core/Components/show_message.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Global/Models/api_result.dart';

import 'network_exceptions.dart';

class RestClient extends GetConnect {
  Future<ApiResult<T>> getData<T>(
    final String url, {
    final Map<String, String>? headers,
  }) async {
    Map<String, String>? requestHeader = {
      // 'X-Requested-With': 'XMLHttpRequest',
      'Authorization': Get.find<GlobalController>().token,
      // 'Content-Type': 'application/json',
      // "Accept": "application/json",
      // 'accept-language': 'en',
    };
    if (headers != null) requestHeader = headers;
    final response = await get(url, headers: requestHeader);
    final results = json.decode(response.bodyString ?? '{}');
    if (response.hasError) {
      log('hasError: ${response.statusCode}');
      final error = NetworkExceptions.fromResult(
        response.statusCode ?? 422,
        results['detail'] ?? 'خطای ارتباط با سرور',
      );
      ShowMessageCompanent(message: error.result!).show();
      return ApiResult.failure(error: error);
    } else {
      // log(response.bodyString!);
      log(
        'results restRequest: $results // statusCode: ${response.statusCode}',
      );
      return ApiResult.success(data: results);
    }
  }

  // Post request
  Future<ApiResult> sendData(
    final String url, {
    final FormData? formData,
    final Map<String, String>? headers,
  }) async {
    Map<String, String>? requestHeader = {
      // 'X-Requested-With': 'XMLHttpRequest',
      'Authorization': Get.find<GlobalController>().token,
      // 'Content-Type': 'application/json',
      // "Accept": "application/json",
      // 'accept-language': 'en',
    };

    final response = await post(url, formData, headers: requestHeader);
    final results = json.decode(response.bodyString ?? '{}');
    if (response.hasError) {
      log('hasError: ${response.statusCode}');
      final error = NetworkExceptions.fromResult(
        response.statusCode ?? 422,
        results['detail'] ?? 'خطای ارتباط با سرور',
      );
      ShowMessageCompanent(message: error.result!).show();
      return ApiResult.failure(error: error);
    } else {
      // log(response.bodyString!);
      log(
        'results restRequest: $results // statusCode: ${response.statusCode}',
      );
      return ApiResult.success(data: results);
    }
  }

  // Post request with File
  Future<ApiResult> sendFile(
    List<int> fileBytes,
    String url,
    String fileName, {
    final Map<String, String>? headers,
  }) async {
    Map<String, String>? requestHeader = {
      // 'X-Requested-With': 'XMLHttpRequest',
      'Authorization': Get.find<GlobalController>().token,
      // 'Content-Type': 'application/json',
      // "Accept": "application/json",
      // 'accept-language': 'en',
    };
    if (headers != null) requestHeader = headers;
    final form = FormData({
      'file': MultipartFile(fileBytes, filename: fileName),
    });
    final response = await post(url, form, headers: requestHeader);
    final results = json.decode(response.bodyString ?? '{}');
    if (response.hasError) {
      log('hasError: ${response.statusCode}');
      final error = NetworkExceptions.fromResult(
        response.statusCode ?? 422,
        results['detail'] ?? 'خطای ارتباط با سرور',
      );
      ShowMessageCompanent(message: error.result!).show();
      return ApiResult.failure(error: error);
    } else {
      // log(response.bodyString!);
      log(
        'results restRequest: $results // statusCode: ${response.statusCode}',
      );
      return ApiResult.success(data: results);
    }
  }

// Post request
  Future<ApiResult> updateData(
    final String url, {
    final Map? datas,
    final Map<String, String>? headers,
  }) async {
    Map<String, String>? requestHeader = {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': Get.find<GlobalController>().token,
      'Content-Type': 'application/json',
      // "Accept": "application/json",
      // 'accept-language': 'en',
    };
    if (headers != null) requestHeader = headers;
    final response = await put(url, datas, headers: requestHeader);
    final results = json.decode(response.bodyString ?? '{}');
    if (response.hasError) {
      log('hasError: ${response.statusCode}');
      final error = NetworkExceptions.fromResult(
        response.statusCode ?? 422,
        results['detail'] ?? 'خطای ارتباط با سرور',
      );
      ShowMessageCompanent(message: error.result!).show();
      return ApiResult.failure(error: error);
    } else {
      // log(response.bodyString!);
      log(
        'results restRequest: $results // statusCode: ${response.statusCode}',
      );
      return ApiResult.success(data: results);
    }
  }

  Future<ApiResult> deleteData(
    final String url, {
    final Map<String, String>? headers,
  }) async {
    Map<String, String>? requestHeader = {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': Get.find<GlobalController>().token,
      'Content-Type': 'application/json',
      // "Accept": "application/json",
      // 'accept-language': 'en',
    };
    if (headers != null) requestHeader = headers;
    final response = await delete(url, headers: requestHeader);
    final results = json.decode(response.bodyString ?? '{}');
    if (response.hasError) {
      log('hasError: ${response.statusCode}');
      final error = NetworkExceptions.fromResult(
        response.statusCode ?? 422,
        results['detail'] ?? 'خطای ارتباط با سرور',
      );
      ShowMessageCompanent(message: error.result!).show();
      return ApiResult.failure(error: error);
    } else {
      // log(response.bodyString!);
      log(
        'results restRequest: $results // statusCode: ${response.statusCode}',
      );
      return ApiResult.success(data: results);
    }
  }

  GetSocket userMessages() {
    return socket('https://yourapi/users/socket');
  }
}
