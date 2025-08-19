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
    if (response.data['data']['data'] == null || (response.data['data']['data'] as List).isEmpty) return [];
    final favorites = <FavoriteModel>[];
    final favoriteData = response.data['data']['data'] as List;
    if (favoriteData.first['properties'] != null || (favoriteData.first['properties'] as List).isNotEmpty) {
      for (final property in favoriteData.first['properties'] as List) {
        favorites.add(FavoriteModel.fromJsonProperty(property));
      }
    }
    if (favoriteData.first['activities'] != null || (favoriteData.first['properties'] as List).isNotEmpty) {
      for (final property in favoriteData.first['properties'] as List) {
        favorites.add(FavoriteModel.fromJsonProperty(property));
      }
    }
    return favorites;
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
