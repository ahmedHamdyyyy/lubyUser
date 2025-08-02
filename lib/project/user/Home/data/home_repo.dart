import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../models/property.dart';
import '../../models/user.dart';
import 'home_data.dart';

class HomeRespository {
  const HomeRespository(this._homeData);
  final HomeData _homeData;


/* 
  UserModel getCachedUser() {
    try {
      return _homeData.getCachedUser();
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع يرجي اعادة تسجيل الدخول');
    }
  } */

  Future<UserModel> fetchUser() async {
    try {
      return _homeData.fetchUser();
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      if (e.response?.data['error'] != null) throw Exception(e.response?.data['error'].toString());
      throw Exception('فشل الاتصال بالخادم');
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }
  Future<List<PropertyModel>> getProperties() async {
    try {
      return await _homeData.getProperties();
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      throw Exception(e.response?.data['error'].toString());
    }
  }
  Future<PropertyModel> getProperty(String id) async {
    try {
      return await _homeData.getProperty(id);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      throw Exception(e.response?.data['error'].toString());
    }
  }



}
