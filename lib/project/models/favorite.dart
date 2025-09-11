import 'package:equatable/equatable.dart';
import 'package:luby2/project/models/address.dart';

enum FavoriteType { activity, property }

class FavoriteModel extends Equatable {
  final String id, itemId, title, address, imageUrl;
  final double price, rate;
  final FavoriteType type;
  final int guests;
  final Address address;

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
    required this.averageRating,
  });

  factory FavoriteModel.fromJsonProperty(Map<String, dynamic> json) {
    final propertyId = json['propertyId'] as Map<String, dynamic>?;
    final medias = propertyId?['medias'] as List<dynamic>? ?? [];
    return FavoriteModel(
      id: json['_id'] ?? '',
      itemId: json['propertyId']['_id'] ?? '',
      title: json['propertyId']['type'] ?? '',
      address: json['propertyId']?['address']?['formattedAddress'] ?? '',
      imageUrl: (medias.isNotEmpty ? medias.first : '') ?? '',
      price: (propertyId?['pricePerNight'] ?? 0).toDouble(),
      rate: (propertyId?['rate'] ?? 0).toDouble(),
      guests: (propertyId?['guestNumber'] ?? 0).toInt(),
      type: FavoriteType.property,
    );
  }

  factory FavoriteModel.fromJsonActivity(Map<String, dynamic> json) {
    final activityId = json['activityId'] as Map<String, dynamic>?;
    final medias = activityId?['medias'] as List<dynamic>? ?? [];
    return FavoriteModel(
      id: json['_id'] ?? '',
      itemId: activityId?['_id'] ?? '',
      title: activityId?['name'] ?? '',
      averageRating: (activityId?['averageRating'] ?? 0).toDouble(),
      address: Address.fromJson(activityId?['address'] ?? {}),
      imageUrl: (medias.isNotEmpty ? medias.first : '') ?? '',
      price: (activityId?['price'] ?? 0).toDouble(),
      rate: (activityId?['rate'] ?? 0).toDouble(),
      guests: (activityId?['guestNumber'] ?? 0).toInt(),
      type: FavoriteType.activity,
    );
  }

  @override
  List<Object?> get props => [id, title, address, imageUrl, price, rate, guests, type, averageRating];
}
