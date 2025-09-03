import 'package:dio/dio.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../core/services/api_services.dart';
import '../../models/favorite.dart';

class FavoritesData {
  FavoritesData(this._apiService);
  final ApiService _apiService;
  int _currentPage = 1;

  Future<({List<FavoriteModel> favorites, bool hasNextPage})> getFavorites(bool fetchNext) async {
    _setPage(fetchNext);
    final response = await _apiService.dio.get(ApiConstance.getFavorites, queryParameters: {'page': _currentPage});
    _checkResponseStatus(response);
    if (response.data['data']['data'] == null || (response.data['data']['data'] as List).isEmpty) {
      return (favorites: <FavoriteModel>[], hasNextPage: false);
    }
    final favorites = <FavoriteModel>[];
    final favoriteData = response.data['data']['data'] as List;
    for (final item in favoriteData) {
      if (item.containsKey('propertyId')) {
        favorites.add(FavoriteModel.fromJsonProperty(item));
      } else {
        favorites.add(FavoriteModel.fromJsonActivity(item));
      }
    }
    final hasNextPage = (response.data['data']['hasNextPage'] as bool?) ?? false;
    return (favorites: favorites, hasNextPage: hasNextPage);
  }

  void _setPage(bool fetchNext) => _currentPage = fetchNext ? _currentPage + 1 : 1;

  Future<void> addToFavorites(String id, FavoriteType type) async {
    final response = await _apiService.dio.post(
      ApiConstance.addFavorites,
      data: {(type == FavoriteType.activity ? 'activityId' : 'propertyId'): id, 'type': type.name},
    );
    _checkResponseStatus(response);
  }

  Future<void> removeFromFavorites(String id, FavoriteType type) async {
    final response = await _apiService.dio.delete(
      ApiConstance.removeFavorites,
      data: {(type == FavoriteType.activity ? 'activityId' : 'propertyId'): id},
    );
    _checkResponseStatus(response);
  }

  void _checkResponseStatus(Response<dynamic> response) {
    if (response.data == null || !response.data['success']) throw DioException(requestOptions: response.requestOptions);
  }
}
