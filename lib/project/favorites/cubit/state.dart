part of 'cubit.dart';

class FavoritesState extends Equatable {
  final String message;
  final Status getFavoritesStatus, addToFavoritesStatus, removeFromFavoritesStatus;
  final List<FavoriteModel> favorites;

  const FavoritesState({
    this.message = '',
    this.getFavoritesStatus = Status.initial,
    this.addToFavoritesStatus = Status.initial,
    this.removeFromFavoritesStatus = Status.initial,
    this.favorites = const [],
  });

  FavoritesState copyWith({
    String? message,
    Status? getFavoritesStatus,
    Status? addToFavoritesStatus,
    Status? removeFromFavoritesStatus,
    List<FavoriteModel>? favorites,
  }) {
    return FavoritesState(
      message: message ?? this.message,
      getFavoritesStatus: getFavoritesStatus ?? this.getFavoritesStatus,
      addToFavoritesStatus: addToFavoritesStatus ?? this.addToFavoritesStatus,
      removeFromFavoritesStatus: removeFromFavoritesStatus ?? this.removeFromFavoritesStatus,
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  List<Object> get props => [message, getFavoritesStatus, addToFavoritesStatus, removeFromFavoritesStatus, favorites];
}
