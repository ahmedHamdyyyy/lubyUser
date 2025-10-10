import 'package:equatable/equatable.dart';

enum ReviewType { activity, property }

class ReviewModel extends Equatable {
  final String id, itemId, userId, userFirstName, userLastName, profilePicture, comment;
  final ReviewType type;
  final int rating;

  const ReviewModel({
    required this.id,
    required this.itemId,
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
    required this.profilePicture,
    required this.comment,
    required this.type,
    required this.rating,
  });

  static const initial = ReviewModel(
    id: '',
    itemId: '',
    userId: '',
    userFirstName: '',
    userLastName: '',
    profilePicture: '',
    comment: '',
    type: ReviewType.activity,
    rating: 0,
  );

  ReviewModel copyWith({
    String? id,
    String? itemId,
    String? userId,
    String? userFirstName,
    String? userLastName,
    String? profilePicture,
    String? comment,
    ReviewType? type,
    int? rating,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      userId: userId ?? this.userId,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      profilePicture: profilePicture ?? this.profilePicture,
      comment: comment ?? this.comment,
      type: type ?? this.type,
      rating: rating ?? this.rating,
    );
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json, ReviewType type) {
    return ReviewModel(
      id: json['_id'] ?? '',
      itemId: json[type == ReviewType.activity ? 'activityId' : 'propertyId'] ?? '',
      userId: json['userId'] is String ? json['userId'] : json['userId']?['_id'] ?? '',
      userFirstName: json['userId'] is String ? '' : json['userId']?['firstName'] ?? '',
      userLastName: json['userId'] is String ? '' : json['userId']?['lastName'] ?? '',
      profilePicture: json['userId'] is String ? '' : json['userId']?['profilePicture'] ?? '',
      comment: json['comment'] ?? '',
      type: type,
      rating: (json['rating'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'type': type.name.toString(),
    'itemId': itemId,
    'comment': comment,
    'rating': rating,
  };

  Map<String, dynamic> update() => {'comment': comment, 'rating': rating};

  @override
  List<Object?> get props => [id, itemId, userId, userFirstName, userLastName, comment, type, rating];
}
