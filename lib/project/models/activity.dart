import 'package:equatable/equatable.dart';

import '../../config/constants/constance.dart';
import 'address.dart';
import 'reversation.dart';
import 'review.dart';
import 'vendor.dart';

class CustomActivityModel extends Equatable {
  final String id, name, image, address;
  final double price, rate;
  final bool isFavorite;

  const CustomActivityModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.address,
    required this.rate,
    required this.isFavorite,
  });

  CustomActivityModel copyWith({
    String? id,
    String? name,
    String? image,
    double? price,
    String? address,
    bool? isFavorite,
    double? rate,
  }) => CustomActivityModel(
    id: id ?? this.id,
    name: name ?? this.name,
    image: image ?? this.image,
    price: price ?? this.price,
    address: address ?? this.address,
    rate: rate ?? this.rate,
    isFavorite: isFavorite ?? this.isFavorite,
  );

  factory CustomActivityModel.fromJson(Map<String, dynamic> json) => CustomActivityModel(
    id: json['_id'] ?? '',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    name: json['name'] ?? '',
    address: json['address']?['formattedAddress'] ?? '',
    image: (json['medias'] ?? []).isNotEmpty ? json['medias'][0] : '',
    isFavorite: json['isFavourite'] ?? false,
    rate: (json['averageRating'] ?? 0.0).toDouble(),
  );

  factory CustomActivityModel.fromProperty(ActivityModel property) => CustomActivityModel(
    id: property.id,
    name: property.name,
    address: property.address.formattedAddress,
    price: property.price,
    image: property.medias.isNotEmpty ? property.medias.first : '',
    isFavorite: property.isFavorite,
    rate: property.rate,
  );

  @override
  List<Object> get props => [id, name, address, price, image, isFavorite, rate];
}

class ActivityModel extends Equatable {
  final String id, name, details, date, time, activityTime, reservationId, reservationCheckInDate;
  final double price, rate, reservationTotalPrice;
  final int reviewCount, reservationGuestNumber, reservationNumber;
  final List<String> tags, medias;
  final bool verified, isFavorite;
  final Vendor vendor;
  final Address address;
  final ReviewModel review;
  final ReservationStatus reservationStatus;

  const ActivityModel({
    required this.id,
    required this.date,
    required this.time,
    required this.activityTime,
    required this.name,
    required this.details,
    required this.tags,
    required this.price,
    required this.medias,
    required this.verified,
    required this.isFavorite,
    required this.rate,
    required this.vendor,
    required this.address,
    required this.review,
    required this.reviewCount,
    required this.reservationId,
    required this.reservationCheckInDate,
    required this.reservationStatus,
    required this.reservationGuestNumber,
    required this.reservationNumber,
    required this.reservationTotalPrice,
  });

  static const non = ActivityModel(
    id: '',
    date: '',
    time: '',
    activityTime: '',
    name: '',
    details: '',
    tags: [],
    price: 0,
    medias: [],
    verified: false,
    isFavorite: false,
    rate: 0,
    address: Address.initial,
    vendor: Vendor.initial,
    review: ReviewModel.initial,
    reservationId: '',
    reservationCheckInDate: '',
    reservationStatus: ReservationStatus.draft,
    reservationGuestNumber: 1,
    reservationNumber: 0,
    reservationTotalPrice: 0.0,
    reviewCount: 0,
  );

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
    id: json['_id'] ?? '',
    address: Address.fromJson(json['address'] ?? {}),
    details: json['details'] ?? '',
    tags: List<String>.from(json['tags'] ?? []),
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    date: json['date'] ?? '',
    time: json['time'] ?? '',
    activityTime: json['activityTime'] ?? '',
    name: json['name'] ?? '',
    verified: bool.fromEnvironment(json['verified'] ?? 'false'),
    medias: List<String>.from(json['medias'] ?? []),
    isFavorite: json['isFavorite'] ?? false,
    rate: (json['averageRating'] ?? 0.0).toDouble(),
    reviewCount: json[AppConst.reviewsCount] ?? 0,
    vendor: json[AppConst.vendorId] is String ? Vendor.initial : Vendor.fromJson(json[AppConst.vendorId] ?? {}),
    review: ReviewModel.fromJson(json['review'] ?? {}, ReviewType.property),
    reservationId: json['registration']?['_id'] ?? '',
    reservationCheckInDate: json['registration']?['checkInDate'] ?? '',
    reservationStatus: ReservationStatus.values.firstWhere(
      (status) => json['registration']?['status'] == status,
      orElse: () => ReservationStatus.draft,
    ),
    reservationGuestNumber: json['registration']?['guestNumber'] ?? 1,
    reservationNumber: json['registration']?['registrationNumber'] ?? 0,
    reservationTotalPrice: (json['registration']?['totalPrice'] as num?)?.toDouble() ?? 0.0,
  );

  ActivityModel copyWith({
    String? id,
    String? details,
    List<String>? tags,
    double? price,
    List<String>? medias,
    String? name,
    String? date,
    String? time,
    String? activityTime,
    bool? verified,
    bool? isFavorite,
    double? rate,
    int? reviewCount,
    Vendor? vendor,
    Address? address,
    ReviewModel? review,
    ReservationModel? reservation,
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
      verified: verified ?? this.verified,
      isFavorite: isFavorite ?? this.isFavorite,
      rate: rate ?? this.rate,
      reviewCount: reviewCount ?? this.reviewCount,
      reservationCheckInDate: reservationCheckInDate,
      reservationGuestNumber: reservationGuestNumber,
      reservationId: reservationId,
      reservationNumber: reservationNumber,
      reservationStatus: reservationStatus,
      reservationTotalPrice: reservationTotalPrice,
      review: review ?? this.review,
      vendor: vendor ?? this.vendor,
    );
  }

  @override
  List<Object?> get props => [
    id,
    date,
    time,
    activityTime,
    name,
    details,
    tags,
    price,
    medias,
    verified,
    isFavorite,
    rate,
    vendor,
    address,
    review,
    reviewCount,
    reservationCheckInDate,
    reservationGuestNumber,
    reservationId,
    reservationNumber,
    reservationStatus,
    reservationTotalPrice,
  ];
}
