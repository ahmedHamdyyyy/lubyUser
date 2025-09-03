import 'package:dio/dio.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../core/services/api_services.dart';
import '../../models/activity.dart';

class ActivitiesData {
  ActivitiesData(this._apiService);
  final ApiService _apiService;
  int _currentPage = 1;

  Future<({List<CustomActivityModel> activities, bool hasNextPage})> getActivities(
    bool fetchNext,
    Map<String, dynamic>? filters,
  ) async {
    _setPage(fetchNext);
    final response = await _apiService.dio.get(
      ApiConstance.getActivities,
      queryParameters: {'page': _currentPage, ...?filters},
    );
    _checkIfSuccess(response);
    final activities = (response.data['data']['data'] as List).map((e) => CustomActivityModel.fromJson(e)).toList();
    final hasNextPage = (response.data['data']['pagination']['hasNextPage'] as bool?) ?? false;
    _currentPage = response.data['data']['pagination']['currentPage'] ?? _currentPage;
    return (activities: activities, hasNextPage: hasNextPage);
  }

  void _setPage(bool fetchNext) => _currentPage = fetchNext ? _currentPage + 1 : 1;

  Future<ActivityModel> getActivity(String id) async {
    final response = await _apiService.dio.get(ApiConstance.getActivity(id));
    _checkIfSuccess(response);
    return ActivityModel.fromJson(response.data['data']['activity']);
  }

  void _checkIfSuccess(Response<dynamic> response) {
    if (!(response.data['success'] ?? false)) {
      throw DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);
    }
  }
}
