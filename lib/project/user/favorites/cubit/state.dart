part of 'cubit.dart';

class FavoritesState extends Equatable {
  final String message;
  final Status getFavoritesStatus, addToFavoritesStatus;
  final List<FavoriteModel> favorites;

  const FavoritesState({
    this.message = '',
    this.getFavoritesStatus = Status.initial,
    this.addToFavoritesStatus = Status.initial,
    this.favorites = const [],
  });

  FavoritesState copyWith({
    String? message,
    Status? getFavoritesStatus,
    Status? addToFavoritesStatus,
    List<FavoriteModel>? favorites,
  }) {
    return FavoritesState(
      message: message ?? this.message,
      getFavoritesStatus: getFavoritesStatus ?? this.getFavoritesStatus,
      addToFavoritesStatus: addToFavoritesStatus ?? this.addToFavoritesStatus,
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  List<Object> get props => [message, getFavoritesStatus, addToFavoritesStatus, favorites];
}
