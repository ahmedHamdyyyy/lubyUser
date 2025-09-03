import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../models/favorite.dart';
import '../data/repository.dart';

part 'state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._favoritesRepository) : super(const FavoritesState());
  final FavoritesRepository _favoritesRepository;
  bool _hasNextPage = false;

  Future<void> fetchFavorites({bool fetchNext = false}) async {
    if (fetchNext && !_hasNextPage) return;
    emit(state.copyWith(getFavoritesStatus: Status.loading));
    try {
      final favoritesData = await _favoritesRepository.getFavorites(fetchNext);
      _hasNextPage = favoritesData.hasNextPage;
      emit(state.copyWith(getFavoritesStatus: Status.success, favorites: favoritesData.favorites));
    } catch (e) {
      emit(state.copyWith(getFavoritesStatus: Status.error, message: e.toString()));
    }
  }

  Future<void> addToFavorites(String id, FavoriteType type) async {
    emit(state.copyWith(addToFavoritesStatus: Status.loading));
    try {
      await _favoritesRepository.addToFavorites(id, type);
      emit(state.copyWith(addToFavoritesStatus: Status.success));
    } catch (e) {
      emit(state.copyWith(addToFavoritesStatus: Status.error, message: e.toString()));
    }
  }

  Future<void> removeFromFavorites(String id, FavoriteType type) async {
    emit(state.copyWith(addToFavoritesStatus: Status.loading));
    try {
      await _favoritesRepository.removeFromFavorites(id, type);
      emit(
        state.copyWith(
          favorites: state.favorites.where((f) => f.itemId != id).toList(),
          addToFavoritesStatus: Status.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(addToFavoritesStatus: Status.error, message: e.toString()));
    }
  }
}
