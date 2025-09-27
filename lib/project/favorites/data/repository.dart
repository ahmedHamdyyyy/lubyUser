import 'package:dio/dio.dart';
import 'package:luby2/project/models/favorite.dart';

import 'data.dart';

class FavoritesRepository {
  const FavoritesRepository(this._favoritesData);
  final FavoritesData _favoritesData;

  Future<({List<FavoriteModel> favorites, bool hasNextPage})> getFavorites(bool fetchNext) async {
    try {
      return await _favoritesData.getFavorites(fetchNext);
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data['message'] != null) {
        final errorMessage = e.response!.data['message'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else if (errorMessage is String) {
          throw Exception(errorMessage);
        }
      }
      throw Exception('An unknown error occurred');
    } catch (e, s) {
      print('Error $e stack trace: $s');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<void> addToFavorites(String id, FavoriteType type) async {
    try {
      await _favoritesData.addToFavorites(id, type);
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data['message'] != null) {
        final errorMessage = e.response!.data['message'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else if (errorMessage is String) {
          throw Exception(errorMessage);
        }
      }
      throw Exception('An unknown error occurred');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<void> removeFromFavorites(String id, FavoriteType type) async {
    try {
      await _favoritesData.removeFromFavorites(id, type);
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data['message'] != null) {
        final errorMessage = e.response!.data['message'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else if (errorMessage is String) {
          throw Exception(errorMessage);
        }
      }
      throw Exception('An unknown error occurred');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
