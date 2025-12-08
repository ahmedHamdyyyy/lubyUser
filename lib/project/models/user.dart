import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../config/constants/constance.dart';

class UserModel extends Equatable {
  final String firstName, lastName, email, phone, id, profilePicture;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.profilePicture,
  });

  static const initial = UserModel(firstName: '', lastName: '', email: '', id: '', phone: '', profilePicture: '');

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? id,
    String? profilePicture,
  }) => UserModel(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    profilePicture: profilePicture ?? this.profilePicture,
  );

  Future<FormData> signUp() async => FormData.fromMap({
    AppConst.firstName: firstName,
    AppConst.lastName: lastName,
    AppConst.email: email,
    AppConst.phone: phone,
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
  );

  String toCache() => jsonEncode({
    AppConst.id: id,
    AppConst.firstName: firstName,
    AppConst.lastName: lastName,
    AppConst.email: email,
    AppConst.phone: phone,
    AppConst.profilePicture: profilePicture,
  });

  factory UserModel.fromCache(String user) => UserModel.fromJson(jsonDecode(user) as Map<String, dynamic>);

  @override
  List<Object?> get props => [id, firstName, lastName, email, phone, profilePicture];
}
