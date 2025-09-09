import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final double longitude;
  final double latitude;
  final String formattedAddress;
  final String city;
  final String state;

  const Address({
    required this.longitude,
    required this.latitude,
    required this.formattedAddress,
    required this.city,
    required this.state,
  });

  static const initial = Address(latitude: 0, longitude: 0, formattedAddress: '', city: '', state: '');

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    longitude: (json['longitude'] ?? 0.0).toDouble(),
    latitude: (json['latitude'] ?? 0.0).toDouble(),
    formattedAddress: json['formattedAddress'] ?? '',
    city: json['city'] ?? '',
    state: json['state'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'longitude': longitude,
    'latitude': latitude,
    'formattedAddress': formattedAddress,
    'city': city,
    'state': state,
  };

  @override
  List<Object?> get props => [longitude, latitude, formattedAddress, city, state];
}
