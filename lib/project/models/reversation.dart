import 'package:equatable/equatable.dart';

import 'activity.dart';
import 'property.dart';

enum ReservationType { activity, property }

enum ReservationStatus { draft, completed }

class ReservationModel extends Equatable {
  final String id, checkInDate, checkOutDate;
  final ReservationType type;
  final ReservationStatus status;
  final int guestNumber, registrationNumber;
  final double totalPrice, totalPriceAfterFees;
  final Object item;

  const ReservationModel({
    required this.id,
    required this.checkInDate,
    required this.checkOutDate,
    required this.type,
    required this.status,
    required this.guestNumber,
    required this.registrationNumber,
    required this.totalPrice,
    required this.totalPriceAfterFees,
    required this.item,
  });

  static const initial = ReservationModel(
    id: '',
    checkInDate: '',
    checkOutDate: '',
    type: ReservationType.property,
    status: ReservationStatus.draft,
    guestNumber: 1,
    registrationNumber: 0,
    totalPrice: 0.0,
    totalPriceAfterFees: 0.0,
    item: '',
  );

  ReservationModel copyWith({
    String? id,
    String? checkInDate,
    String? checkOutDate,
    ReservationType? type,
    ReservationStatus? status,
    int? guestNumber,
    int? registrationNumber,
    double? totalPrice,
    double? totalPriceAfterFees,
    Object? item,
  }) => ReservationModel(
    id: id ?? this.id,
    checkInDate: checkInDate ?? this.checkInDate,
    checkOutDate: checkOutDate ?? this.checkOutDate,
    type: type ?? this.type,
    status: status ?? this.status,
    registrationNumber: registrationNumber ?? this.registrationNumber,
    guestNumber: guestNumber ?? this.guestNumber,
    totalPrice: totalPrice ?? this.totalPrice,
    totalPriceAfterFees: totalPriceAfterFees ?? this.totalPriceAfterFees,
    item: item ?? this.item,
  );

  Map<String, dynamic> toMap() => {
    'type': type.name,
    if (type == ReservationType.property) ...{
      'propertyId': (item as PropertyModel).id,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
    } else ...{
      'activityId': (item as ActivityModel).id,
      'guestNumber': guestNumber,
    },
  };

  factory ReservationModel.fromMap(Map<String, dynamic> map, {Object? item}) {
    final type = map['type'] == 'activity' ? ReservationType.activity : ReservationType.property;

    return ReservationModel(
      id: map['_id'] ?? '',
      type: type,
      checkInDate:
          item is ActivityModel
              ? item.date
              : type == ReservationType.property
              ? map['checkInDate'] ?? ''
              : (map['activityId']?['date'] ?? (item as ActivityModel?)?.date ?? ''),
      checkOutDate: map['checkOutDate'] ?? '',
      status: map['status'] == 'draft' ? ReservationStatus.draft : ReservationStatus.completed,
      guestNumber: map['guestNumber'] ?? 1,
      registrationNumber: map['registrationNumber'] ?? 0,
      totalPrice: (map['totalPrice'] as num?)?.toDouble() ?? 0.0,
      totalPriceAfterFees: (map['totalPriceAfterFees'] as num?)?.toDouble() ?? 0.0,
      item:
          item ??
          (type == ReservationType.property
              ? PropertyModel.fromJson(map['propertyId'] ?? {})
              : ActivityModel.fromJson(map['activityId'] ?? {})),
    );
  }

  @override
  List<Object?> get props => [
    id,
    checkInDate,
    checkOutDate,
    type,
    status,
    guestNumber,
    registrationNumber,
    totalPrice,
    totalPriceAfterFees,
    item,
  ];
}
