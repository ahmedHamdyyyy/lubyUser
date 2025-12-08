part of 'cubit.dart';

class FavoritesState extends Equatable {
  final String message;
  final Status getFavoritesStatus, toggleFavoriteStatus;
  final List<FavoriteModel> favorites;

  const FavoritesState({
    this.message = '',
    this.getFavoritesStatus = Status.initial,
    this.toggleFavoriteStatus = Status.initial,
    this.favorites = const [],
  });

  FavoritesState copyWith({
    String? message,
    Status? getFavoritesStatus,
    Status? toggleFavoriteStatus,
    List<FavoriteModel>? favorites,
  }) {
    return FavoritesState(
      message: message ?? this.message,
      getFavoritesStatus: getFavoritesStatus ?? this.getFavoritesStatus,
      toggleFavoriteStatus: toggleFavoriteStatus ?? this.toggleFavoriteStatus,
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  List<Object> get props => [message, getFavoritesStatus, toggleFavoriteStatus, favorites];
}
