import 'package:equatable/equatable.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../config/constants/constance.dart';

// ignore: constant_identifier_names
enum PropertyType { apartment, house, cabin, guest_house, studio, yacht, cruise }

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

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      formattedAddress: json['formattedAddress'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
      'formattedAddress': formattedAddress,
      'city': city,
      'state': state,
    };
  }

  @override
  List<Object?> get props => [longitude, latitude, formattedAddress, city, state];
}

class Vendor extends Equatable {
  final String id;
  final String firstName;
  final String profilePicture;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final String vendorRole;

  const Vendor({
    required this.id,
    required this.firstName,
    required this.profilePicture,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,

    required this.vendorRole,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      vendorRole: json['vendorRole'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, firstName, lastName, email, phone, role, profilePicture, vendorRole];
}

class CustomPropertyModel extends Equatable {
  final String id, type, image;
  final bool available, isFavorite;

  const CustomPropertyModel({
    required this.id,

    required this.isFavorite,
    required this.type,
    required this.image,
    required this.available,
  });

  CustomPropertyModel copyWith({
    String? vendorId,
    String? id,
    String? type,
    String? image,
    bool? available,
    bool? isFavorite,
  }) => CustomPropertyModel(
    id: id ?? this.id,
    type: type ?? this.type,

    image: image ?? this.image,
    available: available ?? this.available,
    isFavorite: isFavorite ?? this.isFavorite,
  );

  factory CustomPropertyModel.fromJson(Map<String, dynamic> json) {
    String getFirstMedia(dynamic medias) {
      if (medias == null) return '';
      if (medias is List && medias.isNotEmpty) {
        String mediaUrl = medias[0].toString();
        // Only prepend base URL if it's not already a full URL
        return mediaUrl.startsWith('http') ? mediaUrl : ApiConstance.baseUrl + mediaUrl;
      }
      if (medias is String) {
        return medias.startsWith('http') ? medias : ApiConstance.baseUrl + medias;
      }
      return '';
    }

    return CustomPropertyModel(
      id: json[AppConst.id] ?? '',

      type: json[AppConst.type] ?? '',
      image: getFirstMedia(json[AppConst.medias]),
      available: json[AppConst.available] ?? false,
      isFavorite: json[AppConst.isFavorite] ?? false,
    );
  }

  factory CustomPropertyModel.fromProperty(PropertyModel property) => CustomPropertyModel(
    id: property.id,
    type: property.type,
    image:
        property.medias.isNotEmpty
            ? (property.medias.first.startsWith('http')
                ? property.medias.first
                : ApiConstance.baseUrl + property.medias.first)
            : '',
    available: property.available,

    isFavorite: false, // Default to false, can be updated later
  );

  @override
  List<Object> get props => [id, type, image, available, isFavorite];
}

class PropertyModel extends Equatable {
  final String id, type, details, reviewId, comment, endDate, startDate;
  final int guestNumber, bedrooms, bathrooms, beds, maxDays;
  final List<String> tags, medias, ownershipContract, facilityLicense;
  final bool available, isFavorite;
  final double rate, pricePerNight;
  final Vendor vendorId;
  final Address address;

  const PropertyModel({
    required this.id,
    required this.endDate,
    required this.startDate,
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

    required this.maxDays,
    required this.ownershipContract,
    required this.medias,
    required this.facilityLicense,
    required this.isFavorite,
    required this.reviewId,
    required this.comment,
    required this.rate,
    required this.vendorId,
  });

  static const initial = PropertyModel(
    id: '',
    type: '',
    available: true,
    guestNumber: 0,
    bedrooms: 0,
    endDate: '',
    startDate: '',
    bathrooms: 0,
    beds: 0,
    address: Address(longitude: 0.0, latitude: 0.0, formattedAddress: '', city: '', state: ''),
    details: '',
    tags: [],
    pricePerNight: 0,

    maxDays: 0,
    ownershipContract: [],
    facilityLicense: [],
    medias: [],
    isFavorite: false,
    reviewId: '',
    comment: '',
    rate: 0,
    vendorId: Vendor(id: '', firstName: '', lastName: '', email: '', phone: '', role: '', profilePicture: '', vendorRole: ''),
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
      bedrooms: json[AppConst.bedrooms] ?? 0,
      bathrooms: json[AppConst.bathrooms] ?? 0,
      beds: json[AppConst.beds] ?? 0,
      address: json[AppConst.address] != null 
          ? Address.fromJson(json[AppConst.address])
          : const Address(longitude: 0.0, latitude: 0.0, formattedAddress: '', city: '', state: ''),
      details: json[AppConst.details] ?? '',
      tags: parseStringOrList(json[AppConst.tags]),
      pricePerNight: (json[AppConst.pricePerNight] ?? 0.0).toDouble(),
      //availabeDates: parseStringOrList(json[AppConst.availableDates]),
      maxDays: json[AppConst.maxDays] ?? 0,
      ownershipContract: parseStringOrList(json[AppConst.ownershipContract]),
      facilityLicense: parseStringOrList(json[AppConst.facilityLicense]),
      medias: parseStringOrList(json[AppConst.medias]),
      isFavorite: json[AppConst.isFavorite] ?? false,
      reviewId: json[AppConst.reviewId] ?? '',
      comment: json[AppConst.comment] ?? '',
      rate: (json['averageRating'] ?? 0.0).toDouble(),
      vendorId:
          json[AppConst.vendorId] != null
              ? (json[AppConst.vendorId] is Map<String, dynamic>
                  ? Vendor.fromJson(json[AppConst.vendorId])
                  : Vendor(
                    id: json[AppConst.vendorId].toString(),
                    firstName: '',
                    lastName: '',
                    email: '',
                    phone: '',
                    role: '',
                    profilePicture: '',
                    vendorRole: '',
                  ))
              : Vendor(id: '', firstName: '', lastName: '', email: '', phone: '', role: '', profilePicture: '', vendorRole: ''),
    );
  }

  // Future<FormData> create() async {
  //   final formData = FormData();

  //   // Add basic fields
  //   formData.fields.addAll([
  //     MapEntry(AppConst.type, type),
  //     MapEntry(AppConst.available, available.toString()),
  //     MapEntry(AppConst.guestNumber, guestNumber.toString()),
  //     MapEntry(AppConst.bedrooms, bedrooms.toString()),
  //     MapEntry(AppConst.bathrooms, bathrooms.toString()),
  //     MapEntry(AppConst.beds, beds.toString()),
  //     MapEntry(AppConst.address, address),
  //     MapEntry(AppConst.details, details),
  //     MapEntry(AppConst.pricePerNight, pricePerNight.toString()),
  //     MapEntry(AppConst.maxDays, maxDays.toString()),
  //     MapEntry(AppConst.reviewId, reviewId),
  //     MapEntry(AppConst.comment, comment),
  //     MapEntry(AppConst.rate, rate.toString()),
  //   ]);

  //   for (final tag in tags) {
  //     formData.fields.add(MapEntry('tags[]', tag));
  //   }
  //   for (final date in availableDates) {
  //     formData.fields.add(MapEntry('availableDates[]', date));
  //   }

  //   // Add files with proper content types
  //   try {
  //     // Add ownership contract files
  //     for (final filePath in ownershipContract) {
  //       if (filePath.isNotEmpty) {
  //         final file = File(filePath);
  //         if (await file.exists()) {
  //           formData.files.add(
  //             MapEntry(
  //               AppConst.ownershipContract,
  //               await MultipartFile.fromFile(
  //                 filePath,
  //                 filename: filePath.split('/').last,
  //                 contentType: MediaType('application', 'pdf'),
  //               ),
  //             ),
  //           );
  //         }
  //       }
  //     }

  //     // Add facility license files
  //     for (final filePath in facilityLicense) {
  //       if (filePath.isNotEmpty) {
  //         final file = File(filePath);
  //         if (await file.exists()) {
  //           formData.files.add(
  //             MapEntry(
  //               'facilityLicense',
  //               await MultipartFile.fromFile(
  //                 filePath,
  //                 filename: Random().nextInt(1000).toString(),
  //                 contentType: MediaType('application', 'pdf'),
  //               ),
  //             ),
  //           );
  //         }
  //       }
  //     }

  //     // Add media files
  //     for (final filePath in medias) {
  //       if (filePath.isNotEmpty) {
  //         final file = File(filePath);
  //         if (await file.exists()) {
  //           final extension = filePath.split('.').last.toLowerCase();
  //           final contentType = extension == 'png' ? 'png' : 'jpeg';
  //           formData.files.add(
  //             MapEntry(
  //               AppConst.medias,
  //               await MultipartFile.fromFile(
  //                 filePath,
  //                 filename: filePath.split('/').last,
  //                 contentType: MediaType('image', contentType),
  //               ),
  //             ),
  //           );
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     debugPrint('Error preparing files: $e');
  //     rethrow;
  //   }

  //   return formData;
  // }

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
    //List<String>? availableDates,
    int? maxDays,
    List<String>? ownershipContract,
    List<String>? facilityLicense,
    List<String>? medias,
    bool? isFavorite,
    String? reviewId,
    String? comment,
    String? endDate,
    String? startDate,
    double? rate,
    Vendor? vendorId,
  }) {
    return PropertyModel(
      id: id ?? this.id,
      endDate: endDate ?? this.endDate,
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
      //availableDates: availableDates ?? this.availableDates,
      maxDays: maxDays ?? this.maxDays,
      ownershipContract: ownershipContract ?? this.ownershipContract,
      medias: medias ?? this.medias,
      isFavorite: isFavorite ?? this.isFavorite,
      reviewId: reviewId ?? this.reviewId,
      comment: comment ?? this.comment,
      rate: rate ?? this.rate,
      vendorId: vendorId ?? this.vendorId,
    );
  }

  @override
  List<Object?> get props => [
    id,
    type,
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
    //availableDates,
    maxDays,
    ownershipContract,
    medias,
    facilityLicense,
    isFavorite,
    reviewId,
    comment,
    rate,
    vendorId,
  ];
}
