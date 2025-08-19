import 'package:dio/dio.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../config/constants/constance.dart';
import '../../../../core/error/dio_error.dart';
import '../../../../core/services/api_services.dart';
import '../../models/property.dart';
import '../../models/review.dart';
import '../../models/user.dart';

class HomeData {
  const HomeData(this._apiService);
  final ApiService _apiService;

  /*   UserModel getCachedUser() {
    final userData = _cacheService.storage.getString(AppConst.user);
    if (userData == null) throw Exception('فشل العثور علي الملف الشخصي يرجي اعادة تسجيل الدخول');
    return UserModel.fromCache(userData);
  } */

  Future<UserModel> fetchUser() async {
    final response = await _apiService.dio.get(ApiConstance.userProfile);
    if (!(response.data['success'] ?? false) || response.data['data'] == null) {
      throw ApiExceptionHandler.handle(
        DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']),
      );
    }
    final userResponse = UserModel.fromJson(response.data['data']);
    return userResponse;
  }

  Future<List<PropertyModel>> getProperties() async {
    final response = await _apiService.dio.get(ApiConstance.createProperty);
    _checkIfSuccess(response);
    final properties =
        (response.data['data']['data'] as List).map((e) {
          print(e[AppConst.id]);
          return PropertyModel.fromJson(e);
        }).toList();
    return properties;
  }

  Future<PropertyModel> getProperty(String id) async {
    final response = await _apiService.dio.get(ApiConstance.getProperty(id));
    _checkIfSuccess(response);
    return PropertyModel.fromJson(response.data['data']['property']);
  }

  void _checkIfSuccess(Response<dynamic> response) {
    //debugPrint(response.data.toString());
    if (!(response.data['success'] ?? false)) {
      throw DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);
    }
  }

  Future<List<ReviewModel>> getReviewes(String itemId, ReviewType type) async {
    print(itemId);
    final response = await _apiService.dio.get(ApiConstance.reviews, data: {'type': type.name, 'itemId': itemId});
    _checkIfSuccess(response);
    print(response.data['data']);
    return (response.data['data'] as List).map((e) => ReviewModel.fromJson(e, type)).toList();
  }

  Future<ReviewModel> addReview(ReviewModel review) async {
    final response = await _apiService.dio.post(ApiConstance.reviews, data: review.toJson());
    _checkIfSuccess(response);
    print(response.data);
    return review.copyWith(id: response.data['data']['_id']);
  }

  Future<void> updateReview(String id, String comment, int rating) async {
    final response = await _apiService.dio.put(ApiConstance.updateReview(id), data: {'comment': comment, 'rating': rating});
    _checkIfSuccess(response);
  }

  Future<void> deleteReview(String id) async {
    final response = await _apiService.dio.delete(ApiConstance.deleteReview(id));
    _checkIfSuccess(response);
  }
}
