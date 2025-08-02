import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../models/activity.dart';
import 'data.dart';

class ActivitiesRespository {
  const ActivitiesRespository(this._data);
  final ActivitiesData _data;





  Future<List<CustomActivityModel>> getActivities() async {
    try {
      return await _data.getActivities();
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      if (e.response?.data['error'] != null) {
        final errorMessage = e.response?.data['error'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else {
          throw Exception(errorMessage.toString());
        }
      } else if (e.response?.statusCode != null) {
        throw Exception('Server error with status code: ${e.response?.statusCode}');
      }
      throw Exception('Failed to get activities: ${e.message}');
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  Future<ActivityModel> getActivity(String id) async {
    try {
      return await _data.getActivity(id);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      if (e.response?.data['error'] != null) {
        final errorMessage = e.response?.data['error'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else {
          throw Exception(errorMessage.toString());
        }
      } else if (e.response?.statusCode != null) {
        throw Exception('Server error with status code: ${e.response?.statusCode}');
      }
      throw Exception('Failed to get activities: ${e.message}');
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}
