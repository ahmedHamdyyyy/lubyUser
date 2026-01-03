import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../config/constants/constance.dart';
import '../../../../core/error/dio_error.dart';
import '../../../../core/services/api_services.dart';
import '../../../core/services/cach_services.dart';
import '../../models/notification.dart';
import '../../models/property.dart';
import '../../models/review.dart';
import '../../models/user.dart';

class HomeData {
  HomeData(this._apiService, this._cacheService);
  final ApiService _apiService;
  final CacheService _cacheService;
  int _currentPropertiesPage = 1;
  int _currentNotificationsPage = 1;

  bool isSignedIn() => (_cacheService.storage.getString(AppConst.accessToken) ?? '').isNotEmpty;

  Future<UserModel> fetchUser() async {
    final isLoggedIn = isSignedIn();
    if (!isLoggedIn) return UserModel.initial;
    final response = await _apiService.dio.get(ApiConstance.userProfile);
    if (!(response.data['success'] ?? false) || response.data['data'] == null) {
      throw ApiExceptionHandler.handle(
        DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']),
      );
    }
    final userResponse = UserModel.fromJson(response.data['data']);
    return userResponse;
  }

  Future<({List<CustomPropertyModel> properties, bool hasNextPage})> getProperties(
    bool fetchNext,
    Map<String, dynamic>? filters,
  ) async {
    _setPage(fetchNext);
    final response = await _apiService.dio.get(
      ApiConstance.createProperty,
      queryParameters: {'page': _currentPropertiesPage, ...?filters},
    );
    final properties = (response.data['data']?['data'] as List? ?? []).map((e) => CustomPropertyModel.fromJson(e)).toList();
    final hasNextPage = (response.data['data']?['pagination']?['hasNextPage'] as bool?) ?? false;
    return (properties: properties, hasNextPage: hasNextPage);
  }

  void _setPage(bool fetchNext) => _currentPropertiesPage = fetchNext ? _currentPropertiesPage + 1 : 1;

  Future<PropertyModel> getProperty(String id) async {
    final response = await _apiService.dio.get(ApiConstance.getProperty(id));
    _checkIfSuccess(response);
    log(response.data.toString());
    return PropertyModel.fromJson(
      response.data['data']['property'],
      review: response.data['data']['review'],
      reviewsCount: response.data['data']?['reviewsCount'],
      reservation: response.data['data']?['registration'],
    );
  }

  void _checkIfSuccess(Response<dynamic> response) {
    final code = response.statusCode ?? 0;
    final isOk = code >= 200 && code < 300; // accept 2xx (e.g., 200, 204)

    bool successFlag = true; // default to true when no flag is present
    final data = response.data;
    if (data is Map) {
      final dynamic s = data['success'];
      if (s is bool) successFlag = s;
    }

    if (!isOk || !successFlag) {
      final errorPayload = (data is Map) ? data['error'] : data;
      throw DioException(requestOptions: response.requestOptions, response: response, error: errorPayload);
    }
  }

  Future<List<ReviewModel>> getReviewes(String itemId, ReviewType type) async {
    final response = await _apiService.dio.get(ApiConstance.reviews, data: {'type': type.name, 'itemId': itemId});
    _checkIfSuccess(response);
    return ((response.data['data']?['data'] as List?) ?? []).map((e) => ReviewModel.fromJson(e, type)).toList();
  }

  Future<ReviewModel> addReview(ReviewModel review) async {
    final response = await _apiService.dio.post(ApiConstance.reviews, data: review.toJson());
    _checkIfSuccess(response);
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

  Future<UserModel> updateUser({required String firstName, required String lastName, required String imagePath}) async {
    final response = await _apiService.dio.put(
      '/auth/update',
      data: FormData.fromMap(<String, dynamic>{
        AppConst.firstName: firstName,
        AppConst.lastName: lastName,
        if (imagePath.isNotEmpty && !imagePath.startsWith('http'))
          AppConst.profilePicture: await MultipartFile.fromFile(
            imagePath,
            filename: imagePath.split('/').last.split('.').first,
            contentType: DioMediaType('image', imagePath.split('.').last),
          ),
      }),
    );
    _checkIfSuccess(response);
    return UserModel.fromJson(response.data['data']);
  }

  Future<({List<NotificationModel> notifications, bool hasNextPage, int unreadNotificationsCount})> fetchNotifications(
    bool fetchNext,
  ) async {
    _setNotificationsPage(fetchNext);
    final response = await _apiService.dio.get(
      ApiConstance.notifications,
      queryParameters: {'page': _currentNotificationsPage},
    );
    _checkIfSuccess(response);
    log(response.data.toString());
    return (
      notifications: ((response.data['data']['data'] as List?) ?? []).map((e) => NotificationModel.fromMap(e)).toList(),
      hasNextPage: (response.data['data']['pagination']['hasNextPage'] as bool?) ?? false,
      unreadNotificationsCount: (response.data['data']['unreadNotificationsCount'] as int?) ?? 0,
    );
  }

  void _setNotificationsPage(bool fetchNext) => _currentNotificationsPage = fetchNext ? _currentNotificationsPage + 1 : 1;

  Future<void> readNotification(String id) async {
    final response = await _apiService.dio.patch(ApiConstance.readNotification(id));
    _checkIfSuccess(response);
  }
}
