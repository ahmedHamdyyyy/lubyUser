import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class CustomActivityModel extends Equatable {
  final String id, name, image, address, vendorId;
  final int price;
  final bool isFavorite;

  const CustomActivityModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.address,
    required this.vendorId,
    this.isFavorite = false,
  });

  CustomActivityModel copyWith({
    String? id,
    String? name,
    String? image,
    int? price,
    String? address,
    String? vendorId,
    bool? isFavorite,
  }) => CustomActivityModel(
    id: id ?? this.id,
    vendorId: vendorId ?? this.vendorId,
    name: name ?? this.name,
    image: image ?? this.image,
    price: price ?? this.price,
    address: address ?? this.address,
    isFavorite: isFavorite ?? this.isFavorite,
  );

  factory CustomActivityModel.fromJson(Map<String, dynamic> json) => CustomActivityModel(
    id: json['_id'] ?? '',
    price: json['price'] ?? 0,
    name: json['name'] ?? '',
    address: json['address'] ?? '',
    vendorId: json['vendorId'] ?? '',
    image: (json['medias'] ?? []).isNotEmpty ? json['medias'][0] : '',
    isFavorite: json['isFavorite'] ?? false,
  );

  factory CustomActivityModel.fromProperty(ActivityModel property) => CustomActivityModel(
    id: property.id,
    vendorId: property.vendorId,
    name: property.name,
    address: property.address,
    price: property.price,
    image: property.medias.isNotEmpty ? property.medias.first : '',
    isFavorite: false, // Default to false, can be updated later
  );

  @override
  List<Object> get props => [id, name, image, isFavorite];
}

class ActivityModel extends Equatable {
  final String id, vendorId, name, address, details, date, time, activityTime;
  final int price;
  final List<String> tags, medias;
  final bool verified, isFavorite;

  const ActivityModel({
    required this.id,
    required this.vendorId,
    required this.date,
    required this.time,
    required this.activityTime,
    required this.name,
    required this.address,
    required this.details,
    required this.tags,
    required this.price,
    required this.medias,
    required this.verified,
    this.isFavorite = false,
  });

  static const non = ActivityModel(
    id: '',
    vendorId: '',
    date: '',
    time: '',
    activityTime: '',
    name: '',
    address: '',
    details: '',
    tags: [],
    price: 0,
    medias: [],
    verified: false,
    isFavorite: false,
  );

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
    id: json['_id'] ?? '',
    vendorId: json['vendorId'] ?? '',
    address: json['address'] ?? '',
    details: json['details'] ?? '',
    tags: List<String>.from(json['tags'] ?? []),
    price: json['price'] ?? 0,
    date: json['date'] ?? '',
    time: json['time'] ?? '',
    activityTime: json['activityTime'] ?? '',
    name: json['name'] ?? '',
    verified: bool.fromEnvironment(json['verified'] ?? 'false'),
    medias: List<String>.from(json['medias'] ?? []),
    isFavorite: json['isFavorite'] ?? false,
  );

  Future<FormData> create() async => FormData.fromMap({
    'address': address,
    'details': details,
    'price': price,
    'medias': medias,
    'name': name,
    'date': date,
    'time': time,
    'vendorId': vendorId,
    'verified': verified,
    'activityTime': activityTime,
    'isFavorite': isFavorite,
    for (final tag in tags) 'tags': tag,
    for (final media in medias)
      if (media.isNotEmpty) 'medias': await MultipartFile.fromFile(media, filename: media.split('/').last),
  });

  ActivityModel copyWith({
    String? id,
    String? address,
    String? details,
    List<String>? tags,
    int? price,
    List<String>? medias,
    String? name,
    String? date,
    String? time,
    String? activityTime,
    String? vendorId,
    bool? verified,
    bool? isFavorite,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      address: address ?? this.address,
      details: details ?? this.details,
      tags: tags ?? this.tags,
      price: price ?? this.price,
      medias: medias ?? this.medias,
      name: name ?? this.name,
      date: date ?? this.date,
      time: time ?? this.time,
      activityTime: activityTime ?? this.activityTime,
      vendorId: vendorId ?? this.vendorId,
      verified: verified ?? this.verified,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
    id,
    address,
    details,
    tags,
    price,
    medias,
    name,
    date,
    time,
    activityTime,
    vendorId,
    verified,
    isFavorite,
  ];
}
