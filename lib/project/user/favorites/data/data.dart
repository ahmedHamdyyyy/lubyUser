import 'package:dio/dio.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../core/services/api_services.dart';
import '../../models/favorite.dart';

class FavoritesData {
  const FavoritesData(this._apiService);
  final ApiService _apiService;

  Future<List<FavoriteModel>> getFavorites() async {
    final response = await _apiService.dio.get(ApiConstance.getFavorites);
    _checkResponseStatus(response);
    final properties =
        ((response.data['data']['data'] as List).first['properties'] as List<dynamic>?)
            ?.map((e) => FavoriteModel.fromJsonProperty(e))
            .toList() ??
        [];
    final activities =
        ((response.data['data']['data'] as List).first['activities'] as List<dynamic>?)
            ?.map((e) => FavoriteModel.fromJsonActivity(e))
            .toList() ??
        [];
    return [...properties, ...activities];
  }

  Future<void> addToFavorites(String id, String type) async {
    final response = await _apiService.dio.post(ApiConstance.addFavorites, data: {'itemId': id, 'type': type});
    _checkResponseStatus(response);
  }

  Future<void> removeFromFavorites(String id, String type) async {
    final response = await _apiService.dio.post(ApiConstance.removeFavorites, data: {'itemId': id, 'type': type});
    _checkResponseStatus(response);
  }

  void _checkResponseStatus(Response<dynamic> response) {
    if (response.data == null || !response.data['success']) throw DioException(requestOptions: response.requestOptions);
  }
}
