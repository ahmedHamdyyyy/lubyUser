import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../config/constants/constance.dart';

class UserModel extends Equatable {
  final String firstName,
      lastName,
      email,
      phone,
      id,
      profilePicture,
      dateOfBirth,
      nationalIdNumber,
      residenceNumber,
      passportNumber;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.profilePicture,
    required this.dateOfBirth,
    required this.nationalIdNumber,
    required this.residenceNumber,
    required this.passportNumber,
  });

  static const initial = UserModel(
    firstName: '',
    lastName: '',
    email: '',
    id: '',
    phone: '',
    profilePicture: '',
    dateOfBirth: '',
    nationalIdNumber: '',
    residenceNumber: '',
    passportNumber: '',
  );

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? id,
    String? profilePicture,
    String? dateOfBirth,
    String? nationalIdNumber,
    String? residenceNumber,
    String? passportNumber,
  }) => UserModel(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    profilePicture: profilePicture ?? this.profilePicture,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    nationalIdNumber: nationalIdNumber ?? this.nationalIdNumber,
    residenceNumber: residenceNumber ?? this.residenceNumber,
    passportNumber: passportNumber ?? this.passportNumber,
  );

  Future<FormData> signUp() async => FormData.fromMap({
    AppConst.firstName: firstName,
    AppConst.lastName: lastName,
    AppConst.email: email,
    AppConst.phone: phone,
    AppConst.dateOfBirth: dateOfBirth,
    if (nationalIdNumber.isNotEmpty) AppConst.nationalIdNumber: nationalIdNumber,
    if (residenceNumber.isNotEmpty) AppConst.residenceNumber: residenceNumber,
    if (passportNumber.isNotEmpty) AppConst.passportNumber: passportNumber,
    if (profilePicture.isNotEmpty)
      AppConst.profilePicture: await MultipartFile.fromFile(
        profilePicture,
        filename: profilePicture.split('/').last.split('.').first,
        contentType: DioMediaType('image', profilePicture.split('.').last),
      ),
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    firstName: json[AppConst.firstName] ?? '',
    lastName: json[AppConst.lastName] ?? '',
    email: json[AppConst.email] ?? '',
    phone: json[AppConst.phone] ?? '',
    id: json[AppConst.id] ?? '',
    profilePicture: json[AppConst.profilePicture] ?? '',
    dateOfBirth: json[AppConst.dateOfBirth] ?? '',
    nationalIdNumber: json[AppConst.nationalIdNumber] ?? '',
    residenceNumber: json[AppConst.residenceNumber] ?? '',
    passportNumber: json[AppConst.passportNumber] ?? '',
  );

  String toCache() => jsonEncode({
    AppConst.id: id,
    AppConst.firstName: firstName,
    AppConst.lastName: lastName,
    AppConst.email: email,
    AppConst.phone: phone,
    AppConst.profilePicture: profilePicture,
    AppConst.dateOfBirth: dateOfBirth,
    AppConst.nationalIdNumber: nationalIdNumber,
    AppConst.residenceNumber: residenceNumber,
    AppConst.passportNumber: passportNumber,
  });

  factory UserModel.fromCache(String user) => UserModel.fromJson(jsonDecode(user) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    phone,
    profilePicture,
    dateOfBirth,
    nationalIdNumber,
    residenceNumber,
    passportNumber,
  ];
}
