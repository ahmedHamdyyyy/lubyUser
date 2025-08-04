import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../models/favorite.dart';
import '../data/repository.dart';

part 'state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._favoritesRepository) : super(const FavoritesState());
  final FavoritesRepository _favoritesRepository;

  Future<void> fetchFavorites() async {
    emit(state.copyWith(getFavoritesStatus: Status.loading));
    try {
      final favorites = await _favoritesRepository.getFavorites();
      emit(state.copyWith(getFavoritesStatus: Status.success, favorites: favorites));
    } catch (e) {
      emit(state.copyWith(getFavoritesStatus: Status.error, message: e.toString()));
    }
  }

  Future<void> addToFavorites(String id, FavoriteType type) async {
    emit(state.copyWith(addToFavoritesStatus: Status.loading));
    try {
      await _favoritesRepository.addToFavorites(id, type.name);
      emit(state.copyWith(addToFavoritesStatus: Status.success));
    } catch (e) {
      emit(state.copyWith(addToFavoritesStatus: Status.error, message: e.toString()));
    }
  }

  Future<void> removeFromFavorites(String id, FavoriteType type) async {
    emit(state.copyWith(addToFavoritesStatus: Status.loading));
    try {
      await _favoritesRepository.removeFromFavorites(id, type.name);
      emit(
        state.copyWith(favorites: state.favorites.where((f) => f.id != id).toList(), addToFavoritesStatus: Status.success),
      );
    } catch (e) {
      emit(state.copyWith(addToFavoritesStatus: Status.error, message: e.toString()));
    }
  }
}
