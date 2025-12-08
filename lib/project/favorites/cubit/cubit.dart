import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../../config/widget/widget.dart';
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
      emit(
        state.copyWith(
          getFavoritesStatus: Status.success,
          favorites: fetchNext ? [...state.favorites, ...favoritesData.favorites] : favoritesData.favorites,
        ),
      );
    } catch (e) {
      emit(state.copyWith(getFavoritesStatus: Status.error, message: e.toString()));
    }
  }

  String _itemId = '';
  String get itemId => _itemId;
  bool _isProperty = false;
  bool get isProperty => _isProperty;

  Future<void> addToFavorites(String id, FavoriteType type) async {
    _itemId = id;
    _isProperty = type == FavoriteType.property;
    emit(state.copyWith(toggleFavoriteStatus: Status.loading));
    try {
      await _favoritesRepository.addToFavorites(id, type);
      emit(state.copyWith(toggleFavoriteStatus: Status.success));
      showToast(text: 'Added to favorites', stute: ToustStute.success);
    } catch (e) {
      emit(state.copyWith(toggleFavoriteStatus: Status.error, message: e.toString()));
      showToast(text: 'Failed to add to favorites', stute: ToustStute.error);
    }
  }

  Future<void> removeFromFavorites(String id, FavoriteType type) async {
    _itemId = id;
    _isProperty = type == FavoriteType.property;
    emit(state.copyWith(toggleFavoriteStatus: Status.loading));
    try {
      await _favoritesRepository.removeFromFavorites(id, type);
      emit(
        state.copyWith(
          favorites: state.favorites.where((f) => f.itemId != id).toList(),
          toggleFavoriteStatus: Status.success,
        ),
      );
      showToast(text: 'Removed from favorites', stute: ToustStute.worning);
    } catch (e) {
      emit(state.copyWith(toggleFavoriteStatus: Status.error, message: e.toString()));
      showToast(text: 'Failed to remove from favorites', stute: ToustStute.worning);
    }
  }
}
