import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../models/notification.dart';
import '../../models/property.dart';
import '../../models/review.dart';
import '../../models/user.dart';
import 'home_data.dart';

class HomeRespository {
  const HomeRespository(this._homeData);
  final HomeData _homeData;

  bool isSignedIn() => _homeData.isSignedIn();

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

  Future<({List<CustomPropertyModel> properties, bool hasNextPage})> getProperties(
    bool fetchNext,
    Map<String, dynamic>? filters,
  ) async {
    try {
      return await _homeData.getProperties(fetchNext, filters);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      throw Exception(e.response?.data['error'].toString());
    } catch (e, s) {
      debugPrint('Unexpected error: $e');
      debugPrintStack(stackTrace: s);
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  Future<PropertyModel> getProperty(String id) async {
    try {
      return await _homeData.getProperty(id);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      throw Exception(e.response?.data['error'].toString());
    } catch (e, s) {
      debugPrint('Unexpected error: $e');
      debugPrintStack(stackTrace: s);
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  Future<List<ReviewModel>> getReviewes(String itemId, ReviewType type) async {
    try {
      return await _homeData.getReviewes(itemId, type);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      throw Exception(e.response?.data['error'].toString());
    }
  }

  Future<ReviewModel> addReview(ReviewModel review) async {
    try {
      return await _homeData.addReview(review);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      throw Exception(e.response?.data['error'].toString());
    }
  }

  Future<void> updateReview(String id, String comment, int rating) async {
    try {
      await _homeData.updateReview(id, comment, rating);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      throw Exception(e.response?.data['error'].toString());
    }
  }

  Future<void> deleteReview(String id) async {
    try {
      await _homeData.deleteReview(id);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      throw Exception(e.response?.data['error'].toString());
    }
  }

  Future<UserModel> updateUser({required String firstName, required String lastName, required String imagePath}) async {
    try {
      return await _homeData.updateUser(firstName: firstName, lastName: lastName, imagePath: imagePath);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.error}');
      throw Exception(e.response?.data['error'].toString());
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  Future<({List<NotificationModel> notifications, bool hasNextPage, int unreadNotificationsCount})> fetchNotifications(
    bool fetchNext,
  ) async {
    try {
      return await _homeData.fetchNotifications(fetchNext);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      throw Exception(e.response?.data['error'].toString());
    } catch (e, s) {
      debugPrint('Unexpected error: $e, $s');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  Future<void> readNotification(String id) async {
    try {
      await _homeData.readNotification(id);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      throw Exception(e.response?.data['error'].toString());
    } catch (e, s) {
      debugPrint('Unexpected error: $e, $s');
      throw Exception('حدث خطأ غير متوقع');
    }
  }
}
