// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Vendor extends Equatable {
  final String id;
  final String firstName;
  final String profilePicture;
  final String lastName;
  final String email;

  const Vendor({
    required this.id,
    required this.firstName,
    required this.profilePicture,
    required this.lastName,
    required this.email,
  });

  static const initial = Vendor(id: '', firstName: '', lastName: '', email: '', profilePicture: '');

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      email: json['email'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, firstName, lastName, email, profilePicture];

  Vendor copyWith({String? id, String? firstName, String? profilePicture, String? lastName, String? email}) {
    return Vendor(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      profilePicture: profilePicture ?? this.profilePicture,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
    );
  }
}
