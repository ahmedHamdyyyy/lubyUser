import 'package:equatable/equatable.dart';

import '../../../config/constants/constance.dart';
import 'address.dart';
import 'reversation.dart';
import 'review.dart';
import 'vendor.dart';

// ignore: constant_identifier_names
enum PropertyType { apartment, house, cabin, guest_house, studio, yacht, cruise }

class CustomPropertyModel extends Equatable {
  final String id, type, imageUrl, address;
  final int guestNumber;
  final bool isFavorite;
  final double rate, pricePerNight;

  const CustomPropertyModel({
    required this.id,
    required this.type,
    required this.imageUrl,
    required this.address,
    required this.guestNumber,
    required this.isFavorite,
    required this.rate,
    required this.pricePerNight,
  });

  factory CustomPropertyModel.fromJson(Map<String, dynamic> json) => CustomPropertyModel(
    id: json[AppConst.id] ?? '',
    type: json[AppConst.type] ?? '',
    imageUrl: json[AppConst.medias]?.first ?? '',
    address: json[AppConst.address]?['formattedAddress'] ?? '',
    guestNumber: json[AppConst.guestNumber] ?? 0,
    isFavorite: json[AppConst.isFavorite] ?? false,
    rate: (json['averageRating'] ?? 0.0).toDouble(),
    pricePerNight: (json[AppConst.pricePerNight] ?? 0.0).toDouble(),
  );

  @override
  List<Object?> get props => [id, type, imageUrl, address, guestNumber, isFavorite, rate, pricePerNight];
}

class PropertyModel extends Equatable {
  final String id, type, details, endDate, startDate, reservationId, reservationCheckInDate;
  final int guestNumber, bedrooms, bathrooms, beds, reviewsCount, reservationGuestNumber, reservationNumber;
  final List<String> tags, medias, ownershipContract, facilityLicense;
  final bool available, isFavorite;
  final double totalRate, pricePerNight, reservationTotalPrice;
  final Vendor vendor;
  final Address address;
  final ReviewModel review;
  final ReservationStatus reservationStatus;

  const PropertyModel({
    required this.id,
    required this.endDate,
    required this.startDate,
    required this.reviewsCount,
    required this.type,
    required this.available,
    required this.guestNumber,
    required this.bedrooms,
    required this.bathrooms,
    required this.beds,
    required this.address,
    required this.details,
    required this.tags,
    required this.pricePerNight,
    required this.ownershipContract,
    required this.medias,
    required this.facilityLicense,
    required this.isFavorite,
    required this.totalRate,
    required this.vendor,
    required this.review,
    required this.reservationId,
    required this.reservationCheckInDate,
    required this.reservationStatus,
    required this.reservationGuestNumber,
    required this.reservationNumber,
    required this.reservationTotalPrice,
  });

  static const initial = PropertyModel(
    id: '',
    type: '',
    available: true,
    guestNumber: 0,
    reviewsCount: 0,
    bedrooms: 0,
    endDate: '',
    startDate: '',
    bathrooms: 0,
    beds: 0,
    address: Address.initial,
    details: '',
    tags: [],
    pricePerNight: 0,
    ownershipContract: [],
    facilityLicense: [],
    medias: [],
    isFavorite: false,
    review: ReviewModel.initial,
    reservationId: '',
    reservationCheckInDate: '',
    reservationStatus: ReservationStatus.pending,
    reservationGuestNumber: 1,
    reservationNumber: 0,
    reservationTotalPrice: 0.0,
    totalRate: 0,
    vendor: Vendor.initial,
  );

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    List<String> parseStringOrList(dynamic value) {
      if (value == null) return [];
      if (value is List) return List<String>.from(value);
      if (value is String) return [value];
      return [];
    }

    return PropertyModel(
      id: json[AppConst.id] ?? '',
      endDate: json[AppConst.endDate] ?? '',
      startDate: json[AppConst.startDate] ?? '',
      type: json[AppConst.type] ?? '',
      available: json[AppConst.available] ?? false,
      guestNumber: json[AppConst.guestNumber] ?? 0,
      reviewsCount: json[AppConst.reviewsCount] ?? 0,
      bedrooms: json[AppConst.bedrooms] ?? 0,
      bathrooms: json[AppConst.bathrooms] ?? 0,
      beds: json[AppConst.beds] ?? 0,
      address: Address.fromJson(json[AppConst.address] ?? {}),
      details: json[AppConst.details] ?? '',
      tags: parseStringOrList(json[AppConst.tags]),
      pricePerNight: (json[AppConst.pricePerNight] ?? 0.0).toDouble(),
      ownershipContract: parseStringOrList(json[AppConst.ownershipContract]),
      facilityLicense: parseStringOrList(json[AppConst.facilityLicense]),
      medias: parseStringOrList(json[AppConst.medias]),
      isFavorite: json[AppConst.isFavorite] ?? false,
      totalRate: (json['averageRating'] ?? 0.0).toDouble(),
      vendor: json[AppConst.vendorId] is String ? Vendor.initial : Vendor.fromJson(json[AppConst.vendorId] ?? {}),
      review: ReviewModel.fromJson(json['review'] ?? {}, ReviewType.property),
      reservationId: json['registration']?['_id'] ?? '',
      reservationCheckInDate: json['registration']?['checkInDate'] ?? '',
      reservationStatus: ReservationStatus.values.firstWhere(
        (status) => json['registration']?['status'] == status,
        orElse: () => ReservationStatus.pending,
      ),
      reservationGuestNumber: json['registration']?['guestNumber'] ?? 1,
      reservationNumber: json['registration']?['registrationNumber'] ?? 0,
      reservationTotalPrice: (json['registration']?['totalPrice'] as num?)?.toDouble() ?? 0.0,
    );
  }

  PropertyModel copyWith({
    String? id,
    String? type,
    bool? available,
    int? guestNumber,
    int? bedrooms,
    int? bathrooms,
    int? beds,
    Address? address,
    String? details,
    List<String>? tags,
    double? pricePerNight,
    List<String>? ownershipContract,
    List<String>? facilityLicense,
    List<String>? medias,
    bool? isFavorite,
    String? endDate,
    String? startDate,
    double? totalRate,
    ReviewModel? review,
  }) => PropertyModel(
    id: id ?? this.id,
    endDate: endDate ?? this.endDate,
    reviewsCount: reviewsCount,
    startDate: startDate ?? this.startDate,
    type: type ?? this.type,
    facilityLicense: facilityLicense ?? this.facilityLicense,
    available: available ?? this.available,
    guestNumber: guestNumber ?? this.guestNumber,
    bedrooms: bedrooms ?? this.bedrooms,
    bathrooms: bathrooms ?? this.bathrooms,
    beds: beds ?? this.beds,
    address: address ?? this.address,
    details: details ?? this.details,
    tags: tags ?? this.tags,
    pricePerNight: pricePerNight ?? this.pricePerNight,
    ownershipContract: ownershipContract ?? this.ownershipContract,
    medias: medias ?? this.medias,
    isFavorite: isFavorite ?? this.isFavorite,
    review: review ?? this.review,
    totalRate: totalRate ?? this.totalRate,
    vendor: vendor,
    reservationCheckInDate: reservationCheckInDate,
    reservationGuestNumber: reservationGuestNumber,
    reservationId: reservationId,
    reservationNumber: reservationNumber,
    reservationStatus: reservationStatus,
    reservationTotalPrice: reservationTotalPrice,
  );

  @override
  List<Object?> get props => [
    id,
    type,
    reviewsCount,
    available,
    guestNumber,
    bedrooms,
    endDate,
    startDate,
    bathrooms,
    beds,
    address,
    details,
    tags,
    pricePerNight,
    ownershipContract,
    medias,
    facilityLicense,
    isFavorite,
    totalRate,
    vendor,
    reservationCheckInDate,
    reservationGuestNumber,
    reservationId,
    reservationNumber,
    reservationStatus,
    reservationTotalPrice,
  ];
}
