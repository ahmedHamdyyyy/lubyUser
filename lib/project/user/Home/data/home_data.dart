import 'package:dio/dio.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../core/error/dio_error.dart';
import '../../../../core/services/api_services.dart';
import '../../models/property.dart';
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
    if (!(response.data['success'] ?? false) || response.data['data'] == null) throw   ApiExceptionHandler.handle(  DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']));
    final userResponse = UserModel.fromJson(response.data['data']);
    return userResponse;
  }






  Future<List<PropertyModel>> getProperties() async {
    final response = await _apiService.dio.get(ApiConstance.createProperty);
    _checkIfSuccess(response);
    return (response.data['data']['data'] as List).map((e) => PropertyModel.fromJson(e)).toList();
  }

  Future<PropertyModel> getProperty(String id) async {
    final response = await _apiService.dio.get(ApiConstance.getProperty(id));
    _checkIfSuccess(response);
    return PropertyModel.fromJson(response.data['data']);
  }

  void _checkIfSuccess(Response<dynamic> response) {
    //debugPrint(response.data.toString());
    if (!(response.data['success'] ?? false)) {
      throw DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);
    }
  }
}
