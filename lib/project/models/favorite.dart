import 'package:equatable/equatable.dart';

enum FavoriteType { activity, property }

class FavoriteModel extends Equatable {
  final String id, itemId, title, address, imageUrl;
  final double price, rate;
  final FavoriteType type;
  final int guests;

  const FavoriteModel({
    required this.id,
    required this.itemId,
    required this.title,
    required this.address,
    required this.imageUrl,
    required this.price,
    required this.rate,
    required this.guests,
    required this.type,
  });

  factory FavoriteModel.fromJsonProperty(Map<String, dynamic> json) {
    final medias = json['propertyId']['medias'] as List<dynamic>? ?? [];
    return FavoriteModel(
      id: json['_id'] ?? '',
      itemId: json['propertyId']['_id'] ?? '',
      title: json['propertyId']['type'] ?? '',
      address: json['propertyId']?['address']?['formattedAddress'] ?? '',
      imageUrl: (medias.isNotEmpty ? medias.first : '') ?? '',
      price: (json['propertyId']['pricePerNight'] ?? 0).toDouble(),
      rate: (json['propertyId']['rate'] ?? 0).toDouble(),
      guests: (json['propertyId']['guestNumber'] ?? 0).toInt(),
      type: FavoriteType.property,
    );
  }

  factory FavoriteModel.fromJsonActivity(Map<String, dynamic> json) {
    final medias = json['activityId']['medias'] as List<dynamic>? ?? [];
    return FavoriteModel(
      id: json['_id'] ?? '',
      itemId: json['activityId']['_id'] ?? '',
      title: json['activityId']['title'] ?? '',
      address: json['activityId']['details'] ?? '',
      imageUrl: (medias.isNotEmpty ? medias.first : '') ?? '',
      price: (json['activityId']['price'] ?? 0).toDouble(),
      rate: (json['activityId']['rate'] ?? 0).toDouble(),
      guests: (json['activityId']['guestNumber'] ?? 0).toInt(),
      type: FavoriteType.activity,
    );
  }

  @override
  List<Object?> get props => [id, title, address, imageUrl, price, rate, guests, type];
}
