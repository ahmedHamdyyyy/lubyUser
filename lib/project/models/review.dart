import 'package:equatable/equatable.dart';

enum ReviewType { activity, property }

class ReviewModel extends Equatable {
  final String id, itemId, userId, userFirstName, userLastName, comment;
  final ReviewType type;
  final int rating;

  const ReviewModel({
    required this.id,
    required this.itemId,
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
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
      comment: comment ?? this.comment,
      type: type ?? this.type,
      rating: rating ?? this.rating,
    );
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json, ReviewType type) => ReviewModel(
    id: json['_id'] ?? '',
    itemId: json[type == ReviewType.activity ? 'activityId' : 'propertyId'] ?? '',
    userId: json['userId']['_id'] ?? '',
    userFirstName: json['userId']['firstName'] ?? '',
    userLastName: json['userId']['lastName'] ?? '',
    comment: json['comment'] ?? '',
    type: type,
    rating: (json['rating'] as num?)?.toInt() ?? 0,
  );

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
