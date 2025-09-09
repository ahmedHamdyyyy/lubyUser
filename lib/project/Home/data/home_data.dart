import 'package:dio/dio.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../config/constants/constance.dart';
import '../../../../core/error/dio_error.dart';
import '../../../../core/services/api_services.dart';
import '../../models/property.dart';
import '../../models/review.dart';
import '../../models/user.dart';

class HomeData {
  HomeData(this._apiService);
  final ApiService _apiService;
  int _currentPage = 1;

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

  Future<({List<PropertyModel> properties, bool hasNextPage})> getProperties(
    bool fetchNext,
    Map<String, dynamic>? filters,
  ) async {
    _setPage(fetchNext);
    print(_currentPage);
    print(filters);
    final response = await _apiService.dio.get(
      ApiConstance.createProperty,
      queryParameters: {'page': _currentPage, ...?filters},
    );
    print(response.data);
    _checkIfSuccess(response);
    final properties = (response.data['data']['data'] as List).map((e) => PropertyModel.fromJson(e)).toList();
    final hasNextPage = (response.data['data']['hasNextPage'] as bool?) ?? false;
    return (properties: properties, hasNextPage: hasNextPage);
  }

  void _setPage(bool fetchNext) => _currentPage = fetchNext ? _currentPage + 1 : 1;

  Future<PropertyModel> getProperty(String id) async {
    final response = await _apiService.dio.get(ApiConstance.getProperty(id));
    _checkIfSuccess(response);
    return PropertyModel.fromJson(response.data['data']['property']);
  }

  void _checkIfSuccess(Response<dynamic> response) {
    if (!(response.data['success'] ?? false)) {
      throw DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);
    }
  }

  Future<List<ReviewModel>> getReviewes(String itemId, ReviewType type) async {
    final response = await _apiService.dio.get(ApiConstance.reviews, data: {'type': type.name, 'itemId': itemId});
    _checkIfSuccess(response);
    return (response.data['data'] as List).map((e) => ReviewModel.fromJson(e, type)).toList();
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

  Future<UserModel> updateUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String imagePath,
  }) async {
    final response = await _apiService.dio.put(
      '/auth/update',
      data: FormData.fromMap(<String, dynamic>{
        AppConst.firstName: firstName,
        AppConst.lastName: lastName,
        AppConst.phone: phone,
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
}
