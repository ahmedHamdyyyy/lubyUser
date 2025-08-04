import 'package:equatable/equatable.dart';

enum FavoriteType { activity, property }

class FavoriteModel extends Equatable {
  final String id, title, address, imageUrl;
  final double price, rate;
  final int guests;
  final FavoriteType type;

  const FavoriteModel({
    required this.id,
    required this.title,
    required this.address,
    required this.imageUrl,
    required this.price,
    required this.rate,
    required this.guests,
    required this.type,
  });

  factory FavoriteModel.fromJsonProperty(Map<String, dynamic> json) {
    final medias = json['medias'] as List<dynamic>? ?? [];
    return FavoriteModel(
      id: json['_id'] ?? '',
      title: json['type'] ?? '',
      address: json['address'] ?? '',
      imageUrl: (medias.isNotEmpty ? medias.first : '') ?? '',
      price: (json['pricePerNight'] ?? 0).toDouble(),
      rate: (json['rate'] ?? 0).toDouble(),
      guests: (json['guestNumber'] ?? 0).toInt(),
      type: FavoriteType.property,
    );
  }

  factory FavoriteModel.fromJsonActivity(Map<String, dynamic> json) {
    final medias = json['medias'] as List<dynamic>? ?? [];
    return FavoriteModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      address: json['details'] ?? '',
      imageUrl: (medias.isNotEmpty ? medias.first : '') ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rate: (json['rate'] ?? 0).toDouble(),
      guests: (json['guestNumber'] ?? 0).toInt(),
      type: FavoriteType.activity,
    );
  }

  @override
  List<Object?> get props => [id, title, address, imageUrl, price, rate, guests, type];
}
